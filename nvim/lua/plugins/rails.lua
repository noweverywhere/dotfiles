return {
    "tpope/vim-rails",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        vim.g.rails_projections = {
            ['app/controllers/*_controller.rb'] = {
                spec = 'spec/controllers/{}_spec.rb'
            }
        }
    end
}
