
-- Map ctrl-c to system clipboard
vim.opt.clipboard = "unnamedplus"
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy selection to system clipboard" })

-- 
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Copy selection to system clipboard" })
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Copy motion to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Copy line to system clipboard" })

require("config.lazy")
