local M = {}

-- Note taker
-- This plug alows you to create little notes and connects them to your project

M.buf = nil
M.win = nil

M.setup = function()
    local check_list_path = vim.fn.split(vim.fn.getcwd(), '/')
    local check_list_name = pairs(check_list_path)
    for key, value in pairs(check_list_path) do
        check_list_name = value
    end
    check_list_name = vim.fn.join({ check_list_name, ".md" }, "")

    --open file command
    local open_file_cmd = vim.fn.join({ "e ./", check_list_name }, "")
    -- creating and starting the pain
    if M.buf ~= nil then
        if vim.fn.buffer_exists(M.buf) == 0 then
            vim.cmd("vsplit")
            vim.cmd("resize 20")
            M.win = vim.api.nvim_get_current_win()
            vim.cmd(open_file_cmd)
            M.buf = vim.api.nvim_win_get_buf(M.win)
            vim.api.nvim_set_current_win(M.win)
            vim.api.nvim_win_set_width(M.win, 30)
            M.bindKeys(M.buf)
            return
        end

        local tabpage = vim.api.nvim_tabpage_list_wins(0)

        for key, value in pairs(tabpage) do
            if value == M.win then
                vim.api.nvim_set_current_win(M.win)
                return
            end
        end
        vim.cmd("vsplit")
        M.win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(M.win, M.buf)
        vim.api.nvim_win_set_width(M.win, 30)
        M.bindKeys(M.buf)
    else
        vim.cmd("vsplit")
        M.win = vim.api.nvim_get_current_win()
        vim.cmd(open_file_cmd)
        M.buf = vim.api.nvim_win_get_buf(M.win)
        vim.api.nvim_win_set_width(M.win, 30)
        M.bindKeys(M.buf)
    end
    vim.api.nvim_win_set_width(M.win, 30)
    M.bindKeys(M.buf)
end
-- check operations
--
-- check off: checks off solection
M.check_off = function(opt)
    local line = vim.api.nvim_get_current_line()
    if line:sub(0, 6)  == '- [  ]' then
        line = line:sub(0, 4) .. 'x' .. line:sub(5, 99)
        vim.api.nvim_set_current_line(line)
    end
end
-- uncheck: unchecks a solection
M.uncheck = function(opt)
    local line = vim.api.nvim_get_current_line()
    if line:sub(0, 7)  == '- [ x ]' then
        line = line:sub(0, 4) .. line:sub(6, 99)
        vim.api.nvim_set_current_line(line)
    end
end
-- add_check: adds a check box
M.add_check = function(opt)
    local input = vim.fn.input("Check Box:\n", "")
    local line = vim.api.nvim_get_current_line()
    local pos = vim.api.nvim_win_get_cursor(M.win)
    if line == "" then
        vim.api.nvim_set_current_line(vim.fn.join({ "- [  ] ", input }, ""))
    else
        vim.api.nvim_buf_set_lines(M.buf, pos[1] - 1, pos[1], false, { vim.fn.join({ "- [  ] ", input }, ""), line  })
    end
end
-- remove_check: removes a check box
M.remove_check = function(opt)
    local line = vim.api.nvim_get_current_line()
    local pos = vim.api.nvim_win_get_cursor(M.win)
    if line:sub(0,3) == '- [' then
        vim.fn.deletebufline(M.buf, pos[1])
    end
end

-- setting commands for keybindings
vim.api.nvim_create_user_command("SetupCheck", function() M.setup() end, {})
vim.api.nvim_create_user_command("CheckOff", function() M.check_off() end, {})
vim.api.nvim_create_user_command("UncheckCheck", function() M.uncheck() end, {})
vim.api.nvim_create_user_command("AddCheck", function() M.add_check() end, {})
vim.api.nvim_create_user_command("RemoveCheck", function() M.remove_check() end, {})

local buf_keymap = vim.api.nvim_buf_set_keymap
local buf_unkeymap = vim.api.nvim_buf_set_keymap
M.bindKeys = function(buf)
    local opts = { noremap = true, }
    buf_keymap(buf, 'n', "x", "<cmd>CheckOff<CR>", opts)
    buf_keymap(buf, 'n', "u", "<cmd>UncheckCheck<CR>", opts)
    buf_keymap(buf, 'i', "<c-a>", "<cmd>AddCheck<CR>", opts)
    buf_keymap(buf, 'i', "<c-r>", "<cmd>RemoveCheck<CR>", opts)

end
