-- after/ftplugin/pdftext.lua

local filename = vim.fn.expand("%:p")

if vim.fn.filereadable(filename) == 1 then
    local output = vim.fn.systemlist({ "pdftotext", filename, "-" })

    vim.cmd("silent! %delete _")

    if vim.v.shell_error == 0 then
        vim.api.nvim_buf_set_lines(0, 0, -1, false, output)
    else
        vim.api.nvim_buf_set_lines(0, 0, -1, false, {
            " Failed to convert PDF to text.",
            "Make sure `pdftotext` is installed and the file is not encrypted or corrupted.",
        })
    end

    vim.opt_local.buftype = "nofile"
    vim.opt_local.bufhidden = "hide"
    vim.opt_local.swapfile = false
    vim.opt_local.readonly = true
end
