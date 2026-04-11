return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("dashboard").setup({
			theme = "doom",
			config = {
				header = {
					[[                                                                       ]],
					[[                                                                       ]],
					[[                                                                       ]],
					[[                                                                       ]],
					[[                                                                       ]],
					[[                                                                       ]],
					[[                                                                       ]],
					[[                                                                     ]],
					[[       ████ ██████           █████      ██                     ]],
					[[      ███████████             █████                             ]],
					[[      █████████ ███████████████████ ███   ███████████   ]],
					[[     █████████  ███    █████████████ █████ ██████████████   ]],
					[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
					[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
					[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
					[[                                                                       ]],
					[[                                                                       ]],
					[[                                                                       ]],
					[[                                                                       ]],
				},

				center = {
					{ icon = "󰈸  ", desc = "Typr", action = "ene | Typr", key = "t" },
					{ icon = "  ", desc = "Write Code", action = "ene | startinsert", key = "w" },
					{ icon = "󰊢  ", desc = "Procrastinate", action = "!cowsay '5 more minutes...'", key = "p" },
					{ icon = "󱎫  ", desc = "Touch Grass", action = "!echo '404: Grass not found'", key = "g" },
					{
						icon = "  ",
						desc = "rm -rf /",
						action = "!echo '💀 Nice try, rootless'",
						key = "r",
					},
					{ icon = "󰩈  ", desc = "Exit Neovim", action = "qa", key = "q" },
				},

				footer = {
					"",
					"🕊  breathe. type. repeat.",
					"",
				},
			},
		})
	end,
}
