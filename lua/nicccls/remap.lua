
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<M-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<C-Up>", "[{")
vim.keymap.set("n", "<C-Down>", "]}")

vim.keymap.set("n", "<C-M-J>", "yy<Cmd>put<CR>")
vim.keymap.set("n", "<C-M-K>", "yyP")
vim.keymap.set("v", "<C-M-J>", "y`><Cmd>put<CR>gv")
vim.keymap.set("v", "<C-M-K>", "y`<<Cmd>put!<CR>gv")

vim.keymap.set("n", "<leader>b", "<C-O>")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "=ap", "ma=ap'a")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("n", "<C-c>", [["+yiw]])
vim.keymap.set("v", "<C-c>", [["+Y]])

vim.keymap.set("n", "<C-z>", "u")
vim.keymap.set("n", "<C-y>", "<C-r>")

vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-t>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<S-M-f>", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<leader>EN", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>EP", "<cmd>lprev<CR>zz")
vim.keymap.set('n', '<leader>ce', ':cclose<CR>')
vim.keymap.set('n', '<leader>oe', ':copen<CR>')

vim.keymap.set("n", "<C-D>", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

vim.keymap.set(
    "n",
    "<leader>ef",
    "oif err != nil {<CR>}<Esc>Olog.Fatalf(\"error: %s\\n\", err.Error())<Esc>jj"
)

vim.keymap.set(
    "n",
    "<leader>el",
    "oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i"
)

vim.keymap.set("n", "<leader>mr", function()
    require("cellular-automaton").start_animation("make_it_rain")
end)

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.g.VM_maps = {
    ['Find Under'] = '<C-d>',
    ['Find Subword Under'] = '<C-d>',
    ['Select All'] = '<leader><C-d>',
    ['Skip Region'] = '<C-x>',
    ['Remove Region'] = '<C-p>'
}

vim.keymap.set('n', '<C-d>', '<Nop>')
vim.keymap.set('v', '<C-d>', '<Nop>')

vim.keymap.set("n", "<leader>cf", function()
    local current_dir = vim.fn.expand("%:p:h")

    local filename = vim.fn.input("Nome do arquivo: ", current_dir .. "/", "file")

    if filename == "" then
        return
    end

    local dir = vim.fn.fnamemodify(filename, ":h")
    if vim.fn.isdirectory(dir) == 0 then
        vim.fn.mkdir(dir, "p")
    end

    vim.cmd("edit " .. filename)

    vim.cmd("write")

    print("Arquivo criado: " .. filename)
end)

vim.keymap.set("n", "<leader>rn", function()
    local current_buffer = vim.api.nvim_get_current_buf()
    local current_file = vim.api.nvim_buf_get_name(current_buffer)
    local current_dir = vim.fn.fnamemodify(current_file, ":h")
    local current_name = vim.fn.fnamemodify(current_file, ":t")

    print("Arquivo atual: " .. current_file)

    if vim.api.nvim_buf_get_option(current_buffer, "modified") then
        vim.cmd("write")
    end

    local new_name = vim.fn.input("Novo nome: ", current_name, "file")

    if new_name == "" or new_name == current_name then
        print("Operação cancelada ou mesmo nome.")
        return
    end

    local new_path = current_dir .. "/" .. new_name

    if vim.fn.filereadable(new_path) == 1 then
        local choice = vim.fn.input("Arquivo já existe. Substituir? (s/n): ")
        if choice:lower() ~= "s" then
            print("Operação cancelada.")
            return
        end
    end

    local cmd = string.format("mv '%s' '%s'",
        current_file:gsub("'", "'\\''"),
        new_path:gsub("'", "'\\''"))

    print("Executando comando: " .. cmd)
    local output = vim.fn.system(cmd)
    local success = vim.v.shell_error == 0

    if success then
        vim.cmd("edit! " .. vim.fn.fnameescape(new_path))

        vim.cmd("bwipeout " .. current_buffer)

        print("Arquivo renomeado com sucesso para: " .. new_name)
    else
        print("Erro ao renomear: " .. output)
    end
end)

vim.keymap.set("n", "<leader>df", function()
    local current_file = vim.fn.expand("%")
    local current_path = vim.fn.expand("%:p")

    print("Tentando excluir: " .. current_file)

    local choice = vim.fn.input("Tem certeza que deseja excluir '" .. current_file .. "'? (s/n): ")
    if choice:lower() ~= "s" then
        print("Operação cancelada.")
        return
    end

    local ok, err = pcall(function()
        vim.cmd("bdelete!")

        os.execute("rm '" .. current_path:gsub("'", "'\\''") .. "'")
    end)

    if ok then
        print("Arquivo excluído: " .. current_file)
    else
        print("Erro ao excluir o arquivo: " .. tostring(err))
    end
end)

