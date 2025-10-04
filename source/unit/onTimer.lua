local columnPositions = {10, 266, 522, 778}
local maxColumns = #columnPositions
local MACHINE_TIER_COUNT = 4
local ITEM_TIER_COUNT = 5

local function newLayoutContext()
    return { columnIndex = 1, y = 10 }
end

local headerHeight = 40
local entrySpacing = 10
local columnStartY = 20

local function getBorderLimit()
    if type(Border) == 'number' then
        return Border
    end

    return 600
end

local function computeRemainingCapacityForContext(columnIndex, y)
    local borderLimit = getBorderLimit()
    local currentColumn = columnIndex or 1
    local currentY = y or 0
    local remaining = 0

    while currentColumn <= maxColumns do
        if currentY >= borderLimit then
            currentColumn = currentColumn + 1
            currentY = columnStartY
        else
            remaining = remaining + 1
            currentY = currentY + entrySpacing
        end
    end

    return remaining
end

local function deepCopy(value)
    if type(value) ~= 'table' then
        return value
    end

    local copy = {}
    for key, item in pairs(value) do
        if type(item) == 'table' then
            copy[key] = deepCopy(item)
        else
            copy[key] = item
        end
    end

    return copy
end

local function getRemainingCapacityForNewGroup(context)
    return computeRemainingCapacityForContext(context.columnIndex, (context.y or 0) + headerHeight)
end

local screenCapacity
do
    local layout = newLayoutContext()
    screenCapacity = computeRemainingCapacityForContext(layout.columnIndex, layout.y + headerHeight)
end

local function getIndustryInfo(fid)
    if not core_unit or not core_unit[1] then
        return nil
    end 

    local ok, info = pcall(function()
        return core_unit[1].getElementIndustryInfoById(fid)
    end)

    if not ok or type(info) ~= 'table' then
        return nil
    end

    return info
end

local function safeGetState(info)
    if info and info["state"] then
        return info["state"]
    end

    return nil
end

local function getCurrentProduct(info)
    if not info then
        return nil
    end

    local products = info["currentProducts"]
    if products and products[1] then
        return products[1]
    end

    return nil
end

local function formatDisplayName(displayName)
    if not displayName then
        return nil
    end

    local tt = string.gsub(displayName, "Advanced","Adv.")
    tt = string.gsub(tt, "hydraulics","Hydraulics")
    tt = string.gsub(tt, "Uncommon","Unc.")
    tt = string.gsub(tt, " product","")
    return tt
end

local function getFormattedProductName(info)
    local product = getCurrentProduct(info)
    if not product then
        return nil
    end

    local itemInfo = system.getItem(product["id"])
    if not itemInfo then
        return nil
    end

    return formatDisplayName(itemInfo["displayNameWithSize"] or itemInfo["displayName"])
end

f_state = function(fid, F)
   local info = getIndustryInfo(fid)
    if not info then
        return "Not available"
    end

    state = safeGetState(info)
    local function fmt(name, label)
        if not Show_State then
            return name
        elseif State_As_Prefix then
            return label .. " - " .. name
        else
            return name .. " - " .. label
        end
    end
        if state == nil then
        return "Not available"
    end

    if state < 1 and F == 0 then
        local productName = getFormattedProductName(info)
        if not productName then
            return fmt("Unknown", "Error" .. state)
        end
        return fmt(productName, "Error" .. state)
    elseif state == 1 and F == 0 then
        local industryInfo = info
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
                local tt = formatDisplayName(displayNameWithSize)
        if not tt then
            return "Not configured"
        end
        return fmt(tt, "Stopped")
    elseif state == 2 and F == 0 then
        local productName = getFormattedProductName(info)
        if not productName then
            return fmt("Unknown", "Running")
        end
        return fmt(productName, "Running")
    elseif state == 3 and F == 0 then
        local productName = getFormattedProductName(info)
        if not productName then
            return fmt("Unknown", "Missing ingredient")
        end
        return fmt(productName, "Missing ingredient")
    elseif state == 4 and F == 0 then
        local productName = getFormattedProductName(info)
        if not productName then
            return fmt("Unknown", "Output full")
        end
        return fmt(productName, "Output full")
    elseif state == 5 and F == 0 then
        local productName = getFormattedProductName(info)
        if not productName then
            return fmt("Unknown", "No output container")
        end
        return fmt(productName, "No output container")
    elseif state == 6 and F == 0 then
        local productName = getFormattedProductName(info)
        if not productName then
            return fmt("Unknown", "Pending")
        end
        return fmt(productName, "Pending")
    elseif state == 7 and F == 0 then
        local productName = getFormattedProductName(info)
        if not productName then
            return fmt("Unknown", "Missing schematics")
        end
        return fmt(productName, "Missing schematics")
    elseif state > 7 and F == 0 then
        local productName = getFormattedProductName(info)
        if not productName then
            return fmt("Unknown", "Error" .. state)
        end
        return fmt(productName, "Error" .. state)
    end
end

f_stateWithElementName = function(fid)
    local info = getIndustryInfo(fid)
    if not info then
        return core_unit[1].getElementNameById(fid)
    end

    state = safeGetState(info)
    elementName = core_unit[1].getElementNameById(fid)
    elementName = string.gsub(elementName, "Craft ", "")
    local label = ""
    if state == nil then
        label = "Unknown"
    elseif state == 1 then
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
        local industryInfo = getIndustryInfo(fid)
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
    local info = getIndustryInfo(fid)
    if not info then
        return "Unknown"
    end

    local state = safeGetState(info)
    if state == nil then
        return "Unknown"
    end
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
    local info = getIndustryInfo(fid)
    local state = safeGetState(info)
    if state == nil then return "" end
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
    local info = getIndustryInfo(fid)
    if not info then
        return 0
    end

    local products = info["currentProducts"]
    if products and #products >= 1 then
        local item = system.getItem(products[1]["id"])
        if item then return item["tier"] end
    end
    return 0
end

getMachineTier = function(fid)
    if machineTierById then
        return machineTierById[fid] or 0
    end
    return 0
end

t_stats = function(fid, ax, ay)
    local info = getIndustryInfo(fid)
    if not info then
        return ""
    end
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
            local itemTier = getItemTier(id)
            local machineTier = getMachineTier(id)
            if (not Sort_By_Item_Tier) or itemTier == tier or (itemTier == 0 and machineTier == tier) then
                local info = getIndustryInfo(id)
                if info then
                    table.insert(entries, {
                        mid = id,
                        name = string.gsub(core_unit[1].getElementNameById(id), "Craft ", ""),
                        state = safeGetState(info) or -1,
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
    else
        for _, id in ipairs(indy) do
            local industryData = getIndustryInfo(id)
            if not industryData then
                goto continue
            end
            local currentProducts = industryData["currentProducts"]
            local itemTier = 0
            local displayName
            if currentProducts and #currentProducts >= 1 then
                local itemInfo = system.getItem(currentProducts[1]["id"])
                if itemInfo then
                    itemTier = itemInfo["tier"] or 0
                    displayName = getName(itemInfo["displayNameWithSize"])
                end
            end

            local machineTier = getMachineTier(id)
            if (not Sort_By_Item_Tier) or itemTier == tier or (itemTier == 0 and machineTier == tier) then
                if not displayName then
                    displayName = getName(core_unit[1].getElementNameById(id))
                end
                table.insert(entries, {
                    mid = id,
                    name = string.lower(displayName),
                    state = safeGetState(industryData) or -1,
                    stateLabel = getStateLabel(id)
                })
            end
            ::continue::
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

local groupDefinitions

local groupKeyAliases = {
    electronics = 'electronics',
    electronic = 'electronics',
    chemical = 'chemical',
    chemicals = 'chemical',
    glass = 'glass',
    glasses = 'glass',
    printers = 'printers',
    printer = 'printers',
    ['3dprinters'] = 'printers',
    ['3dprinter'] = 'printers',
    refiners = 'refiners',
    refiner = 'refiners',
    refineries = 'refiners',
    refinery = 'refiners',
    smelters = 'smelters',
    smelter = 'smelters',
    honeycomb = 'honeycomb',
    honeycombs = 'honeycomb',
    honey = 'honeycomb',
    recyclers = 'recyclers',
    recycler = 'recyclers',
    recycling = 'recyclers',
    assembly = 'assembly',
    assemblies = 'assembly',
    assembler = 'assembly',
    assemblers = 'assembly',
    ['assemblyline'] = 'assembly',
    ['assemblylines'] = 'assembly',
    metalwork = 'metalwork',
    metalworks = 'metalwork'
}

local defaultGroupOrder = {
    'electronics',
    'chemical',
    'glass',
    'printers',
    'refiners',
    'smelters',
    'honeycomb',
    'recyclers',
    'assembly',
    'metalwork'
}

local cachedGroupOrderString
local cachedGroupOrderResult
local cachedGroupOrderInvalidTokens

local function normalizeGroupOrderKey(key)
    if type(key) ~= 'string' then
        return nil
    end

    local normalized = key:lower()
    normalized = normalized:gsub('%s+', '')
    normalized = normalized:gsub('[^%w]', '')
    if normalized == '' then
        return nil
    end

    return normalized
end

local function resolveGroupKey(key)
    local normalized = normalizeGroupOrderKey(key)
    if not normalized then
        return nil
    end

    local resolved = groupKeyAliases[normalized] or normalized
    if groupDefinitions and groupDefinitions[resolved] then
        return resolved
    end

    return nil
end

local function computeGroupOrder(orderString)
    if type(orderString) ~= 'string' then
        orderString = ''
    end

    if cachedGroupOrderString == orderString and cachedGroupOrderResult then
        return cachedGroupOrderResult
    end

    local seen = {}
    local parsed = {}
    local invalidTokens = {}

    for entry in orderString:gmatch('[^,]+') do
        local trimmed = entry:match('^%s*(.-)%s*$')
        if trimmed ~= '' then
            local resolved = resolveGroupKey(trimmed)
            if resolved then
                if not seen[resolved] then
                    table.insert(parsed, resolved)
                    seen[resolved] = true
                end
            else
                table.insert(invalidTokens, trimmed)
            end
        end
    end

    for _, key in ipairs(defaultGroupOrder) do
        if not seen[key] then
            table.insert(parsed, key)
            seen[key] = true
        end
    end

    cachedGroupOrderString = orderString
    cachedGroupOrderResult = parsed
    cachedGroupOrderInvalidTokens = table.concat(invalidTokens, ', ')

    if #invalidTokens > 0 then
        system.print("Unknown group(s) in Group_Order: " .. cachedGroupOrderInvalidTokens)
    end

    return parsed
end

local function getGroupsInConfiguredOrder()
    local keys = computeGroupOrder(options.Group_Order or '')
    local ordered = {}
    for _, key in ipairs(keys) do
        local group = groupDefinitions and groupDefinitions[key]
        if group then
            table.insert(ordered, group)
        end
    end
    return ordered
end

local function getGroupSources(group)
    if Sort_By_Item_Tier then
        local list = group.allList or {}
        local sources = {}
        for tier = 1, ITEM_TIER_COUNT do
            table.insert(sources, { list = list, tier = tier })
        end
        return sources
    else
        local sources = {}
        for tier = 1, MACHINE_TIER_COUNT do
            table.insert(sources, { list = group.tiers[tier] or {}, tier = tier })
        end
        return sources
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

local SCREEN_SCRIPT_LIMIT = 50000
local DEBUG_SCREEN_SCRIPT_LIMIT = false

local baseScriptLength
local emptyScreenScript
do
    emptyScreenScript = buildScreenScript('')
    baseScriptLength = #emptyScreenScript
end

groupDefinitions = {
    electronics = { key = 'electronics', name = 'Electronics Industry', count = electronics_all, tiers = { electronics1, electronics2, electronics3, electronics4 }, allList = electronicsAllList },
    chemical = { key = 'chemical', name = 'Chemical Industry', count = chemical_all, tiers = { chemical1, chemical2, chemical3, chemical4 }, allList = chemicalAllList },
    glass = { key = 'glass', name = 'Glass Industry', count = glass_all, tiers = { glass1, glass2, glass3, glass4 }, allList = glassAllList },
    printers = { key = 'printers', name = '3D Printers', count = printer_all, tiers = { printer1, printer2, printer3, printer4 }, allList = printerAllList },
    refiners = { key = 'refiners', name = 'Refiners', count = refiner_all, tiers = { refiner1, refiner2, refiner3, refiner4 }, allList = refinerAllList },
    smelters = { key = 'smelters', name = 'Smelters', count = smelter_all, tiers = { smelter1, smelter2, smelter3, smelter4 }, allList = smelterAllList },
    honeycomb = { key = 'honeycomb', name = 'Honeycomb', count = honey_all, tiers = { honey1, honey2, honey3, honey4 }, allList = honeyAllList },
    recyclers = { key = 'recyclers', name = 'Recyclers', count = recycler_all, tiers = { recycler1, recycler2, recycler3, recycler4 }, allList = recyclerAllList },
    assembly = { key = 'assembly', name = 'Assembly Lines', count = assembly_all, tiers = { assembly1, assembly2, assembly3, assembly4 }, allList = assemblyAllList },
    metalwork = { key = 'metalwork', name = 'Metalwork Industry', count = metalwork_all, tiers = { metalwork1, metalwork2, metalwork3, metalwork4 }, allList = metalworkAllList }
}

local groups = getGroupsInConfiguredOrder()

local screensContent = {}
local context = newLayoutContext()
local currentParts = {}
local currentLength = 0

local function finalizeScreen()
    if #currentParts == 0 then
        context = newLayoutContext()
        currentLength = 0
        return
    end

    table.insert(screensContent, buildScreenScript(table.concat(currentParts)))
    currentParts = {}
    context = newLayoutContext()
    currentLength = 0
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

        local shouldFinalizeBeforeRender = false
        if not state.tierStarts and #currentParts > 0 then
            local groupCount = tonumber(group.count) or 0
            if groupCount > 0 then
                local remainingCapacity = getRemainingCapacityForNewGroup(context)
                if remainingCapacity <= 0 or (groupCount <= screenCapacity and groupCount > remainingCapacity) then
                    shouldFinalizeBeforeRender = true
                end
            end
        end

        if shouldFinalizeBeforeRender then
            finalizeScreen()
        else
            local skipRender = false

            while true do
                local headerBottom = (context.y or 0) + headerHeight
                local borderLimit = getBorderLimit()

                if headerBottom < borderLimit then
                    break
                end

                if context.columnIndex < maxColumns then
                    context.columnIndex = context.columnIndex + 1
                    context.y = newLayoutContext().y
                else
                    finalizeScreen()
                    skipRender = true
                    break
                end
            end

            if not skipRender then
                local previousState = deepCopy(state)
                local content, updatedState, finished = renderGroupSegment(context, group, state)
                state = updatedState or state

                local shouldRetrySegment = false

                if content ~= '' then
                    local contentLength = #content
                    local upcomingLength = currentLength + contentLength + baseScriptLength

                    if upcomingLength > SCREEN_SCRIPT_LIMIT then
                        if DEBUG_SCREEN_SCRIPT_LIMIT then
                            system.print(string.format('Debug: screen script length would reach %d (limit %d) while rendering %s; finalizing current screen', upcomingLength, SCREEN_SCRIPT_LIMIT, group.name))
                        end
                        finalizeScreen()
                        state = previousState
                        shouldRetrySegment = true
                    else
                        table.insert(currentParts, content)
                        currentLength = currentLength + contentLength
                    end
                end

                if not shouldRetrySegment then
                    if finished then
                        break
                    else
                        finalizeScreen()
                    end
                end
            end
        end
    end
end

if #currentParts > 0 then
    finalizeScreen()
end

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