# 📈 Marp.nvim

An enhanced [Neovim](https://neovim.io/) plugin for converting Markdown presentations into PDF using [Marp](https://marp.app/), with additional steps for customization and viewing.

## ✨ Features

- Convert Markdown files to HTML using Marp with a custom CSS theme.
- Convert HTML to PDF using Pandoc.
- Automatically open the resulting PDF in Zathura for viewing.
- Hardcoded paths for Marp binary and CSS theme for consistent use.

## ⚡️ Requirements

- Neovim (version 0.5 or higher for Lua support)
- [Marp CLI](https://marp.app/) installed and available at `/var/home/dev/.local/share/bin/marp`
- [Pandoc](https://pandoc.org/) installed
- [Zathura](https://pwmt.org/projects/zathura/) PDF viewer installed

## 📦 Installation

Install the plugin with your preferred package manager:

### Lazy.nvim
```lua
require("lazy").setup({
  {"mecattaf/marp.nvim",
    config = function()
      require("marp-nvim").setup({
        -- Custom configuration options
      })
    end,
  }
})
```

## ⚙️ Configuration

Configure the plugin by passing a table with your desired settings in your `init.lua` or via the `setup` function in Vimscript. Here's an example with all available options:

```lua
require("marp-nvim").setup({
  theme = "/var/home/dev/.config/marp/mocha.css", -- Path to your custom Marp CSS theme
})
```

## ⌨️ Commands

- `:MarpStart` - Start the conversion process.
- `:MarpStop`  - Stops any ongoing conversion process.

## 💡 Inspiration

This plugin is inspired by and seeks to extend the functionality of [mpas/marp-nvim](https://github.com/mpas/marp-nvim) by incorporating a direct Markdown to PDF conversion process, leveraging Marp, Pandoc, and Zathura, with thanks to their contributors for the foundation.

