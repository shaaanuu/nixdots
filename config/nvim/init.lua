require("config.lazy")

-- Tab settings
vim.opt.tabstop = 2        -- Number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 2     -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true    -- Use spaces instead of tabs

-- Line numbers & Relative numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8 -- Keep 8 lines above/below cursor

-- Disable relative numbers in Insert mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function()
    vim.opt.relativenumber = false
  end,
})

-- Re-enable relative numbers when leaving Insert mode
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- Highlight settings
vim.cmd [[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
]]


