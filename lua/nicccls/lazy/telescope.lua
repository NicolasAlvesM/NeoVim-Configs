return {
    'nvim-telescope/telescope.nvim', tag = 'v0.2.0',
    dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
        require('telescope').setup({
           -- extensions = {
             --   fzf = {
               --      fuzzy = true,                    -- false will only do exact matching
                 --    override_generic_sorter = true,  -- override the generic sorter
                   --  override_file_sorter = true,     -- override the file sorter
                    -- case_mode = "smart_case",        -- or "ignore_case" or "respect_case"                                                 -- the default case_mode is "smart_case"
             --   }
            --}
        })
 --       require('telescope').load_extension('fzf')


local harpoon = require('harpoon')
harpoon:setup({})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })





        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<C-f>', function()
            local word = vim.fn.expand("<cword>")
            require('telescope.builtin').current_buffer_fuzzy_find({ default_text = word, case_sensitive = true })
        end)
        vim.keymap.set('n', '<leader><C-f>', function()
            local current_line = vim.fn.getline(".")
            current_line = vim.fn.trim(current_line)
            require('telescope.builtin').current_buffer_fuzzy_find({ default_text = current_line, case_sensitive = true })
        end)
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            require('telescope.builtin').grep_string({ default_text = word, case_sensitive = true })
        end)
        vim.keymap.set('n', '<leader>PWS', function()
            local current_line = vim.fn.getline(".")
            current_line = vim.fn.trim(current_line)
            builtin.grep_string({ search = current_line, case_sensitive = true })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}
