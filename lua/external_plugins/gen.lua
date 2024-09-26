-- lua/external_plugins/gen.lua

local M = {}

M = {
	{
		"David-Kunz/gen.nvim",
		opts = {
			model = "deepseek-coder-v2:16b", -- The default model to use.
			quit_map = "q", -- set keymap for close the response window
			retry_map = "<c-r>", -- set keymap to re-send the current prompt
			accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
			host = "localhost", -- The host running the Ollama service.
			port = "11434", -- The port on which the Ollama service is listening.
			display_mode = "float", -- The display mode. Can be "float" or "split" or "horizontal-split".
			show_prompt = true, -- Shows the prompt submitted to Ollama.
			show_model = true, -- Displays which model you are using at the beginning of your chat session.
			no_auto_close = false, -- Never closes the window automatically.
			hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
			init = function(_)
				pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
			end,
			debug = false, -- Prints errors and the command which is run.
		},
	},
}

vim.api.nvim_create_user_command("SelectGenModel", function()
	require("gen").select_model()
end, {})

return M
