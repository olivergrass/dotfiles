-- Automatically install packer
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user.config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Performance
pcall(require, 'impatient')

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require('packer.util').float({ border = "rounded" })
        end,
    },
})

-- Install your plugins here
packer.startup(function(use)
    use { 'wbthomason/packer.nvim' } -- Have packer manage itself
    use { 'lewis6991/impatient.nvim' } -- For performance
    use { 'nvim-lua/plenary.nvim' } -- Useful lua functions used by lots of plugins

    -- Appearance
    use {
        'akinsho/bufferline.nvim',
        config = function()
            require('user.config.bufferline')
        end,
    }
    use {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('user.config.lualine')
        end,
    }
    use {
        'goolord/alpha-nvim',
        config = function()
            require('user.config.alpha')
        end,
    }
    use { 'stevearc/dressing.nvim' }

    -- Colorschemes
    use { 'folke/tokyonight.nvim' }
    use { 'joshdick/onedark.vim' }
    use { 'lunarvim/darkplus.nvim' }

    use {
        'VonHeikemen/lsp-zero.nvim',
        config = function()
            require('user.config.zero')
        end,
        event = 'InsertEnter',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Snippets
            { 'rafamadriz/friendly-snippets', event = 'InsertEnter' },
            { 'L3MON4D3/LuaSnip', after = 'friendly-snippets' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp', after = 'LuaSnip'},
            { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
            { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
            { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
        }
    }
    use {
        'windwp/nvim-autopairs',
        config = function()
            require('user.config.autopairs')
        end,
        after = 'nvim-cmp',
    }
    use {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
        after = 'nvim-lspconfig',
    }

    -- Navigation
    use { 'kyazdani42/nvim-web-devicons' }
    use {
        'kyazdani42/nvim-tree.lua',
        config = function()
            require('user.config.nvim-tree')
        end,
        cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
        -- ft = 'alpha',
    }
    use {
        'nvim-telescope/telescope.nvim',
        config = function()
            require('user.config.telescope')
        end,
        cmd = 'Telescope',
        requires = {
            'ahmedkhalf/project.nvim',
            config = function()
                require('user.config.projects')
            end,
        },
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }

    -- Tools
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('user.config.gitsigns')
        end,
    }
    use { 'famiu/bufdelete.nvim' }
    use {
        'folke/which-key.nvim',
        config = function()
            require('user.config.whichkey')
        end,
    }
    use {
        'akinsho/toggleterm.nvim',
        config = function()
            require('user.config.toggleterm')
        end,
    }
    use {
        'norcalli/nvim-colorizer.lua',
        cmd = 'ColorizerToggle',
        config = function()
            require('colorizer').setup()
        end,
    }
    use {
        'karb94/neoscroll.nvim',
        config = function()
            require('user.config.neoscroll')
        end,
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end
end)

if packer_bootstrap then
    return
end

