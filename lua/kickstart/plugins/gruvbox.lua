return {
  'ellisonleao/gruvbox.nvim',
  prioriy = 1000,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('gruvbox').setup {
      italic = {
        comments = false, -- Disable italics in comments
      },
    }

    vim.o.background = 'dark'
    vim.cmd.colorscheme 'gruvbox'
  end,
}
