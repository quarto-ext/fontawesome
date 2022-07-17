function ensureLatexDeps()
  quarto.doc.useLatexPackage("fontawesome5")
end

function ensureHtmlDeps()
  quarto.doc.addHtmlDependency({
    name = 'fontawesome6',
    version = '0.1.0',
    stylesheets = {'assets/css/all.css'}
  })
end

local function isempty(s)
  return s == nil or s == ''
end

return {
  ["fa"] = function(args, kwargs)

    local group = "solid"
    local icon = pandoc.utils.stringify(args[1])
    if #args > 1 then
      group = icon
      icon = pandoc.utils.stringify(args[2])
    end
    local size = pandoc.utils.stringify(kwargs["size"])
    if not isempty(size) then
      size = " fa-" .. size
    end
    
    local title = pandoc.utils.stringify(kwargs["title"])
    if not isempty(title) then
      title = " title=\"" .. title  .. "\" aria-hidden=\"true\""
    end
    
    -- detect html (excluding epub which won't handle fa)
    if quarto.doc.isFormat("html:js") then
      ensureHtmlDeps()
      return pandoc.RawInline(
        'html',
        "<i class=\"fa-" .. group .. " fa-" .. icon .. size .. "\"" .. title .. "></i>"
      )
    -- detect pdf / beamer / latex / etc
    elseif quarto.doc.isFormat("pdf") then
      ensureLatexDeps()
      return pandoc.RawInline('tex', "\\faIcon{" .. icon .. "}") 
    else
      return pandoc.Null()
    end

  end
}
