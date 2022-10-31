local Log = require('utils.log')

local status_ok, toggleterm = pcall(require, 'toggleterm')
if not status_ok then
    Log:error('Failed to load toggleterm')
    return
end

toggleterm.setup{
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
  shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
  persist_size = true,
  persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
  direction = 'vertical',
  close_on_exit = true, -- close the terminal window when the process exits
}

-- Close nvim if terminal is the last buffer
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
      vim.cmd "quit"
    end
  end
})

local Terminal = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new{
    cmd = 'lazygit',
    dir = 'git_dir',
    hidden = true,
    direction = 'float',
    on_open = function(_)
        vim.cmd('startinsert!')
    end,
    on_close = function(_) end,
}

function _GITDIFF_TOGGLE()
    local cmd = 'git diff HEAD:' .. vim.fn.expand('%') .. ' ' .. vim.fn.expand('%')
    Log:info(cmd)
    local gitdiff = Terminal:new{
        cmd = cmd,
        hidden = true,
        direction = 'float',
        close_on_exit = false,
    }
    gitdiff:toggle()
end

function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end
