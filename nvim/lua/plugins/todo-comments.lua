return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		-- FIX :
		-- BUG :
		-- WARN : 
		-- HACK:
		-- TODO :
		-- NOTE : 
		-- PERF : 
		-- TEST :

		keywords = {
			WILI_SHOHA = {color = "choha"},
			DEBUG = { color = "default"},
			QUESTION = {color = "choha"}
		},

      colors = {
		choha = {"#a6fd29"},
        error = { "#E91E63" },
        warning = {"#FFF59D" },
        info = { "#BBDEFB" },
        hint = { "#80CBC4" },
        default = { "#9575CD" },
        test = { "#E1BEE7" }
      },
	},
}
