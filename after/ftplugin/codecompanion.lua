-- after/ftplugin/codecompanion.lua

_G.companion_buf_list = _G.companion_buf_list or {}

local function set_header_str(bufnr)
    -- Use buffer-scoped vars for this specific buffer
    local b = vim.b[bufnr] or {}

    local session_type = b.codecompanion_session_type or "General"
    local session_model = b.codecompanion_model or "Unknown"

    local header = {
        "┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓",
        "┃  Code Companion                    ┃",
        "┠────────────────────────────────────┨",
        "┃ Session Type : " .. "",
        "┃ Model        : " .. "",
        "┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛",
        "",
    }

    -- Make sure buffer is modifiable while we write
    local was_modifiable = vim.bo[bufnr].modifiable
    if not was_modifiable then
        vim.bo[bufnr].modifiable = true
    end

    -- Insert at the top of the buffer
    vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, header)

    -- Restore original modifiable state
    if not was_modifiable then
        vim.bo[bufnr].modifiable = false
    end
end

-- Autocmd: run AFTER CodeCompanion has created/opened the chat buffer
local group = vim.api.nvim_create_augroup("CompanionHeader", { clear = true })

vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = { "CodeCompanionChatCreated", "CodeCompanionChatOpened" },
    callback = function(ev)
        local bufnr = ev.buf

        -- Only run once per buffer
        if _G.companion_buf_list[bufnr] then
            return
        end
        _G.companion_buf_list[bufnr] = true

        -- Defer to make sure CodeCompanion is fully done touching the buffer
        vim.schedule(function()
            if not vim.api.nvim_buf_is_valid(bufnr) then
                return
            end
            if vim.bo[bufnr].filetype ~= "codecompanion" then
                return
            end

            set_header_str(bufnr)
        end)
    end,
})

vim.api.nvim_buf_set_keymap(0, "n", "<space>bk", ":CodeCompanionChat Toggle<cr>", {
    noremap = true,
    silent = true,
    desc = "codecompanion-chat-toggle",
})
