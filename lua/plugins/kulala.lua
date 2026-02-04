-- lua/plugins/kulala.lua

local function setup_kulala_config()
    local kulala = require("kulala")
    local kulala_ui = require("kulala.ui")

    local opts = {
        -- cURL path
        -- if you have curl installed in a non-standard path,
        -- you can specify it here
        curl_path = "curl",
        -- additional cURL options
        -- see: https://curl.se/docs/manpage.html
        additional_curl_options = {},
        -- gRPCurl path, get from https://github.com/fullstorydev/grpcurl.git
        grpcurl_path = "grpcurl",
        -- websocat path, get from https://github.com/vi/websocat.git
        websocat_path = "websocat",
        -- openssl path
        openssl_path = "openssl",

        -- set scope for environment and request variables
        -- possible values: b = buffer, g = global
        environment_scope = "b",
        -- dev, test, prod, can be anything
        -- see: https://learn.microsoft.com/en-us/aspnet/core/test/http-files?view=aspnetcore-8.0#environment-files
        default_env = "dev",
        -- enable reading vscode rest client environment variables
        vscode_rest_client_environmentvars = false,

        -- default timeout for the request, set to nil to disable
        request_timeout = nil,
        -- continue running requests when a request failure is encountered
        halt_on_error = true,

        -- certificates
        certificates = {},
        -- Specify how to escape query parameters
        -- possible values: always, skipencoded = keep %xx as is
        urlencode = "always",

        -- Infer content type from the body and add it to the request headers
        infer_content_type = true,

        -- default formatters/pathresolver for different content types
        contenttypes = {
            ["application/json"] = {
                ft = "json",
                formatter = vim.fn.executable("jq") == 1 and { "jq", "." },
                pathresolver = function(...)
                    return require("kulala.parser.jsonpath").parse(...)
                end,
            },
            ["application/graphql"] = {
                ft = "graphql",
                formatter = vim.fn.executable("prettier") == 1
                    and { "prettier", "--stdin-filepath", "graphql", "--parser", "graphql" },
                pathresolver = nil,
            },
            ["application/xml"] = {
                ft = "xml",
                formatter = vim.fn.executable("xmllint") == 1 and { "xmllint", "--format", "-" },
                pathresolver = vim.fn.executable("xmllint") == 1 and { "xmllint", "--xpath", "{{path}}", "-" },
            },
            ["text/html"] = {
                ft = "html",
                formatter = vim.fn.executable("xmllint") == 1 and { "xmllint", "--format", "--html", "-" },
                pathresolver = nil,
            },
        },

        scripts = {
            -- Resolves "NODE_PATH" environment variable for node scripts. Defaults to the first "node_modules" directory found upwards from "script_file_dir".
            node_path_resolver = nil, ---@type fun(http_file_dir: string, script_file_dir: string, script_data: ScriptData): string|nil
        },

        ui = {
            ---@type "split" | "float"
            display_mode = "float",
            ---@type "vertical" | "horizontal"
            split_direction = "vertical",
            -- window options to override win_config: width/height/split/vertical.., buffer/window options
            win_opts = { bo = {}, wo = {} }, ---@type kulala.ui.win_config
            -- default view: "body" or "headers" or "headers_body" or "verbose" or fun(response: Response)
            default_view = "body", ---@type "body"|"headers"|"headers_body"|"verbose"|fun(response: Response)
            -- enable winbar
            winbar = true,
            -- Specify the panes to be displayed by default
            -- Current available pane contains { "body", "headers", "headers_body", "script_output", "stats", "verbose", "report", "help" },
            default_winbar_panes = { "body", "headers", "headers_body", "verbose", "script_output", "report", "help" },
            -- enable/disable variable info text
            -- this will show the variable name and value as float
            ---@type false | "float"
            show_variable_info_text = false,
            -- icons position: "signcolumn"|"on_request"|"above_request"|"below_request" or nil to disable
            ---@type "signcolumn"|"on_request"|"above_request"|"below_request" or nil to disable
            show_icons = "on_request",
            -- default icons
            icons = {
                inlay = {
                    loading = " ",
                    done = " ",
                    error = " ",
                },
                lualine = "🐼",
                textHighlight = "WarningMsg", -- highlight group for request elapsed time
            },

            -- highlight groups for http syntax highlighting
            ---@type table<string, string|vim.api.keyset.highlight>
            syntax_hl = {
                ["@punctuation.bracket.kulala_http"] = "Number",
                ["@character.special.kulala_http"] = "Special",
                ["@operator.kulala_http"] = "Special",
                ["@variable.kulala_http"] = "String",
            },

            -- enable/disable request summary in the output window
            show_request_summary = true,
            -- disable notifications of script output
            disable_script_print_output = false,

            report = {
                ---@type true | false | "on_error"
                show_script_output = true,
                ---@type true | false | "on_error" | "failed_only"
                show_asserts_output = true,
                ---@type true | false | "on_error"
                show_summary = true,

                headersHighlight = "Special",
                successHighlight = "String",
                errorHighlight = "Error",
            },

            -- scratchpad default contents
            scratchpad_default_contents = {
                "### Scratchpad",
                "",
                "@MY_TOKEN_NAME=my_token_value",
                "",
                "# @name scratchpad",
                "# @jq .",
                "POST https://httpbin.org/post HTTP/1.1",
                "accept: application/json",
                "content-type: application/json",
                "",
                "{",
                '  "foo": "bar"',
                "}",
            },

            disable_news_popup = false,

            -- enable/disable lua syntax highlighting
            lua_syntax_hl = true,

            -- Settings for pickers used for Environment, Authentication and Requests Managers
            pickers = {
                snacks = {
                    layout = function()
                        local has_snacks, snacks_picker = pcall(require, "snacks.picker")
                        return not has_snacks and {}
                            or vim.tbl_deep_extend("force", snacks_picker.config.layout("telescope"), {
                                reverse = true,
                                layout = {
                                    { { win = "list" }, { height = 1, win = "input" }, box = "vertical" },
                                    { win = "preview", width = 0.6 },
                                    box = "horizontal",
                                    width = 0.8,
                                },
                            })
                    end,
                },
            },
        },

        lsp = {
            -- enable/disable built-in LSP server
            enable = true,

            ---@type boolean|table
            keymaps = false,

            -- enable/disable/customize HTTP formatter
            formatter = {
                sort = { -- enable/disable alphabetical sorting in request body
                    metadata = true,
                    variables = true,
                    commands = false,
                    json = true,
                },
            },

            on_attach = nil, -- function called when Kulala LSP attaches to the buffer
        },

        -- enable/disable debug mode
        debug = 3,
        -- enable/disable bug reports on error
        generate_bug_report = false,

        -- set to true to enable default keymaps (check docs or {plugins_path}/kulala.nvim/lua/kulala/config/keymaps.lua for details)
        -- or override default keymaps as shown in the example below.
        ---@type boolean|table
        global_keymaps = {
            ["search-request"] = { "<leader>;/", kulala.search, ft = { "http", "rest" } },
            ["auth-config"] = {
                "<leader>;A",
                require("kulala.ui.auth_manager").open_auth_config,
                ft = { "http", "rest" },
            },
            ["run-all-requests"] = { "<leader>;a", kulala.run_all, ft = { "http", "rest" }, mode = { "n", "v" } },
            ["copy-as-curl"] = { "<leader>;c", kulala.copy, ft = { "http", "rest" } },
            ["paste-from-curl"] = { "<leader>;C", kulala.from_curl, ft = { "http", "rest" } },
            ["select-env"] = { "<leader>;e", kulala.set_selected_env, ft = { "http", "rest" } },
            ["export-buffer"] = { "<leader>;E", kulala.export, ft = { "http", "rest" } },
            ["graphql-schema-download"] = { "<leader>;g", kulala.download_graphql_schema, ft = { "http", "rest" } },
            ["inspect-request"] = { "<leader>;i", kulala.inspect, ft = { "http", "rest" } },
            ["import-path"] = {
                "<leader>;I",
                function()
                    vim.ui.select({ "kulala", "postman", "bruno" }, {
                        prompt = "Choose Service:",
                        format_item = function(item)
                            return item
                        end,
                    }, function(service)
                        kulala.import(service)
                    end)
                end,
                ft = { "http", "rest" },
            },
            ["open-cookies-jar"] = { "<leader>;j", kulala.open_cookies_jar, ft = { "http", "rest" } },
            ["open-kulala"] = { "<leader>;o", kulala.open, ft = { "http", "rest" } },
            ["export-path"] = {
                "<leader>;p",
                function()
                    vim.ui.input({ prompt = "Enter path: " }, function(path)
                        if path == nil then
                            vim.notify("kulala: export path not provided")
                            return
                        end
                        kulala.export(path)
                    end)
                end,
                ft = { "http", "rest" },
            },
            ["run-current-request"] = { "<leader>;r", kulala.run, ft = { "http", "rest" }, mode = { "n", "v" } },
            ["terminate-current-request"] = {
                "<leader>;t",
                kulala_ui.interrupt_requests,
                ft = { "http", "rest" },
                mode = { "n", "v" },
            },
            ["clear-globals"] = { "<leader>;x", kulala.scripts_clear_global, ft = { "http", "rest" } },
            ["clear-cached-files"] = { "<leader>;X", kulala.clear_cached_files, ft = { "http", "rest" } },
        },

        -- Prefix for global keymaps
        global_keymaps_prefix = "<leader>'",

        -- Kulala UI keymaps, override with custom keymaps as required (check docs or {plugins_path}/kulala.nvim/lua/kulala/config/keymaps.lua for details)
        ---@type boolean|table
        kulala_keymaps = {
            ["Show headers"] = { "gh", kulala_ui.show_headers },
            ["Show verbose"] = { "gv", kulala_ui.show_verbose },
            ["Show stats"] = { "gs", kulala_ui.show_stats },
            ["Close"] = { "q", kulala_ui.close_kulala_buffer },
            ["Toggle split/float"] = { "\\", kulala_ui.toggle_display_mode },
            ["Show news"] = { "gN", kulala_ui.show_news },
            ["Show help"] = { "?", kulala_ui.show_help },
            ["Interrupt requests"] = { "<C-c>", kulala_ui.interrupt_requests },
            ["Send WS message"] = { "<S-CR>", require("kulala.cmd.websocket").send },
            ["Clear responses history"] = { "X", kulala_ui.clear_responses_history },
            ["Jump to response"] = { "<cr>", kulala_ui.get_current_response_pos },
            ["Previous response"] = { "[", kulala_ui.show_previous },
            ["Next response"] = { "]", kulala_ui.show_next },
            -- FIX: JQ filter not working
            ["show-filter"] = {
                "gf",
                function()
                    kulala_ui.toggle_filter()
                end,
            },
            ["Show report"] = { "gr", kulala_ui.show_report },
            ["Show script output"] = { "go", kulala_ui.show_script_output },
            ["Show headers and body"] = { "ga", kulala_ui.show_headers_body },
            ["Show body"] = { "gb", kulala_ui.show_body },
        },

        kulala_keymaps_prefix = "",
    }

    kulala.setup(opts)
end

return {
    {
        "mistweaverco/kulala.nvim",
        keys = function()
            local kulala = require("kulala")
            return {
                { "<leader>ok", kulala.scratchpad, desc = "kulala-scratchpad" },
                { "<leader>oK", kulala.open, desc = "kulala-open" },
                { "<leader>rlh", kulala.replay, desc = "kulala-last-request" },
            }
        end,
        ft = { "http", "rest" },
        opts = {},
        config = setup_kulala_config,
    },
}
