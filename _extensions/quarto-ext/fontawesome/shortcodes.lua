return {
    ["fa"] = function(args, kwargs)
        local icon = pandoc.utils.stringify(args[1]) -- FIXME ESCAPE

        if FORMAT == 'docx' then
            content = ""
            return pandoc.RawBlock('openxml', "")
        elseif FORMAT:match 'latex' then
            -- content = "\\faicon{" .. icon .. "}"
            return pandoc.RawBlock('tex', "\\faIcon{" .. icon .. "}")
        elseif FORMAT:match 'odt' then
            return pandoc.RawBlock('opendocument', "")
        elseif FORMAT:match 'html.*' then
            return pandoc.RawBlock('html', "<i class=\"fa-solid fa-" .. icon .. "\"></i>")
        elseif FORMAT:match 'epub' then
            return pandoc.RawBlock('html', "")
        elseif FORMAT:match 'context' then
            return pandoc.RawBlock('context', "")
        else
            -- fall back to insert a span
            return pandoc.Span(icon)
        end
    end
}