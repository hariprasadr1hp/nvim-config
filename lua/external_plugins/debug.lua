-- lua/hp-debug/init.lua
-- for more details, visit https://github.com/mfussenegger/nvim-dap


require('dap-python').setup('~/.pyenv/shims/python')
require('dap-python').test_runner = "pytest"


vim.cmd("command! DebugBreakPoint :lua require'dap'.toggle_breakpoint()")
vim.cmd("command! DebugContinue :lua require'dap'.continue()")
vim.cmd("command! DebugStepOver :lua require'dap'.step_over()")
vim.cmd("command! DebugStepInto :lua require'dap'.step_into()")
vim.cmd("command! DebugReplOpen :lua require'dap'.repl.open()")


