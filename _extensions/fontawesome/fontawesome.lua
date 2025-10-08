local function ensureLatexDeps()
  quarto.doc.use_latex_package("fontawesome6")
end

local function ensureHtmlDeps()
  quarto.doc.add_html_dependency({
    name = 'fontawesome6',
    version = '6.7.2',
    stylesheets = {'assets/css/all.min.css', 'assets/css/latex-fontsize.css'}
  })
end

local included_font_awesome = false

local function ensure_typst_font_awesome()
  if not included_font_awesome then
    included_font_awesome = true
    quarto.doc.include_text('in-header', '#import "@preview/fontawesome:0.6.0": *')
    -- Opt-in version 6 for now
    quarto.doc.include_text('in-header', 'fa-version("6")')
  end
end

local function isEmpty(s)
  return s == nil or s == ''
end

local function isValidSize(size)
  local validSizes = {
    "tiny",
    "scriptsize",
    "footnotesize",
    "small",
    "normalsize",
    "large",
    "Large",
    "LARGE",
    "huge",
    "Huge"
  }
  for _, v in ipairs(validSizes) do
    if v == size then
      return size
    end
  end
  return ""
end

local function convert_fa_relative_size(size)
  -- Map of Font Awesome size names to em values
  -- Includes both CSS sizes (2xs, xs, sm, lg, xl, 2xl, 1x-10x)
  -- and LaTeX sizes (tiny, scriptsize, etc.)
  local sizeMap = {
    -- Font Awesome CSS relative sizes
    ["2xs"] = "0.625em",
    ["xs"] = "0.75em",
    ["sm"] = "0.875em",
    ["lg"] = "1.25em",
    ["xl"] = "1.5em",
    ["2xl"] = "2em",
    -- Font Awesome CSS multiplier sizes
    ["1x"] = "1em",
    ["2x"] = "2em",
    ["3x"] = "3em",
    ["4x"] = "4em",
    ["5x"] = "5em",
    ["6x"] = "6em",
    ["7x"] = "7em",
    ["8x"] = "8em",
    ["9x"] = "9em",
    ["10x"] = "10em",
    -- LaTeX size names (matches latex-fontsize.css for consistency)
    ["tiny"] = "0.5em",
    ["scriptsize"] = "0.7em",
    ["footnotesize"] = "0.8em",
    ["small"] = "0.9em",
    ["normalsize"] = "1em",
    ["large"] = "1.2em",
    ["Large"] = "1.5em",
    ["LARGE"] = "1.75em",
    ["huge"] = "2em",
    ["Huge"] = "2.5em"
  }

  -- Check if size is in the map
  if sizeMap[size] then
    return sizeMap[size]
  end

  -- If not found, return original size (allows custom em values)
  return size
end

return {
  ["fa"] = function(args, kwargs)

    local group = "solid"
    local icon = pandoc.utils.stringify(args[1])
    if #args > 1 then
      group = icon
      icon = pandoc.utils.stringify(args[2])
    end
    
    local title = pandoc.utils.stringify(kwargs["title"])
    if not isEmpty(title) then
      title = " title=\"" .. title  .. "\""
    end

    local label = pandoc.utils.stringify(kwargs["label"])
    if isEmpty(label) then
      label = " aria-label=\"" .. icon  .. "\""
    else
      label = " aria-label=\"" .. label  .. "\""
    end

    local size = pandoc.utils.stringify(kwargs["size"])
    
    -- detect html (excluding epub which won't handle fa)
    if quarto.doc.is_format("html:js") then
      ensureHtmlDeps()
      if not isEmpty(size) then
        size = " fa-" .. size
      end
      return pandoc.RawInline(
        'html',
        "<i class=\"fa-" .. group .. " fa-" .. icon .. size .. "\"" .. title .. label .. "></i>"
      )
    -- detect pdf / beamer / latex / etc
    elseif quarto.doc.is_format("pdf") then
      ensureLatexDeps()
      local options = ""
      if (group == "regular") then
        options = "[regular]"
      end
      local icons = "\\faIcon" .. options .. "{" .. icon .. "}"
      if isEmpty(isValidSize(size)) then
        return pandoc.RawInline('tex', icons)
      else
        return pandoc.RawInline('tex', "{\\" .. size .. icons .. "}")
      end
    -- detect typst
    elseif quarto.doc.is_format("typst") then
      ensure_typst_font_awesome()
      
      local color = pandoc.utils.stringify(kwargs["color"])
      if not isEmpty(size) then
        size = convert_fa_relative_size(size)
        size = "size: " .. size
      end
      
      if not isEmpty(color) then
        color = "fill: " .. color
        
        if not isEmpty(size) then
          size = size .. ", "
        end
      end

      return pandoc.RawInline(
        'typst',
        "#fa-" .. icon .. "(" .. size .. color .. ")"
        )
    else
      return pandoc.Null()
    end
  end
}
