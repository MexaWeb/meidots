return {
    "nvim-treesitter/nvim-treesitter",
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        config = function()
        require("neo-tree").setup({
            filesystem = {
                filtered_items = {
                    visible = true,
                },
            },
        })
        vim.keymap.set({"n", "i"}, "<C-t>", "<cmd>Neotree toggle<CR>", { desc = "Toggle neo-tree" })
        end,
    },
    "nvim-lualine/lualine.nvim",
    "folke/which-key.nvim",
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {}
    },

    {
        "patstockwell/vim-monokai-tasty",
        name = "vim-monokai-tasty",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("vim-monokai-tasty")
        end,
    }
}
