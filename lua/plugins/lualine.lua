local colors = {
  blue = "#A6DBFF",
  cyan = "#8cf8f7",
  green = "#b4f6c0",
  magenta = "#FFCAFF",
  red = "#FFC0B9",
  yellow = "#FCE094",
  bg = "#14161b",
  fg = "#C4C6CD",
  bg_b = "#4f5258",
  bg_c = "#2C2E33",
}

local theme = {
  normal = {
    a = { fg = colors.bg, bg = colors.blue, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg_b },
    c = { fg = colors.fg, bg = colors.bg_c },
  },

  insert = {
    a = { fg = colors.bg, bg = colors.green, gui = "bold" },
  },

  visual = {
    a = { fg = colors.bg, bg = colors.magenta, gui = "bold" },
  },

  replace = {
    a = { fg = colors.bg, bg = colors.red, gui = "bold" },
  },

  command = {
    a = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
  },

  inactive = {
    a = { fg = colors.fg, bg = colors.bg_c },
    b = { fg = colors.fg, bg = colors.bg_c },
    c = { fg = colors.fg, bg = colors.bg_b },
  },
}

return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    -- PERF: we don't need this lualine require madness 🤷
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    local icons = LazyVim.config.icons

    vim.o.laststatus = vim.g.lualine_laststatus

    local opts = {
      options = {
        theme = theme,
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
      },
      sections = {
        -- Left side
        lualine_a = {
          "mode",
        },
        lualine_b = {
          { LazyVim.lualine.pretty_path() },
        },
        lualine_c = {
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        -- Right side
        lualine_x = {
          {
            -- Recording @
            require("noice").api.status.mode.get,
            cond = require("noice").api.status.mode.has,
            color = { fg = "#ff9e64" },
          },
          {
            -- Search
            require("noice").api.status.search.get,
            cond = require("noice").api.status.search.has,
            color = { fg = "#ff9e64" },
          },
          {
            function()
              return "  " .. require("dap").status()
            end,
            cond = function()
              return package.loaded["dap"] and require("dap").status() ~= ""
            end,
            color = function()
              return { fg = Snacks.util.color("Debug") }
            end,
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function()
              return { fg = Snacks.util.color("Special") }
            end,
          },
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
        },
        lualine_y = {
          {
            -- https://github.com/nvim-lualine/lualine.nvim/discussions/1153
            function()
              -- Check if 'conform' is available
              local status, conform = pcall(require, "conform")
              if not status then
                return "Conform not installed"
              end

              local lsp_format = require("conform.lsp_format")

              -- Get formatters for the current buffer
              local formatters = conform.list_formatters_for_buffer()
              if formatters and #formatters > 0 then
                local formatterNames = {}

                for _, formatter in ipairs(formatters) do
                  table.insert(formatterNames, formatter)
                end

                return " " .. table.concat(formatterNames, " ")
              end

              -- Check if there's an LSP formatter
              local bufnr = vim.api.nvim_get_current_buf()
              local lsp_clients = lsp_format.get_format_clients({ bufnr = bufnr })

              if not vim.tbl_isempty(lsp_clients) then
                return "󰷈 LSP Formatter"
              end

              return ""
            end,
          },
        },
        lualine_z = {
          {
            -- LSP Info
            function()
              local buf_clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
              if next(buf_clients) == nil then
                return "󰒏 No LSP"
              end
              local client_names = {}
              for _, client in pairs(buf_clients) do
                table.insert(client_names, client.name)
              end
              return "󰒋 " .. table.concat(client_names, ", ")
            end,
          },
        },
      },
      extensions = { "lazy" },
    }

    return opts
  end,
}
