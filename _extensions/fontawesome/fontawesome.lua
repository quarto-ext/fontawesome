local function ensureLatexDeps()
  quarto.doc.useLatexPackage("fontawesome5")
end

local function ensureHtmlDeps()
  quarto.doc.addHtmlDependency({
    name = 'fontawesome6',
    version = '0.1.0',
    stylesheets = {'assets/css/all.css'}
  })
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
  return "normalsize"
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
      title = " title=\"" .. title  .. "\" aria-hidden=\"true\""
    end

    local size = pandoc.utils.stringify(kwargs["size"])
    
    -- detect html (excluding epub which won't handle fa)
    if quarto.doc.isFormat("html:js") then
      ensureHtmlDeps()
      if not isEmpty(size) then
        size = " fa-" .. size
      end
      return pandoc.RawInline(
        'html',
        "<i class=\"fa-" .. group .. " fa-" .. icon .. size .. "\"" .. title .. "></i>"
      )
    -- detect pdf / beamer / latex / etc
    elseif quarto.doc.isFormat("pdf") then
      ensureLatexDeps()
      if isEmpty(size) then
        return pandoc.RawInline('tex', "\\faIcon{" .. icon .. "}")
      else
        return pandoc.RawInline('tex', "\\" .. isValidSize(size) .. "{\\faIcon{" .. icon .. "}}")
      end
    else
      return pandoc.Null()
    end
  end
}
