-- after/ftplugin/csv.lua

-- Custom captures configuration for CSV files in Neovim
local ts_configs = require("nvim-treesitter.configs")

---@diagnostic disable-next-line: missing-fields
ts_configs.setup({
	highlight = {
		enable = true,
		custom_captures = {
			["column_1"] = "TSRainbowCol1",
			["column_2"] = "TSRainbowCol2",
			["column_3"] = "TSRainbowCol3",
			["column_4"] = "TSRainbowCol4",
			["column_5"] = "TSRainbowCol5",
			["column_6"] = "TSRainbowCol6",
			["column_7"] = "TSRainbowCol7",
			["column_8"] = "TSRainbowCol8",
			["column_9"] = "TSRainbowCol9",
		},
	},
})

print("hello csv")
