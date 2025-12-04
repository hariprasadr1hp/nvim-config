-- after/plugin/ask.lua

if vim.g.vscode then
    return
end

local keymap_set = require("config.helpers").keymap_set

local function open_browser(url)
    vim.fn.jobstart({ "open", url }, { detach = true })
end

local prompt_choices = {
    "(custom message)",
    "explain the following code:",
    "correct the following code:",
    "improve the following code:",
    "convert the following code to",
    "debug the following code:",
    "need to write tests for the following code:",
}

local language_choices = {
    "bash",
    "go",
    "haskell",
    "javascript",
    "lua",
    "python",
    "rust",
    "sql",
    "typescript",
}

local function select_prompt(on_choice)
    vim.ui.select(prompt_choices, {
        prompt = "Choose Prompt",
        format_item = function(item)
            return item
        end,
    }, function(choice)
        if choice then
            on_choice(choice)
        end
    end)
end

local function select_language(on_choice)
    vim.ui.select(language_choices, {
        prompt = "Target Language",
        format_item = function(item)
            return item
        end,
    }, function(choice)
        if choice then
            on_choice(choice)
        end
    end)
end

function HP._finalize_ai_prompt(prompt, code)
    local template_str = "%s\n```%s\n%s\n```"
    local formatted = string.format(template_str, prompt, vim.bo.filetype, code)

    vim.fn.setreg("+", formatted)

    -- TODO: to confirm the formatted prompt string using a floating window
    -- 1. make changes, if necessary
    -- 2. `gy` to yank the whole thing
    -- 3. `q` to quit, and only then the next block of code is executed
    -- HP.as_floating_window(formatted)

    if vim.env.CHATGPT_URL then
        open_browser(vim.env.CHATGPT_URL)
    else
        vim.notify("URL not set", vim.log.levels.ERROR)
    end
end

function HP.ask_ai()
    local lines = table.concat(HP.GetTextFromVisual(), "\n")
    select_prompt(function(prompt)
        if prompt == "convert the following code to" then
            select_language(function(lang)
                local final_prompt = string.format("%s `%s`:", prompt, lang)
                HP._finalize_ai_prompt(final_prompt, lines)
            end)
        elseif prompt == "(custom message)" then
            HP._finalize_ai_prompt("", lines)
        else
            HP._finalize_ai_prompt(prompt, lines)
        end
    end)
end

keymap_set("x", "<leader>aq", HP.ask_ai, "ask-ai")
