return {

    {
        "nvim-lua/plenary.nvim",
        name = "plenary"
    },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    "eandrju/cellular-automaton.nvim",
}

