local config = {}

function config.lualine()
  require('lualine').setup {
    options = { theme = 'solarized_dark' }
  }
end

return config