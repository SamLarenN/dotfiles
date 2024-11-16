return {
  'mrjones2014/smart-splits.nvim',
  config = function()
    require('smart-splits').setup {
      at_edge = 'stop',
      resize_mode = {
        -- set to true to silence the notifications
        -- when entering/exiting persistent resize mode
        silent = true,
      },
    }
  end,
}
