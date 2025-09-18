local columnPositions = {10, 266, 522, 778}
local maxColumns = #columnPositions

local function newLayoutContext()
    return { columnIndex = 1, y = 10 }
end

f_state = function(fid, F)
    state = core_unit[1].getElementIndustryInfoById(fid)["state"]
    local function fmt(name, label)
        if not Show_State then
            return name
        elseif State_As_Prefix then
            return label .. " - " .. name
        else
            return name .. " - " .. label
        end
    end
    if state < 1 and F == 0 then
        t = core_unit[1].getElementIndustryInfoById(fid)["currentProducts"]
        tt = string.gsub(system.getItem(t[1]["id"])["displayNameWithSize"], "Advanced","Adv.")
        tt = string.gsub(tt, "hydraulics","Hydraulics")
        tt = string.gsub(tt, "Uncommon","Unc.")
        tt = string.gsub(tt, " product","")
        return fmt(tt, "Error" .. state)
    elseif state == 1 and F == 0 then
        local industryInfo = core_unit[1].getElementIndustryInfoById(fid)
        if industryInfo == nil then
            return "Not configured"
        end
        local currentProducts = industryInfo["currentProducts"]
        if currentProducts == nil or #currentProducts == 0 then
            return "Not configured"
        end
        local productInfo = system.getItem(currentProducts[1]["id"])
        if productInfo == nil then
            return "Not configured"
        end
        local displayNameWithSize = productInfo["displayNameWithSize"]
        local tt = string.gsub(displayNameWithSize, "Advanced","Adv.")
        tt = string.gsub(tt, "hydraulics","Hydraulics")
        tt = string.gsub(tt, "Uncommon","Unc.")
        tt = string.gsub(tt, " product","")
        return fmt(tt, "Stopped")
    elseif state == 2 and F == 0 then
        t = core_unit[1].getElementIndustryInfoById(fid)["currentProducts"]
        tt = string.gsub(system.getItem(t[1]["id"])["displayNameWithSize"], "Advanced","Adv.")
        tt = string.gsub(tt, "hydraulics","Hydraulics")
        tt = string.gsub(tt, "Uncommon","Unc.")
        tt = string.gsub(tt, " product","")
        return fmt(tt, "Running")
    elseif state == 3 and F == 0 then
        t = core_unit[1].getElementIndustryInfoById(fid)["currentProducts"]
        tt = string.gsub(system.getItem(t[1]["id"])["displayNameWithSize"], "Advanced","Adv.")
        tt = string.gsub(tt, "hydraulics","Hydraulics")
        tt = string.gsub(tt, "Uncommon","Unc.")
        tt = string.gsub(tt, " product","")
        return fmt(tt, "Missing ingredient")
    elseif state == 4 and F == 0 then
        t = core_unit[1].getElementIndustryInfoById(fid)["currentProducts"]
        tt = string.gsub(system.getItem(t[1]["id"])["displayNameWithSize"], "Advanced","Adv.")
        tt = string.gsub(tt, "hydraulics","Hydraulics")
        tt = string.gsub(tt, "Uncommon","Unc.")
        tt = string.gsub(tt, " product","")
        return fmt(tt, "Output full")
    elseif state == 5 and F == 0 then
        t = core_unit[1].getElementIndustryInfoById(fid)["currentProducts"]
        tt = string.gsub(system.getItem(t[1]["id"])["displayNameWithSize"], "Advanced","Adv.")
        tt = string.gsub(tt, "hydraulics","Hydraulics")
        tt = string.gsub(tt, "Uncommon","Unc.")
        tt = string.gsub(tt, " product","")
        return fmt(tt, "No output container")
    elseif state == 6 and F == 0 then
        t = core_unit[1].getElementIndustryInfoById(fid)["currentProducts"]
        tt = string.gsub(system.getItem(t[1]["id"])["displayNameWithSize"], "Advanced","Adv.")
        tt = string.gsub(tt, "hydraulics","Hydraulics")
        tt = string.gsub(tt, "Uncommon","Unc.")
        tt = string.gsub(tt, " product","")
        return fmt(tt, "Pending")
    elseif state == 7 and F == 0 then
        t = core_unit[1].getElementIndustryInfoById(fid)["currentProducts"]
        tt = string.gsub(system.getItem(t[1]["id"])["displayNameWithSize"], "Advanced","Adv.")
        tt = string.gsub(tt, "hydraulics","Hydraulics")
        tt = string.gsub(tt, "Uncommon","Unc.")
        tt = string.gsub(tt, " product","")
        return fmt(tt, "Missing schematics")
    elseif state > 7 and F == 0 then
        t = core_unit[1].getElementIndustryInfoById(fid)["currentProducts"]
        tt = string.gsub(system.getItem(t[1]["id"])["displayNameWithSize"], "Advanced","Adv.")
        tt = string.gsub(tt, "hydraulics","Hydraulics")
        tt = string.gsub(tt, "Uncommon","Unc.")
        tt = string.gsub(tt, " product","")
        return fmt(tt, "Error" .. state)
    end
end

f_stateWithElementName = function(fid)
    state = core_unit[1].getElementIndustryInfoById(fid)["state"]
    elementName = core_unit[1].getElementNameById(fid)
    elementName = string.gsub(elementName, "Craft ", "")
    local label = ""
    if state == 1 then
        if isElementConfigured(fid) then
            label = "Stopped"
        else
            label = "Unconfig"
        end
    elseif state == 2 then
        label = "Running"
    elseif state == 3 then
        label = "Ingredient"
    elseif state == 4 then
        label = "Output full"
    elseif state == 5 then
        label = "No output"
    elseif state == 6 then
        label = "Pending"
    elseif state == 7 then
        label = "Schematic"
    elseif state > 7 then
        label = "ERROR"
    end
    if not Show_State then
        return elementName
    elseif State_As_Prefix then
        return label .. " - " .. elementName
    else
        return elementName .. " - " .. label
    end
end

isElementConfigured = function(fid)
        local industryInfo = core_unit[1].getElementIndustryInfoById(fid)
                if industryInfo == nil then
                        return false
                end
        local currentProducts = industryInfo["currentProducts"]
                if currentProducts == nil or #currentProducts == 0 then
                        return false
                end
        local productInfo = system.getItem(currentProducts[1]["id"])
                if productInfo == nil then
                        return false
                end

        return true
end

getStateLabel = function(fid)
    local state = core_unit[1].getElementIndustryInfoById(fid)["state"]
    if state == 1 then
        if isElementConfigured(fid) then
            return "Stopped"
        else
            return "Unconfig"
        end
    elseif state == 2 then
        return "Running"
    elseif state == 3 then
        return "Ingredient"
    elseif state == 4 then
        return "Output full"
    elseif state == 5 then
        return "No output"
    elseif state == 6 then
        return "Pending"
    elseif state == 7 then
        return "Schematic"
    else
        return "Error" .. state
    end
end

setNextFillColourByState = function(fid)
    state = core_unit[1].getElementIndustryInfoById(fid)["state"]
    if state == 1 then return "setNextFillColor(layer,1,1,0,".. Brightness ..")"
        elseif state == 2 then return "setNextFillColor(layer,0,1,0,".. Brightness ..")"
        elseif state == 3 then return "setNextFillColor(layer,1,0,0.8,".. Brightness ..")"
        elseif state == 4 then return "setNextFillColor(layer,1,0.5,0,".. Brightness ..")"
        elseif state == 5 then return "setNextFillColor(layer,1,0,0,".. Brightness ..")"
        elseif state == 6 then return "setNextFillColor(layer,0,0.5,1,".. Brightness ..")"
        elseif state == 7 then return "setNextFillColor(layer,1,0,0,".. Brightness ..")"
        else return ""
    end
end

getItemTier = function(fid)
    local info = core_unit[1].getElementIndustryInfoById(fid)["currentProducts"]
    if info and #info >= 1 then
        local item = system.getItem(info[1]["id"])
        if item then return item["tier"] end
    end
    return 0
end

t_stats = function(fid, ax, ay)
    local info = core_unit[1].getElementIndustryInfoById(fid)
    local currentProducts = info["currentProducts"]
    local maintain, batch
    if currentProducts == nil or currentProducts[1] == nil then
        maintain = "-----"
        batch    = "-----"
    else
        maintain = string.format("%d", info["maintainProductAmount"])
        batch    = string.format("%d", currentProducts[1]["quantity"])
    end
        return string.format(
        "setNextFillColor(layer, .6,.6,.6,%s)\nsetNextTextAlign(layer, AlignH_Right, AlignV_Middle)\naddText(layer, font3, \"M:%s B:%s\", %d, %d)\n",
        Brightness,
        maintain,
        batch,
        ax,
        ay
    )
end

local function formatIndex(value)
    if value < 10 then
        return string.format("00%d", value)
    elseif value < 100 then
        return string.format("0%d", value)
    else
        return tostring(value)
    end
end

indy_column = function(context, indy, tier, startIndex)
    startIndex = startIndex or 1

    local entries = {}
    if Show_Indy_Name then
        for _, id in ipairs(indy) do
            if (not Sort_By_Item_Tier) or (getItemTier(id) == tier) then
                table.insert(entries, {
                    mid = id,
                    name = string.gsub(core_unit[1].getElementNameById(id), "Craft ", ""),
                    state = core_unit[1].getElementIndustryInfoById(id)["state"],
                    stateLabel = getStateLabel(id)
                })
            end
        end
        table.sort(entries, function(a, b)
            if Sort_By_State then
                if State_Sort_Mode == 'A' and a.stateLabel ~= b.stateLabel then
                    return a.stateLabel < b.stateLabel
                elseif State_Sort_Mode == 'V' and a.state ~= b.state then
                    return a.state < b.state
                end
            end
            return a.name < b.name
        end)
    else
        for _, id in ipairs(indy) do
            local industryInfo = core_unit[1].getElementIndustryInfoById(id)["currentProducts"]
            if industryInfo and #industryInfo >= 1 then
                local itemInfo = system.getItem(industryInfo[1]["id"])
                if itemInfo and ((not Sort_By_Item_Tier) or itemInfo["tier"] == tier) then
                    local tempName = itemInfo["displayNameWithSize"]
                    local name = getName(tempName)
                    table.insert(entries, {
                        mid = id,
                        name = string.lower(name),
                        state = core_unit[1].getElementIndustryInfoById(id)["state"],
                        stateLabel = getStateLabel(id)
                    })
                end
            end
        end
        table.sort(entries, function(a, b)
            if Sort_By_State then
                if State_Sort_Mode == 'A' and a.stateLabel ~= b.stateLabel then
                    return a.stateLabel < b.stateLabel
                elseif State_Sort_Mode == 'V' and a.state ~= b.state then
                    return a.state < b.state
                end
            end
            return a.name < b.name
        end)
    end

    local totalEntries = #entries
    if totalEntries == 0 or startIndex > totalEntries then
        return "", nil, totalEntries
    end

    local fillColorScript = ""
    if tier <= 1 then
        fillColorScript = "setDefaultFillColor(layer, Shape_Text, " .. Tier_1_Colour .. ", " .. Brightness .. ")\n"
    elseif tier == 2 then
        fillColorScript = "setDefaultFillColor(layer, Shape_Text, " .. Tier_2_Colour .. ", " .. Brightness .. ")\n"
    elseif tier == 3 then
        fillColorScript = "setDefaultFillColor(layer, Shape_Text, " .. Tier_3_Colour .. ", " .. Brightness .. ")\n"
    elseif tier == 4 then
        fillColorScript = "setDefaultFillColor(layer, Shape_Text, " .. Tier_4_Colour .. ", " .. Brightness .. ")\n"
    elseif tier >= 5 then
        fillColorScript = "setDefaultFillColor(layer, Shape_Text, " .. Tier_5_Colour .. ", " .. Brightness .. ")\n"
    end

    local parts = {}
    if fillColorScript ~= "" then
        table.insert(parts, fillColorScript)
    end

    local columnIndex = context.columnIndex
    local y = context.y
    local i = startIndex

    while i <= totalEntries do
        if columnIndex > maxColumns then
            context.columnIndex = columnIndex
            context.y = y
            return table.concat(parts), i, totalEntries
        end

        if y >= Border then
            y = 20
            columnIndex = columnIndex + 1
            if columnIndex > maxColumns then
                context.columnIndex = columnIndex
                context.y = y
                return table.concat(parts), i, totalEntries
            end
        end

        local entry = entries[i]
        local x = columnPositions[columnIndex]
        local num = formatIndex(i)

        table.insert(parts, string.format("addText(layer, font3, \"%s\", %d, %d)\n", num, x, y))
        table.insert(parts, setNextFillColourByState(entry.mid))
        if Show_Indy_Name then
            table.insert(parts, string.format("addText(layer, font3, \"%s\", %d, %d)\n", f_stateWithElementName(entry.mid), x + 20, y))
        else
            table.insert(parts, string.format("addText(layer, font3, \"%s\", %d, %d)\n", f_state(entry.mid, 0), x + 20, y))
        end
        if Show_Maintain_Batch then
            table.insert(parts, t_stats(entry.mid, x + 240, y))
        end

        y = y + 10
        i = i + 1
    end

    context.columnIndex = columnIndex
    context.y = y

    return table.concat(parts), nil, totalEntries
end

local function mergeTables(...)
    local result = {}
    for _,t in ipairs({...}) do
        for _,v in ipairs(t) do table.insert(result, v) end
    end
    return result
end

local electronicsAllList, printerAllList, chemicalAllList, glassAllList
local refinerAllList, smelterAllList, honeyAllList, recyclerAllList
local assemblyAllList, metalworkAllList

if Sort_By_Item_Tier then
    electronicsAllList = mergeTables(electronics1, electronics2, electronics3, electronics4)
    printerAllList = mergeTables(printer1, printer2, printer3, printer4)
    chemicalAllList = mergeTables(chemical1, chemical2, chemical3, chemical4)
    glassAllList = mergeTables(glass1, glass2, glass3, glass4)
    refinerAllList = mergeTables(refiner1, refiner2, refiner3, refiner4)
    smelterAllList = mergeTables(smelter1, smelter2, smelter3, smelter4)
    honeyAllList = mergeTables(honey1, honey2, honey3, honey4)
    recyclerAllList = mergeTables(recycler1, recycler2, recycler3, recycler4)
    assemblyAllList = mergeTables(assembly1, assembly2, assembly3, assembly4)
    metalworkAllList = mergeTables(metalwork1, metalwork2, metalwork3, metalwork4)
end

local brightness = options.Brightness or 1
local background = options.Background or ''
local backgroundScript = "setNextFillColor(layer,0,0,0,0)\nsetNextStrokeWidth(layer, 1)\naddBoxRounded(layer, 0, 0, rx, ry, 10)\n"
if background ~= '' then
    if string.match(string.lower(background), "^%a+://") then
        backgroundScript = "local bg = loadImage(\"" .. background .. "\")\naddImage(layer,bg,0,0,rx,ry)\nsetNextFillColor(layer,0,0,0,0)\nsetNextStrokeWidth(layer,1)\naddBoxRounded(layer,0,0,rx,ry,10)\n"
    else
        local r, g, b = background:match("([%d%.]+)%s*,%s*([%d%.]+)%s*,%s*([%d%.]+)")
        if r and g and b then
            backgroundScript = "setNextFillColor(layer," .. r .. "," .. g .. "," .. b .. "," .. Brightness .. ")\nsetNextStrokeWidth(layer,1)\naddBoxRounded(layer,0,0,rx,ry,10)\n"
        end
    end
end

local function getGroupSources(group)
    if Sort_By_Item_Tier then
        local list = group.allList or {}
        return {
            { list = list, tier = 1 },
            { list = list, tier = 2 },
            { list = list, tier = 3 },
            { list = list, tier = 4 },
            { list = list, tier = 5 }
        }
    else
        return {
            { list = group.tiers[1] or {}, tier = 1 },
            { list = group.tiers[2] or {}, tier = 2 },
            { list = group.tiers[3] or {}, tier = 3 },
            { list = group.tiers[4] or {}, tier = 4 }
        }
    end
end

local function renderGroupSegment(context, group, state)
    local sources = getGroupSources(group)
    state.tierStarts = state.tierStarts or {}
    for index = 1, #sources do
        state.tierStarts[index] = state.tierStarts[index] or 1
    end

    local headerLabel = group.name
    if state.continued then
        headerLabel = headerLabel .. ' (cont.)'
    end

    local columnIndex = context.columnIndex
    local headerX = columnPositions[columnIndex]
    if not headerX then
        return '', state, false
    end

    local parts = { string.format("header(%q, %d, %d, %d)\n", headerLabel, context.y, headerX, group.count or 0) }
    context.y = context.y + 40

    for idx, source in ipairs(sources) do
        local script, nextIndex, totalEntries = indy_column(context, source.list, source.tier, state.tierStarts[idx])
        if script ~= '' then
            table.insert(parts, script)
        end
        if nextIndex then
            state.tierStarts[idx] = nextIndex
            state.continued = true
            return table.concat(parts), state, false
        else
            state.tierStarts[idx] = (totalEntries or 0) + 1
        end
    end

    state.tierStarts = nil
    state.continued = false
    return table.concat(parts), state, true  
end

local function buildScreenScript(content)
    local headerFillAlpha = 0.2 * Brightness
    local scriptParts = {
        "local layer = createLayer()\n",
        "local rx, ry = getResolution()\n\n",
        string.format("local font = loadFont(\"Oxanium\",%d)\n", Font_Size),
        string.format("local font3 = loadFont(\"RobotoCondensed\", %d)\n\n", Font_Size - 2),
        string.format("setDefaultFillColor(layer, Shape_Text, 0,0,1,%s)\n", Brightness),
        string.format("setDefaultStrokeColor(layer, Shape_Line, 0,.3,2,%s)\n", Brightness),
        string.format("setDefaultStrokeColor(layer, Shape_BoxRounded, 0,.3,2,%s)\n\n", Brightness),
        backgroundScript,
        "local div = rx/4\n\n",
        "local header = function(tag, y, p, n)\n",
        string.format("    setNextFillColor(layer, 0,0,1,%s)\n", headerFillAlpha),
        "    setNextStrokeWidth(layer, .1)\n",
        "    addBoxRounded(layer, p, y, div - 20, 20, 4)\n",
        "    setNextTextAlign(layer, AlignH_Center, AlignV_Middle)\n",
        string.format("    setNextFillColor(layer, 1,1,1,%s)\n", Brightness),
        "    addText(layer, font, '(' .. n .. ') ' .. tag, div/2 + (p) - 10, y + 11)\n",
        "end\n\n",
        "for x = 1,5 do addLine(layer, div * x, 0, div * x, ry) end\n\n",
        content
    }

    return table.concat(scriptParts)
end

local groups = {
    { name = 'Electronics Industry', count = electronics_all, tiers = { electronics1, electronics2, electronics3, electronics4 }, allList = electronicsAllList },
    { name = 'Chemical Industry', count = chemical_all, tiers = { chemical1, chemical2, chemical3, chemical4 }, allList = chemicalAllList },
    { name = 'Glass Industry', count = glass_all, tiers = { glass1, glass2, glass3, glass4 }, allList = glassAllList },
    { name = '3D Printers', count = printer_all, tiers = { printer1, printer2, printer3, printer4 }, allList = printerAllList },
    { name = 'Refiners', count = refiner_all, tiers = { refiner1, refiner2, refiner3, refiner4 }, allList = refinerAllList },
    { name = 'Smelters', count = smelter_all, tiers = { smelter1, smelter2, smelter3, smelter4 }, allList = smelterAllList },
    { name = 'Honeycomb', count = honey_all, tiers = { honey1, honey2, honey3, honey4 }, allList = honeyAllList },
    { name = 'Recyclers', count = recycler_all, tiers = { recycler1, recycler2, recycler3, recycler4 }, allList = recyclerAllList },
    { name = 'Assembly Lines', count = assembly_all, tiers = { assembly1, assembly2, assembly3, assembly4 }, allList = assemblyAllList },
    { name = 'Metalwork Industry', count = metalwork_all, tiers = { metalwork1, metalwork2, metalwork3, metalwork4 }, allList = metalworkAllList }
}

local screensContent = {}
local context = newLayoutContext()
local currentParts = {}

local function finalizeScreen()
    if #currentParts == 0 then
        context = newLayoutContext()
        return
    end

    table.insert(screensContent, buildScreenScript(table.concat(currentParts)))
    currentParts = {}
    context = newLayoutContext()
end

for _, group in ipairs(groups) do
    local state = {}
    while true do
        if context.columnIndex > maxColumns then
            finalizeScreen()
        end

        if context.columnIndex > maxColumns then
            break
        end

        local content, updatedState, finished = renderGroupSegment(context, group, state)
        state = updatedState or state

        if content ~= '' then
            table.insert(currentParts, content)
        end

        if finished then
            break
        else
            finalizeScreen()
        end
    end
end

if #currentParts > 0 then
    finalizeScreen()
end

local emptyScreenScript = buildScreenScript('')

if #screensContent == 0 then
    table.insert(screensContent, emptyScreenScript)
end

for index, screen in ipairs(screens) do
    screen.activate()
    local script = screensContent[index] or emptyScreenScript
    screen.setRenderScript(script)
end

if #screensContent > #screens then
    system.print(string.format('Warning: %d screens required but only %d connected', #screensContent, #screens))
end