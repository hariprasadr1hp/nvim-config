-- onedark



-- available themes (dark, darker, cool, deep, warm, warmer)
vim.g.onedark_style = 'warmer'

-- transparent background (default: false)
vim.g.onedark_transparent_background = true


-- italic comment (dafault: true)
vim.g.onedark_italic_comment = true

-- disable toggle style using shortcut (default: false)
vim.g.onedark_disable_toggle_style = true


-- disable terminal colors (default: false)
vim.g.onedark_disable_terminal_colors = false


-- use underline instead of undercurl for diagnostics (default: true)
vim.g.onedark_diagnostics_undercurl = true

-- make diagnostics look brighter (default: true)
vim.g.onedark_darker_diagnostics = false





-- setup theme
require('onedark').setup()


