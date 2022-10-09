local function trailing_whitespace()
  local space = vim.fn.search([[\s\+$]], 'nwc')
  return space ~= 0 and "TW:"..space or ""
end

local function mixed_indent()
  local space_pat = [[\v^ +]]
  local tab_pat = [[\v^\t+]]
  local space_indent = vim.fn.search(space_pat, 'nwc')
  local tab_indent = vim.fn.search(tab_pat, 'nwc')
  local mixed = (space_indent > 0 and tab_indent > 0)
  local mixed_same_line
  if not mixed then
    mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
    mixed = mixed_same_line > 0
  end
  if not mixed then return '' end
  if mixed_same_line ~= nil and mixed_same_line > 0 then
     return 'MI:'..mixed_same_line
  end
  local space_indent_cnt = vim.fn.searchcount({pattern=space_pat, max_count=1e3}).total
  local tab_indent_cnt =  vim.fn.searchcount({pattern=tab_pat, max_count=1e3}).total
  if space_indent_cnt > tab_indent_cnt then
    return 'MI:'..tab_indent
  else
    return 'MI:'..space_indent
  end
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
 end
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = { 'NvimTree', 'alpha' },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {
        {
            'mode',
            icons_enabled = true,
            icon = {''},
            color = { gui = 'bold' },
        }
    },
    lualine_b = {
        {'b:gitsigns_head', icon = ''},
        {'diff', source = diff_source},
    },
    lualine_c = {'filename'},
    lualine_x = {
        {
            'diagnostics',
        },
        {
            trailing_whitespace,
            color = 'DiffText',
            separator = { left = '', right = ''},
        },
        {
            mixed_indent,
            color = 'DiffText',
            separator = { left = '', right = ''},
        },
    },
    lualine_y = {
        {
            'vim.fn.expand("%:p:h:t")',
            icons_enabled = true,
            icon = {' ', color = 'BlockRedBg' },
            padding = { left = 0, right = 1 },
            color = 'BlockRedFg',
        },
    },
    lualine_z = {
        {
            'location',
            icons_enabled = true,
            icon = {' ', color = 'BlockGreenBg' },
            padding = { left = 0, right = 1 },
            color = 'BlockGreenFg',
        },
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {'nvim-tree', 'toggleterm'}
}

