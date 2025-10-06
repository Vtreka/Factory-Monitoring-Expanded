-- Script created by Bartas (ingame), BartasRS#2742 (Discord)
-- Updates provided by Vtreka (ingame), Vtreka#1337 (Discord)
-- Contributions provided by BlimpieBoy (ingame), Blimpieboy#0903 (Discord)

system.print(" --- Factory Monitor Expanded v3.4 ---")
system.print ("type 'help' for available commands")

--[[ LUA PARAMETERS ]]
Use_Databank_Values = false --export: If checked and if values were saved in databank, parmaters will be loaded from the databank, if not, following ones will be used
Turn_Screens_Off_on_Exit = false --export: Turn off all connected screens when the board stops
Show_Indy_Name = false --export: Shows Industry Unit name instead of element being crafted if checked
Show_Maintain_Batch = true --export: Display maintain and batch values for each machine
Show_State = true --export: Show machine state if checked
Sort_By_Item_Tier = true --export: Sort by item tier instead of Industry Unit tier
Sort_By_State = false --export: Sort machines by state
State_As_Prefix = false --export: Put state before the machine/item name if checked
State_Sort_Mode = 'V' --export: When sorting by state, 'A' sorts alphabetically and 'V' by default value
Border = 600 --export: Bottom display line<br>Maximum 600<br>Use to adjust
Refresh_Timer = 5 --export: Screen(s) refresh timer in seconds
Brightness = 1 --export: Adjust text and background transparency (0 to 1)
Font_Size = 12 -- Base font size for text
Background = '0, 0, 0' --export: Set background colour "r, g, b" or image URL (make sure to include the http:// or https://)
Tier_1_Colour = '0.8, 0.8, 0.8' --export: Set Tier 1 Colour
Tier_2_Colour = '0, 1.5, 0' --export: Set Tier 2 Colour
Tier_3_Colour = '0, 0.15, 1' --export: Set Tier 3 Colour
Tier_4_Colour = '1, 0, 1.5' --export: Set Tier 4 Colour
Tier_5_Colour = '2, 0.8, 0' --export: Set Tier 5 Colour
Group_Order = 'assembly, electronics, chemical, glass, printers, refiners, smelters, honeycomb, recyclers, metalwork' --export: Comma separated industry group keys (electronics, chemical, glass, printers, refiners, smelters, honeycomb, recyclers, assembly, metalwork)
Hidden_Groups = '' --export: Comma separated industry group keys to hide from processing and display (electronics, chemical, glass, printers, refiners, smelters, honeycomb, recyclers, assembly, metalwork)

system.print("Refresh timer set to: "..Refresh_Timer.." seconds")

options = {}
options.Show_Indy_Name = Show_Indy_Name
options.Border = Border
options.Tier_1_Colour = Tier_1_Colour
options.Tier_2_Colour = Tier_2_Colour
options.Tier_3_Colour = Tier_3_Colour
options.Tier_4_Colour = Tier_4_Colour
options.Tier_5_Colour = Tier_5_Colour
options.Brightness = Brightness
options.Background = Background
-- options.Font_Size = Font_Size
options.Sort_By_Item_Tier = Sort_By_Item_Tier
options.Sort_By_State = Sort_By_State
options.State_As_Prefix = State_As_Prefix
options.State_Sort_Mode = State_Sort_Mode
options.Show_Maintain_Batch = Show_Maintain_Batch
options.Show_State = Show_State
options.Turn_Screens_Off_on_Exit = Turn_Screens_Off_on_Exit
options.Group_Order = Group_Order
options.Hidden_Groups = Hidden_Groups

groupKeyAliases = groupKeyAliases or {
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

groupDisplayNames = groupDisplayNames or {
    electronics = 'Electronics Industry',
    chemical = 'Chemical Industry',
    glass = 'Glass Industry',
    printers = '3D Printers',
    refiners = 'Refiners',
    smelters = 'Smelters',
    honeycomb = 'Honeycomb',
    recyclers = 'Recyclers',
    assembly = 'Assembly Lines',
    metalwork = 'Metalwork Industry'
}

validGroupKeys = validGroupKeys or {
    electronics = true,
    chemical = true,
    glass = true,
    printers = true,
    refiners = true,
    smelters = true,
    honeycomb = true,
    recyclers = true,
    assembly = true,
    metalwork = true
}

databank = nil
screens = {}
core_unit = {}

for slot_name, slot in pairs(unit) do
    if type(slot) == "table"
        and type(slot.export) == "table"
        and slot.getClass
    then
        slot.slotname = slot_name
        if slot.getClass():lower():find('screenunit') then 
            table.insert(screens,slot)
            slot.activate()
        elseif slot.getClass():lower():find('coreunit') then table.insert(core_unit,slot)
        elseif slot.getClass():lower() == 'databankunit' then
            databank = slot
        end
    end
end

if #screens == 0 then
    system.print("No screen detected")
else
    table.sort(screens, function(a,b) return a.slotname < b.slotname end)
    local plural = ""
    if #screens > 1 then plural = "s" end
    system.print(#screens .. " screen" .. plural .. " connected")
end

if #core_unit == 0 then
    system.print("No core detected") else system.print("Core connected")
end

if databank == nil then
    system.print("No Databank Detected")
else
    system.print("Databank Connected")
    if (databank.hasKey("options")) and (Use_Databank_Values == true) then
        local db_options = json.decode(databank.getStringValue("options"))
        if db_options then
            for key, value in pairs(options) do
                if db_options[key] then options[key] = db_options[key] end
            end
            system.print("Options Loaded From Databank")
        else
            system.print("No parameters saved to Databank. Restart the Programming Board")
        end
    else
        system.print("Options Loaded From LUA Parameters")
    end
end

local function normalizeGroupKey(key)
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
    local normalized = normalizeGroupKey(key)
    if not normalized then
        return nil
    end

    local resolved = groupKeyAliases[normalized] or normalized
    if validGroupKeys[resolved] then
        return resolved
    end

    return nil
end

local function parseHiddenGroups(value)
    local hiddenSet = {}
    local hiddenList = {}
    local invalidList = {}

    if type(value) ~= 'string' then
        return hiddenSet, hiddenList, invalidList
    end

    for entry in value:gmatch('[^,]+') do
        local trimmed = entry:match('^%s*(.-)%s*$')
        if trimmed ~= '' then
            local resolved = resolveGroupKey(trimmed)
            if resolved then
                if not hiddenSet[resolved] then
                    hiddenSet[resolved] = true
                    table.insert(hiddenList, resolved)
                end
            else
                table.insert(invalidList, trimmed)
            end
        end
    end

    return hiddenSet, hiddenList, invalidList
end

hiddenGroups = {}
do
    local parsedHidden, hiddenOrder, invalidTokens = parseHiddenGroups(options.Hidden_Groups or '')
    hiddenGroups = parsedHidden

    if #hiddenOrder > 0 then
        local readable = {}
        for _, key in ipairs(hiddenOrder) do
            table.insert(readable, groupDisplayNames[key] or key)
        end
        system.print('Hiding industry groups: ' .. table.concat(readable, ', '))
    end

    if #invalidTokens > 0 then
        system.print('Unknown group(s) in Hidden_Groups: ' .. table.concat(invalidTokens, ', '))
    end
end

local function isGroupHidden(key)
    return hiddenGroups and hiddenGroups[key] == true
end

elementIdList = core_unit[1].getElementIdList()

machineTierById = {}

local function registerMachine(list, counts, tierIndex, id)
    table.insert(list, id)
    counts[tierIndex] = counts[tierIndex] + 1
    machineTierById[id] = tierIndex
end

metalwork1 = {}
metalwork2 = {}
metalwork3 = {}
metalwork4 = {}

electronics1 = {}
electronics2 = {}
electronics3 = {}
electronics4 = {}

glass1 = {}
glass2 = {}
glass3 = {}
glass4 = {}

printer1 = {}
printer2 = {}
printer3 = {}
printer4 = {}

chemical1 = {}
chemical2 = {}
chemical3 = {}
chemical4 = {}

refiner1 = {}
refiner2 = {}
refiner3 = {}
refiner4 = {}

smelter1 = {}
smelter2 = {}
smelter3 = {}
smelter4 = {}

honey1 = {}
honey2 = {}
honey3 = {}
honey4 = {}

recycler1 = {}
recycler2 = {}
recycler3 = {}
recycler4 = {}

assembly1 = {}
assembly2 = {}
assembly3 = {}
assembly4 = {}

metalwork_count = {0,0,0,0}
electronics_count = {0,0,0,0}
glass_count = {0,0,0,0}
printer_count = {0,0,0,0}
chemical_count = {0,0,0,0}
refiner_count = {0,0,0,0}
smelter_count = {0,0,0,0}
assembly_count = {0,0,0,0}
honey_count = {0,0,0,0}
recycler_count = {0,0,0,0}

---- substitution list, credits to Squizz Cephinator
local ntxt = ""
function getName(ntxt)

        ntxt = ntxt:gsub(" xs$", " XS")
        ntxt = ntxt:gsub(" s$", " S")
        ntxt = ntxt:gsub(" m$", " M")
        ntxt = ntxt:gsub(" l$", " L")
        ntxt = ntxt:gsub(" xl$", " XL")
        ntxt = ntxt:gsub(" Unit$", " U")
        ntxt = ntxt:gsub("^Basic ", "B ")
        ntxt = ntxt:gsub("^Uncommon ", "U ")
        ntxt = ntxt:gsub("^Advanced ", "A ")
        ntxt = ntxt:gsub("^Rare ", "R ")
        ntxt = ntxt:gsub("^Exotic ", "X ")
        ntxt = ntxt:gsub(" industry ", " I ")
        ntxt = ntxt:gsub(" Industry ", " I ")
        ntxt = ntxt:gsub(" Reinforced ", " Rfcd ")
        ntxt = ntxt:gsub(" plastic ", " ")
        ntxt = ntxt:gsub(" product$", " ")
        ntxt = ntxt:gsub(" Product$", " ")
        ntxt = ntxt:gsub(" Container ", " Ctnr ")

    return ntxt
end

for index,id in ipairs(elementIdList) do
    elementType = core_unit[1].getElementDisplayNameById(id):lower()

    if (not isGroupHidden('metalwork')) and (elementType:find("metalwork industry")) then
            if (elementType:find("basic")) then
            registerMachine(metalwork1, metalwork_count, 1, id)
            elseif (elementType:find("uncommon")) then
            registerMachine(metalwork2, metalwork_count, 2, id)
            elseif (elementType:find("advanced")) then
            registerMachine(metalwork3, metalwork_count, 3, id)
            elseif (elementType:find("rare")) then
            registerMachine(metalwork4, metalwork_count, 4, id)
            end
    end
    if (not isGroupHidden('electronics')) and (elementType:find("electronics industry")) then
            if (elementType:find("basic")) then
            registerMachine(electronics1, electronics_count, 1, id)
            elseif (elementType:find("uncommon")) then
            registerMachine(electronics2, electronics_count, 2, id)
            elseif (elementType:find("advanced")) then
            registerMachine(electronics3, electronics_count, 3, id)
            elseif (elementType:find("rare")) then
            registerMachine(electronics4, electronics_count, 4, id)
            end
    end
    if (not isGroupHidden('glass')) and (elementType:find("glass furnace")) then
            if (elementType:find("basic")) then
            registerMachine(glass1, glass_count, 1, id)
            elseif (elementType:find("uncommon")) then
            registerMachine(glass2, glass_count, 2, id)
            elseif (elementType:find("advanced")) then
            registerMachine(glass3, glass_count, 3, id)
            elseif (elementType:find("rare")) then
            registerMachine(glass4, glass_count, 4, id)
            end
    end
    if (not isGroupHidden('printers')) and (elementType:find("3d printer")) then
            if (elementType:find("basic")) then
            registerMachine(printer1, printer_count, 1, id)
            elseif (elementType:find("uncommon")) then
            registerMachine(printer2, printer_count, 2, id)
            elseif (elementType:find("advanced")) then
            registerMachine(printer3, printer_count, 3, id)
            elseif (elementType:find("rare")) then
            registerMachine(printer4, printer_count, 4, id)
            end
    end
    if (not isGroupHidden('chemical')) and (elementType:find("chemical industry")) then
            if (elementType:find("basic")) then
            registerMachine(chemical1, chemical_count, 1, id)
            elseif (elementType:find("uncommon")) then
            registerMachine(chemical2, chemical_count, 2, id)
            elseif (elementType:find("advanced")) then
            registerMachine(chemical3, chemical_count, 3, id)
            elseif (elementType:find("rare")) then
            registerMachine(chemical4, chemical_count, 4, id)
            end
    end
    if (not isGroupHidden('refiners')) and (elementType:find("refiner")) then
            if (elementType:find("basic")) then
            registerMachine(refiner1, refiner_count, 1, id)
            elseif (elementType:find("uncommon")) then
            registerMachine(refiner2, refiner_count, 2, id)
            elseif (elementType:find("advanced")) then
            registerMachine(refiner3, refiner_count, 3, id)
            elseif (elementType:find("rare")) then
            registerMachine(refiner4, refiner_count, 4, id)
            end
    end
    if (not isGroupHidden('smelters')) and (elementType:find("smelter")) then
            if (elementType:find("basic")) then
            registerMachine(smelter1, smelter_count, 1, id)
            elseif (elementType:find("uncommon")) then
            registerMachine(smelter2, smelter_count, 2, id)
            elseif (elementType:find("advanced")) then
            registerMachine(smelter3, smelter_count, 3, id)
            elseif (elementType:find("rare")) then
            registerMachine(smelter4, smelter_count, 4, id)
            end
    end
    if (not isGroupHidden('assembly')) and (elementType:find("assembly line")) then
            if (elementType:find("basic")) then
            registerMachine(assembly1, assembly_count, 1, id)
            elseif (elementType:find("uncommon")) then
            registerMachine(assembly2, assembly_count, 2, id)
            elseif (elementType:find("advanced")) then
            registerMachine(assembly3, assembly_count, 3, id)
            elseif (elementType:find("rare")) then
            registerMachine(assembly4, assembly_count, 4, id)
            end
    end
    if (not isGroupHidden('honeycomb')) and (elementType:find("honeycomb")) then
            if (elementType:find("basic")) then
            registerMachine(honey1, honey_count, 1, id)
            elseif (elementType:find("uncommon")) then
            registerMachine(honey2, honey_count, 2, id)
            elseif (elementType:find("advanced")) then
            registerMachine(honey3, honey_count, 3, id)
            elseif (elementType:find("rare")) then
            registerMachine(honey4, honey_count, 4, id)
            end
    end
    if (not isGroupHidden('recyclers')) and (elementType:find("recycler")) then
            if (elementType:find("basic")) then
            registerMachine(recycler1, recycler_count, 1, id)
            elseif (elementType:find("uncommon")) then
            registerMachine(recycler2, recycler_count, 2, id)
            elseif (elementType:find("advanced")) then
            registerMachine(recycler3, recycler_count, 3, id)
            elseif (elementType:find("rare")) then
            registerMachine(recycler4, recycler_count, 4, id)
            end
    end
 end

metalwork_all = metalwork_count[1] + metalwork_count[2] + metalwork_count[3] + metalwork_count[4]
electronics_all = electronics_count[1] + electronics_count[2] + electronics_count[3] + electronics_count[4]
glass_all = glass_count[1] + glass_count[2] + glass_count[3] + glass_count[4]
printer_all = printer_count[1] + printer_count[2] + printer_count[3] + printer_count[4]
chemical_all = chemical_count[1] + chemical_count[2] + chemical_count[3] + chemical_count[4]
refiner_all = refiner_count[1] + refiner_count[2] + refiner_count[3] + refiner_count[4]
smelter_all = smelter_count[1] + smelter_count[2] + smelter_count[3] + smelter_count[4]
assembly_all = assembly_count[1] + assembly_count[2] + assembly_count[3] + assembly_count[4]
honey_all = honey_count[1] + honey_count[2] + honey_count[3] + honey_count[4]
recycler_all = recycler_count[1] + recycler_count[2] + recycler_count[3] + recycler_count[4]

local groupTotals = {
    electronics = electronics_all,
    chemical = chemical_all,
    glass = glass_all,
    printers = printer_all,
    refiners = refiner_all,
    smelters = smelter_all,
    honeycomb = honey_all,
    recyclers = recycler_all,
    assembly = assembly_all,
    metalwork = metalwork_all
}

local orderedGroupKeys = {
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

local visibleCountsForScreens = {}
all_count = 0

for _, key in ipairs(orderedGroupKeys) do
    local total = groupTotals[key] or 0
    if not isGroupHidden(key) then
        table.insert(visibleCountsForScreens, total)
        all_count = all_count + total
    end
end

local layoutColumnPositions = {10, 266, 522, 778}
local layoutMaxColumns = #layoutColumnPositions
local layoutHeaderHeight = 40
local layoutEntrySpacing = 10
local layoutColumnStartY = 20

local function getBorderLimitValue()
    if type(Border) == 'number' then
        return Border
    end

    return 600
end

local function computeRemainingCapacityForContext(columnIndex, y)
    local borderLimit = getBorderLimitValue()
    local currentColumn = columnIndex or 1
    local currentY = y or 0
    local remaining = 0

    while currentColumn <= layoutMaxColumns do
        if currentY >= borderLimit then
            currentColumn = currentColumn + 1
            currentY = layoutColumnStartY
        else
            remaining = remaining + 1
            currentY = currentY + layoutEntrySpacing
        end
    end

    return remaining
end

local function getRemainingCapacityForNewGroup(context)
    return computeRemainingCapacityForContext(context.columnIndex, (context.y or 0) + layoutHeaderHeight)
end

local screenCapacity = computeRemainingCapacityForContext(1, 10 + layoutHeaderHeight)

local function estimateScreensNeeded(groupCounts)
    local context = { columnIndex = 1, y = 10 }
    local screensNeeded = 0
    local hasContent = false

    local function resetContext()
        context.columnIndex = 1
        context.y = 10
    end

    local function finalizeScreen()
        if hasContent then
            screensNeeded = screensNeeded + 1
            hasContent = false
        end
        resetContext()
    end

    for _, totalCount in ipairs(groupCounts) do
        local groupTotal = tonumber(totalCount) or 0
        local remaining = groupTotal
        local continuing = false

        repeat
            if context.columnIndex > layoutMaxColumns then
                finalizeScreen()
            end

            if not continuing and hasContent and groupTotal > 0 then
                local remainingCapacity = getRemainingCapacityForNewGroup(context)
                if remainingCapacity <= 0 or (groupTotal <= screenCapacity and groupTotal > remainingCapacity) then
                    finalizeScreen()
                end
            end

            while (context.y or 0) + layoutHeaderHeight >= getBorderLimitValue() do
                if context.columnIndex < layoutMaxColumns then
                    context.columnIndex = context.columnIndex + 1
                    context.y = 10
                else
                    finalizeScreen()
                end
            end

            hasContent = true
            context.y = context.y + layoutHeaderHeight

            while remaining > 0 do
                if context.columnIndex > layoutMaxColumns then
                    break
                end

                if context.y >= getBorderLimitValue() then
                    if context.columnIndex < layoutMaxColumns then
                        context.columnIndex = context.columnIndex + 1
                        context.y = layoutColumnStartY
                    else
                        break
                    end
                else
                    context.y = context.y + layoutEntrySpacing
                    remaining = remaining - 1
                end
            end

            if remaining > 0 then
                continuing = true
                finalizeScreen()
            else
                continuing = false
            end
        until remaining == 0 and not continuing
    end

    if hasContent then
        screensNeeded = screensNeeded + 1
    end

    if screensNeeded == 0 then
        screensNeeded = 1
    end

    return screensNeeded
end

local required_screens = estimateScreensNeeded(visibleCountsForScreens)

local screen_plural = "screen"
if required_screens ~= 1 then screen_plural = "screens" end

system.print(("Factory has %d machines. You will need %d %s with current settings."):format(
    all_count,
    required_screens,
    screen_plural,
    screenCapacity
))

if required_screens > #screens then
    local missing = required_screens - #screens
    local missingPlural = "screen"
    if missing ~= 1 then missingPlural = "screens" end
    system.print(string.format("Connect %d more %s to display everything.", missing, missingPlural))
end

unit.setTimer("refresh",Refresh_Timer)