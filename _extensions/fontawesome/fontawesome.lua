local function ensureLatexDeps()
  quarto.doc.use_latex_package("fontawesome5")
end

local function ensureHtmlDeps()
  quarto.doc.add_html_dependency({
    name = 'fontawesome6',
    version = '0.1.0',
    stylesheets = {'assets/css/all.css', 'assets/css/latex-fontsize.css'}
  })
end

local function isEmpty(s)
  return s == nil or s == ''
end

local function getRgbTriplets(s)
  local triplet = {}
  for t in string.gmatch(string.match(s, 'rgb%(([^%)]+)%)'), "([^,]+)") do
    table.insert(triplet, t)
  end
  return triplet
end

local function toRgbCss(s)
  local triplet = {}
  for k,t in pairs(getRgbTriplets(s)) do
    if tonumber(t) <= 1 then
      table.insert(triplet, string.format("%.0f", tonumber(t) * 255))
    else
      table.insert(triplet, t)
    end
  end
  return table.concat(triplet, ",")
end

local function toRgbTex(s)
  local triplet = {}
  for k,t in pairs(getRgbTriplets(s)) do
    if tonumber(t) > 1 then
      table.insert(triplet, string.format("%.2f", tonumber(t) / 255))
    else
      table.insert(triplet, t)
    end
  end
  return table.concat(triplet, ",")
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
    local color = pandoc.utils.stringify(kwargs["color"])
    
    -- detect html (excluding epub which won't handle fa)
    if quarto.doc.is_format("html:js") then
      ensureHtmlDeps()
      if not isEmpty(size) then
        size = " fa-" .. size
      end
      if not isEmpty(color) then
        if string.find(color, '^rgb') then
          color = " style=\"color:rgb(" .. toRgbCss(color) .. ");\""
        else
          color = " style=\"color:" .. color .. ";\""
        end
      end
      return pandoc.RawInline(
        'html',
        "<i class=\"fa-" .. group .. " fa-" .. icon .. size .. "\"" .. title .. label .. color .. "></i>"
      )
    -- detect pdf / beamer / latex / etc
    elseif quarto.doc.is_format("pdf") then
      ensureLatexDeps()
      local tex = "\\faIcon{" .. icon .. "}"
      if not isEmpty(isValidSize(size)) then
        tex = "{\\" .. size .. tex .. "}"
      end
      if not isEmpty(color) then
        if string.find(color, '^#%x+') then 
          tex = "\\textcolor[HTML]{" .. string.match(color, '#(%x+)') .. "}{" .. tex .. "}"
        elseif string.find(color, '^rgb') then
          tex = "\\textcolor[rgb]{" .. toRgbTex(color) .. "}{" .. tex .. "}"
        else
          tex = "\\textcolor{" .. color .. "}{" .. tex .. "}"
        end
      end
      return pandoc.RawInline('tex', tex)
    else
      return pandoc.Null()
    end
  end
}
