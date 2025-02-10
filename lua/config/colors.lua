local function get_hl_color(group, attr, fallback)
  local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
  if hl and hl[attr] then
    local result = string.format("#%06x", hl[attr])
    return result
  end
  return fallback -- Use fallback if not found
end

local colors = {
  function_fg = get_hl_color("Function", "fg", "#000000"),
  special_fg = get_hl_color("Special", "fg", "#000000"),
  string_fg = get_hl_color("String", "fg", "#000000"),
  keyword_fg = get_hl_color("Keyword", "fg", "#000000"),
  error_fg = get_hl_color("Error", "fg", "#000000"),
  warning_fg = get_hl_color("WarningMsg", "fg", "#000000"),
  normal_fg = get_hl_color("Normal", "fg", "#000000"),
  normal_bg = get_hl_color("Normal", "bg", "#000000"),
  colorcolumn_bg = get_hl_color("ColorColumn", "bg", "#000000"),
  cursorline_bg = get_hl_color("CursorLine", "bg", "#000000"),
}

return {
  normal = {
    a = { fg = colors.normal_bg, bg = colors.function_fg, gui = "bold" },
    b = { fg = colors.normal_fg, bg = colors.colorcolumn_bg },
    c = { fg = colors.normal_fg, bg = colors.cursorline_bg },
  },

  insert = {
    a = { fg = colors.normal_bg, bg = colors.string_fg, gui = "bold" },
  },

  visual = {
    a = { fg = colors.normal_bg, bg = colors.keyword_fg, gui = "bold" },
  },

  replace = {
    a = { fg = colors.normal_bg, bg = colors.error_fg, gui = "bold" },
  },

  command = {
    a = { fg = colors.normal_bg, bg = colors.warning_fg, gui = "bold" },
  },

  inactive = {
    a = { fg = colors.normal_fg, bg = colors.cursorline_bg },
    b = { fg = colors.normal_fg, bg = colors.cursorline_bg },
    c = { fg = colors.normal_fg, bg = colors.colorcolumn_bg },
  },
}
