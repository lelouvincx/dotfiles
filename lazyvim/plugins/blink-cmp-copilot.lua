return {
	"giuxtaposition/blink-cmp-copilot",
	enabled = vim.g.ai_cmp, -- only enable if needed
	specs = {
		{
			"blink.cmp",
			optional = true,
			opts = {
				sources = {
					providers = {
						copilot = { name = "copilot", module = "blink-cmp-copilot" },
					},
					completion = {
						enabled_providers = { "copilot" },
					},
				},
			},
		},
	},
}
