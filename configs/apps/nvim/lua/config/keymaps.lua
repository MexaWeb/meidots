local keymap = vim.keymap.set

keymap({"n", "i"}, "<C-z>", "<cmd>wq<CR>", {desc = "Save and quit"})
