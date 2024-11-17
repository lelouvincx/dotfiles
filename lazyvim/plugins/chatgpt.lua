local wk = require("which-key")
wk.add({
	{ "<leader>C", group = "ChatGPT" }, -- group
	{ "<leader>Cc", "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
	{ "<leader>Ce", "<cmd>ChatGPTEditWithInstruction<CR>", desc = "Edit with instruction", mode = { "n", "v" } },
	{ "<leader>Cg", "<cmd>ChatGPTRun grammar_correction<CR>", desc = "Grammar Correction", mode = { "n", "v" } },
	{ "<leader>Ct", "<cmd>ChatGPTRun translate<CR>", desc = "Translate", mode = { "n", "v" } },
	{ "<leader>Ck", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords", mode = { "n", "v" } },
	{ "<leader>Cd", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring", mode = { "n", "v" } },
	{ "<leader>Ca", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests", mode = { "n", "v" } },
	{ "<leader>Co", "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code", mode = { "n", "v" } },
	{ "<leader>Cs", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize", mode = { "n", "v" } },
	{ "<leader>Cf", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs", mode = { "n", "v" } },
	{ "<leader>Cx", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code", mode = { "n", "v" } },
	{ "<leader>Cr", "<cmd>ChatGPTRun roxygen_edit<CR>", desc = "Roxygen Edit", mode = { "n", "v" } },
	{
		"<leader>Cl",
		"<cmd>ChatGPTRun code_readability_analysis<CR>",
		desc = "Code Readability Analysis",
		mode = { "n", "v" },
	},
})

return {
	"jackMort/ChatGPT.nvim",
	event = "VeryLazy",
	config = function()
		require("chatgpt").setup({
			api_key_cmd = "echo $PERSONAL_OPENAI_API_KEY",
			openai_params = {
				model = "gpt-4o-mini",
				max_tokens = 512,
				temperature = 0.2,
			},
			openai_edit_params = {
				model = "gpt-4o-mini",
				max_tokens = 512,
				temperature = 0.2,
			},
			popup_layout = {
				default = "right",
			},
		})
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		"nvim-telescope/telescope.nvim",
	},
}
