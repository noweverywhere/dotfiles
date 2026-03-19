require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "css",
    "dockerfile",
    "git_config",
    "git_rebase",
    "gitcommit",
    "gitignore",
    "html",
    "javascript",
    "json",
    "json",
    "lua",
    "markdown",
    "python",
    "ruby",
    "scss",
    "sql",
    "ssh_config",
    "tmux",
    "tsx",
    "typescript",
    "yaml",
  },
  highlight = {
    enable = true,
    disable = function(lang, buf)
      local disabled_filetypes = { 'ruby' }
      if vim.tbl_contains(disabled_filetypes, lang) then
        return true
      end

      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))

      if ok and stats and stats.size > max_filesize then
        return true
      end

      return false
    end,
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true,
  }
}
