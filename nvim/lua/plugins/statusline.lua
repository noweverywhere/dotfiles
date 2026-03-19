return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    filename_section  = {
      {'filename', path = 1},
      {'bufnr'}
    }
    default_sections = {
      lualine_a = {'mode'},
      lualine_b = {'diff', 'diagnostics'},
      lualine_c = filename_section,
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    }
    require('lualine').setup({
      sections = default_sections,
      inactive_sections = {
        lualine_a = {},
        lualine_b = {'diff'},
        lualine_c = filename_section,
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
      }
    })

    -- vim.api.nvim_set_keymap('n', '<leader>gb', '', {
    --   -- toggle the presence of `branch` in the statusline
    --
    --   noremap = true,
    --   silent = true,
    --   callback = function()
    --     local sections = require('lualine').sections
    --     local branch_index = vim.tbl_indexof(sections.lualine_b, 'branch')
    --     if branch_index then
    --       table.remove(sections.lualine_b, branch_index)
    --     else
    --       table.insert(sections.lualine_b, 1, 'branch')
    --     end
    --     require('lualine').setup({
    --       sections = sections,
    --     })
    --   end,
    -- })
  end
}
