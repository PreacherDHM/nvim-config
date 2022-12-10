local M = {}

M.set = function(fileType, command)
    if vim.bo.filetype == fileType then
        print("Building Code...")
        --setting window
        local buf = vim.api.nvim_create_buf(true, false)
        local format_command = vim.split(command, " ", { plain = true })
        local win_width = vim.api.nvim_win_get_width(0) / 2
        local win_height = vim.api.nvim_win_get_height(0)
        vim.api.nvim_open_win(buf, true,
            { border = "rounded", width = win_width, height = win_height, relative = "editor", bufpos = { 50, 20 } })
        -- Runs command
        vim.fn.jobstart(format_command, {
            stout_buffered = true,
            on_stdout = function(_, data)
                if data then
                    vim.api.nvim_buf_set_lines(buf, -1, -1, false, data)
                end
            end
        })
        --local win = vim.api.nvim_get_current_win()
        --local buf = vim.api.nvim_create_buf(true, true)
        --vim.api.nvim_win_set_buf(win, buf)
    end
end

