return {
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("spectre").setup()
      -- Raccourci pratique : <leader>S pour ouvrir Spectre
      vim.keymap.set("n", "<leader>S", require("spectre").toggle, { desc = "Spectre: Search & Replace" })
    end,
  },
}
