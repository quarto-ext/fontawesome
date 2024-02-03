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

local function ensure_typst_font_awesome()
  if included_font_awesome then
    return
  end
  included_font_awesome = true
  quarto.doc.include_text("in-header", "#import \"@preview/fontawesome:0.1.0\": *")
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
  local validSizes = {
    "2xs",
    "xs",
    "sm",
    "lg",
    "xl",
    "2xl"
  }
  
  local relativeSizes = {
    "0.625em",
    "0.75em",
    "0.875em",
    "1.25em",
    "1.5em",
    "2em"
  }
  
  for i, v in ipairs(validSizes) do
    if v == size then
      return relativeSizes[i]
    end
  end
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
      
      local fill = pandoc.utils.stringify(kwargs["fill"])
      if not isEmpty(fill) then
        fill = ", fill: " .. fill
      end
      
      if not isEmpty(size) then
        size = convert_fa_relative_size(size)
        size = ", size: " .. size
      end
      
      if group == "brands" then
        return pandoc.RawInline(
          'typst',
          "#fa-icon(\"" .. icon .. "\", fa-set: \"Brands\"" .. size .. fill .. ")"
          )
      else
        return pandoc.RawInline(
            'typst',
            "#fa-icon(\"" .. icon .. "\"" .. size .. fill .. ")"
            )
      end
    else
      return pandoc.Null()
    end
  end
}
