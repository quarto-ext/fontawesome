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

return {
  ["fa"] = function(args, kwargs)

    local icon = pandoc.utils.stringify(args[1])

    -- detect html (excluding epub which won't handle fa)
    if quarto.doc.isFormat("html:js") then
      ensureHtmlDeps()
      return pandoc.RawInline('html', "<i class=\"fa-solid fa-" .. icon .. "\"></i>")
    -- detect pdf / beamer / latex / etc
    elseif quarto.doc.isFormat("pdf") then
      ensureLatexDeps()
      return pandoc.RawInline('tex', "\\faIcon{" .. icon .. "}") 
    else
      return pandoc.Null()
    end

  end
}