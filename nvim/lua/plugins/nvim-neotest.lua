return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "olimorris/neotest-rspec",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-rspec")
      },
    })
    require("neotest-rspec")({
      rspec_cmd = function()
        return vim.tbl_flatten({
          "script",
          "spec",
        })
      end
    })
  end
}
