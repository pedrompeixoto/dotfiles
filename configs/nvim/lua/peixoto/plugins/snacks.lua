return {
  "folke/snacks.nvim",
  opts = {
    picker = {}
  },
  keys = {
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
  }
}
