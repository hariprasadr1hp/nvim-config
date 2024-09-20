-- tests/config_tests.lua

local function log_error(err)
	print("Test Failed: " .. err)
end

local function test_config_load()
	local ok, err = pcall(function()
		require("init")
	end)

	if not ok then
		log_error(err)
	else
		print("Config loaded successfully!")
	end
end

local function test_plugin_load(plugin_name)
	local ok, err = pcall(require, plugin_name)
	if not ok then
		log_error("Error loading plugin " .. plugin_name .. ": " .. err)
	else
		print(plugin_name .. " loaded successfully!")
	end
end

test_config_load()
test_plugin_load("nvim-treesitter") -- Example plugin
test_plugin_load("telescope") -- Example plugin
