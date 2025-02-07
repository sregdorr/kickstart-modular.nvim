vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>')

local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local function open_floating_window(opts)
  opts = opts or {}

  -- Get the total screen size
  local ui = vim.api.nvim_list_uis()[1]
  local total_width = ui.width
  local total_height = ui.height

  -- Set width and height (default to 80% of the screen)
  local width = opts.width or math.floor(total_width * 0.8)
  local height = opts.height or math.floor(total_height * 0.8)

  -- Calculate the starting position to center the window
  local row = math.floor((total_height - height) / 2)
  local col = math.floor((total_width - width) / 2)

  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- Open the floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
  })

  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = open_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.api.nvim_create_user_command('Floaterminal', toggle_terminal, {})
vim.keymap.set({ 'n', 't' }, '<space>tt', toggle_terminal)
