return {
	-- Multi-file search/replace
	{
		"nvim-pack/nvim-spectre",
		enabled = false,
		keys = {
			{
				"<leader>fs",
				function()
					require("spectre").open()
				end,
				desc = "Replace in files (Spectre)",
			},
		},
	},
	{
		"MagicDuck/grug-far.nvim",
		opts = {},
		keys = {
			{
				"<leader>fr",
				function()
					require("grug-far").open({ transient = true })
				end,
				desc = "Replace in files (Grug)",
			},
		},
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false, -- Telescope did only one release, so use HEAD for now
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- "ahmedkhalf/project.nvim",
			-- config = function()
			--     require("user.config.projects")
			-- end,
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
			},
		},
		config = function()
			require("telescope").setup({
				pickers = {
					colorscheme = {
						enable_preview = true,
					},
				},
			})
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"danielfalk/smart-open.nvim",
		branch = "0.2.x",
		config = function()
			require("telescope").load_extension("smart_open")
		end,
		dependencies = {
			"kkharji/sqlite.lua",
			-- Only required if using match_algorithm fzf
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			-- Optional.  If installed, native fzy will be used when match_algorithm is fzy
			{ "nvim-telescope/telescope-fzy-native.nvim" },
		},
	},
}
