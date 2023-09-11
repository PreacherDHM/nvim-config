-- macros 
local vapi = vim.api
local defalt_path = '.'
local M = {}

M.win = nil
M.buf = nil
M.path = defalt_path
M.open_file_command = 'e'
M.open_command = nil
M.split_oreantation = 'Horz'
M.open_notes = false
M.glob_note_loc = '~/.notes/'

local create_simlink = function (opts)
    if opts.name ~= nil and M.glob_note_loc ~= nil then
        local format_command = vim.fn.split('ln -P  ' .. opts.name .. ' ' .. M.glob_note_loc, " ")
        vim.fn.jobstart(format_command, {plain = true})
    end
end

M._open_split = function (opts)
    if opts.oreantation == 'Vert' then
        vim.cmd('vsplit')
    end
    if opts.oreantation == 'Horz' then
        vim.cmd('split')
    end
end

M.create_note = function (opts)
    local input = vim.fn.input('File Name: ', '')
    M._open_split({oreantation = M.split_oreantation})
    M.win = vapi.nvim_get_current_win()
    vim.cmd(vim.fn.join({M.open_command,'/', input, '.md'}, ""))
    M.buf = vapi.nvim_win_get_buf(M.win)
end

M.open_notes = function (opts)
    M._open_split({oreantation = M.split_oreantation})
    M.win = vapi.nvim_get_current_win()
    vim.cmd(M.open_command)
    M.note_solection = true
end

M.add_to_global_notes = function(opts)
    local gol_location = '~/notes/'
    -- if the golobale value is not set then return ~/notes/
    if M.glob_note_loc ~= nil then
        gol_location = M.glob_note_loc
    end
    -- if there is no location set in the opts then just return ~/notes/
    local name = vim.fn.split(vapi.nvim_buf_get_name(M.buf), '/')

    local input = vim.fn.input('Do you want to add ' .. name[#name]  ..' to your global notes? Y/n?')
    if input ~= '' or string.upper(input) == 'Y' then
        print('\nAdded ' .. vapi.nvim_buf_get_name(M.buf) .. ' to notes')
        create_simlink({name = vapi.nvim_buf_get_name(M.buf)})
    else
        print('\nCanceled')
    end

end
-- Opts are:
--  path:str,
--  split:bool
--  oreantation
--  file_open_command
M.setup = function (opts)
    M.win = nil
    M.buf = nil
    M.glob_note_loc = '~/notes/'
    local open_file = M.open_file_command

    if opts.file_open_command ~= nil then
        open_file = opts.file_open_command
    end
    -- note name
    -- note path
    if opts.path ~= nil then
        M.path = opts.path
        local format_command = vim.split('mkdir -p ' .. M.path, " ", { plain = true })
        vim.fn.jobstart(format_command, {
            stout_buffered = true,
            on_stdout = function(_, data)
            end
        })
        if vim.fn.isdirectory(M.path) == false  then
            print('\nfile dose not exist')
        end
    end
    -- note file type
    -- generate open buffer command
    M.open_command = vim.fn.join({open_file,  M.path }, '')
    -- Initing window

    if opts.split == true then
        if opts.oreantation ~= nil then
            M.split_oreantation = opts.oreantation
        end
    end
end
M.setup({path = './notes', split = true, oreantation = 'Vert'})


vim.api.nvim_create_autocmd('BufEnter', {
    pattern = 'markdown',
    callback = function ()
        local t = vim.fn.split(vapi.nvim_buf_get_name(vapi.nvim_get_current_buf()), '/')
        if t[#t-1] == 'notes' then
            M.win = vapi.nvim_get_current_win()
            M.buf = vapi.nvim_win_get_buf(M.win)
            vim.opt.spell = true
            vim.cmd('!echo hi')
        end
    end
})
vim.api.nvim_create_autocmd('FileType BufLeave', {
    pattern = 'markdown',
    callback = function ()
        local t = vim.fn.split(vapi.nvim_buf_get_name(vapi.nvim_get_current_buf()), '/')
        if t[#t-1] == 'notes' then
            M.win = vapi.nvim_get_current_win()
            M.buf = vapi.nvim_win_get_buf(M.win)
            vim.opt.spell = true
            vim.cmd('!echo hi')
        end
    end
})
vim.api.nvim_create_user_command("CreateNote", function() M.create_note() end, {})
vim.api.nvim_create_user_command("OpenNotes", function() M.open_notes() end, {})
vim.api.nvim_create_user_command("AddToGlobalNotes", function() M.add_to_global_notes() end, {})

return M
