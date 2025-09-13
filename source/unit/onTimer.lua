local posy = 10
local t_posy = 10
c=1

column = {10, 266, 522, 778}

f_state = function(fid, F)
    state = core_unit[1].getElementIndustryInfoById(fid)["state"]
    local function fmt(name, label)
        if State_as_Prefix then
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
    if State_as_Prefix then
        return label .. " " .. elementName
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

setNextFillColourByState = function(fid)
    state = core_unit[1].getElementIndustryInfoById(fid)["state"]
    if state == 1 then return "setNextFillColor(layer,1,1,0,1)"
        elseif state == 2 then return "setNextFillColor(layer,0,1,0,1)"
        elseif state == 3 then return "setNextFillColor(layer,1,0,0.8,1)"
        elseif state == 4 then return "setNextFillColor(layer,1,0.5,0,1)"
        elseif state == 5 then return "setNextFillColor(layer,1,0,0,1)"
        elseif state == 6 then return "setNextFillColor(layer,0,0.5,1,1)"
        elseif state == 7 then return "setNextFillColor(layer,1,0,0,1)"
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

indy_column = function(indy, tier, posx, posy)
    if indy[0] == 0 then 
        return "" 
    else    
        stxt = ""
        if tier <= 1 then t_color = "setDefaultFillColor(layer, Shape_Text, ".. tier1colour ..", 1)\n" end
        if tier == 2 then t_color = "setDefaultFillColor(layer, Shape_Text, ".. tier2colour ..", 1)\n" end
        if tier == 3 then t_color = "setDefaultFillColor(layer, Shape_Text, ".. tier3colour ..", 1)\n" end
        if tier == 4 then t_color = "setDefaultFillColor(layer, Shape_Text, ".. tier4colour ..", .5)\n" end
        if tier >= 5 then t_color = "setDefaultFillColor(layer, Shape_Text, ".. tier5colour ..", 1)\n" end
        
        if Show_Indy_name then
            --create table of machines
            local machines = {}
            for index,id in ipairs(indy) do
                if (not SortByItemTier) or (getItemTier(id) == tier) then
                    local machine = {
                        mid = id,
                        name = string.gsub(core_unit[1].getElementNameById(id), "Craft ", ""),
                        state = core_unit[1].getElementIndustryInfoById(id)["state"]
                    }
                    table.insert(machines, machine)
                end
            end

            --Sort table by state or name
            table.sort(machines, function(a,b)
                if SortByState and a.state ~= b.state then
                    return a.state < b.state
                end
                return a.name < b.name
            end)
                
            --create table of columns
            for index,machine in ipairs(machines) do
                local id = machine.mid
                if index<10 then 
                    num= "00" .. tostring(index) 
                elseif index<100 then 
                    num= "0" .. tostring(index) 
                else 
                    num = tostring(index) 
                end
                
                --Move to next column if position is greater than border
                if posy >= border then 
                    posy=20 c=c+1 
                end       
            
                --Add text to table
                stxt = stxt .."addText(layer, font3, \"" .. num.."\", ".. column[c] .. "," .. posy ..")\n" .. setNextFillColourByState(id) .. "addText(layer, font3,\"" .. f_stateWithElementName(id).. "\" , " .. column[c] + 20 .. "," .. posy .. ")\n"
            
                posy = posy +10
            end

            t_posy = posy
            return t_color .. stxt .. " c=" .. c .. "\n"
        else
            --create table of Industry
            local industryUnits = {}
            for _,id in ipairs(indy) do
                local industryInfo = core_unit[1].getElementIndustryInfoById(id)["currentProducts"]
                if industryInfo and #industryInfo >= 1 then
                    local itemInfo = system.getItem(industryInfo[1]["id"])
                    if itemInfo and ((not SortByItemTier) or itemInfo["tier"] == tier) then
                        local tempName = itemInfo["displayNameWithSize"]
                        local name = getName(tempName)
                        table.insert(industryUnits, {
                            mid = id,
                            name = string.lower(name),
                            state = core_unit[1].getElementIndustryInfoById(id)["state"]
                        })
                    end
                end
            end

            --Sort table by state or name
            table.sort(industryUnits, function(a,b)
                if SortByState and a.state ~= b.state then
                    return a.state < b.state
                end
                return a.name < b.name
            end)

            --create table of columns
            for index,industryUnit in ipairs(industryUnits) do
                local id = industryUnit.mid
                if index < 10 then
                    num = "00" .. tostring(index)
                elseif index < 100 then
                    num = "0" .. tostring(index)
                else
                    num = tostring(index)
                end
            
            --Move to next column if position is greater than border
            if posy >= border then
                posy = 20 c=c+1
            end

            --Add text to table
            stxt = stxt .."addText(layer, font3, \"" .. num.."\", ".. column[c] .. "," .. posy ..")\n" .. setNextFillColourByState(id) .. "addText(layer, font3,\"" .. f_state(id,0).. "\" , " .. column[c] + 20 .. "," .. posy .. ")\n"
       
            posy = posy + 10
        end

        t_posy = posy
        return t_color .. stxt .. " c=" .. c .. "\n"
        end
    end
end

local function mergeTables(...)
    local result = {}
    for _,t in ipairs({...}) do
        for _,v in ipairs(t) do table.insert(result, v) end
    end
    return result
end

renderIndustry = function(allList, t1, t2, t3, t4)
    if SortByItemTier then
        return indy_column(allList,1,column[c],t_posy+40) ..
               indy_column(allList,2,column[c],t_posy) ..
               indy_column(allList,3,column[c],t_posy) ..
               indy_column(allList,4,column[c],t_posy) ..
               indy_column(allList,5,column[c],t_posy)
    else
        return indy_column(t1,1,column[c],t_posy+40) ..
               indy_column(t2,2,column[c],t_posy) ..
               indy_column(t3,3,column[c],t_posy) ..
               indy_column(t4,4,column[c],t_posy)
    end
end

local electronicsAllList, printerAllList, chemicalAllList, glassAllList
local refinerAllList, smelterAllList, honeyAllList, recyclerAllList
local assemblyAllList, metalworkAllList

if SortByItemTier then
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

screen_one = [[
local layer = createLayer()
local rx, ry = getResolution()

local font = loadFont("Oxanium", 12)
local font3 = loadFont("RobotoCondensed", 11)

local column = {10, 266, 522, 778}

setDefaultFillColor(layer, Shape_Text, 0,0,1,1)
setDefaultStrokeColor(layer, Shape_Line, 0,.3,2,1)
setDefaultStrokeColor(layer, Shape_BoxRounded, 0,.3,2,1)

setNextFillColor(layer, 0,0,0,0)
setNextStrokeWidth(layer, 1)
addBoxRounded(layer, 0, 0, rx, ry, 10)

local div = rx/4
local posy = 10

local header = function(tag, y, p, n)
    setNextFillColor(layer, 0,0,1,0.2)
    setNextStrokeWidth(layer, .1)
    addBoxRounded(layer, p, y, div - 20, 20, 4)
    setNextTextAlign(layer, AlignH_Center, AlignV_Middle)
    setNextFillColor(layer, 1,1,1,1)
    addText(layer, font, "(" .. n .. ") " .. tag, div/2+(p)-10, y+11)    
end

for x = 1,5 do addLine (layer, div*x, 0, div*x, ry) end

local c = 1

header("Electronics Industry", ]].. t_posy ..[[, column[c], ]]..electronics_all..[[)
]] .. renderIndustry(electronicsAllList, electronics1, electronics2, electronics3, electronics4) .. [[

header("3D Printers", ]].. t_posy ..[[, column[c], ]]..printer_all..[[)
]] .. renderIndustry(printerAllList, printer1, printer2, printer3, printer4) .. [[

header("Chemical Industry", ]].. t_posy ..[[, column[c], ]]..chemical_all..[[)
]] .. renderIndustry(chemicalAllList, chemical1, chemical2, chemical3, chemical4) .. [[

header("Glass Industry", ]].. t_posy ..[[, column[c], ]]..glass_all..[[)
]] .. renderIndustry(glassAllList, glass1, glass2, glass3, glass4) .. [[
]]

posy = 10
t_posy = 10
c=1

screen_two = [[
local layer = createLayer()
local rx, ry = getResolution()

local font = loadFont("Oxanium", 12)
local font3 = loadFont("RobotoCondensed", 11)

local column = {10, 266, 522, 778}

setDefaultFillColor(layer, Shape_Text, 0,0,1,1)
setDefaultStrokeColor(layer, Shape_Line, 0,.3,2,1)
setDefaultStrokeColor(layer, Shape_BoxRounded, 0,.3,2,1)

setNextFillColor(layer, 0,0,0,0)
setNextStrokeWidth(layer, 1)
addBoxRounded(layer, 0, 0, rx, ry, 10)

local div = rx/4
local posy = 10

local header = function(tag, y, p, n)
    setNextFillColor(layer, 0,0,1,0.2)
    setNextStrokeWidth(layer, .1)
    addBoxRounded(layer, p, y, div - 20, 20, 4)
    setNextTextAlign(layer, AlignH_Center, AlignV_Middle)
    setNextFillColor(layer, 1,1,1,1)
    addText(layer, font, "(" .. n .. ") " .. tag, div/2+(p)-10, y+11)    
end

for x = 1,5 do addLine (layer, div*x, 0, div*x, ry) end

local c = 1

header("Refiners", ]].. t_posy ..[[, column[c], ]]..refiner_all..[[)
]] .. renderIndustry(refinerAllList, refiner1, refiner2, refiner3, refiner4) .. [[

header("Smelters", ]].. t_posy ..[[, column[c], ]]..smelter_all..[[)
]] .. renderIndustry(smelterAllList, smelter1, smelter2, smelter3, smelter4) .. [[

header("Honeycomb", ]].. t_posy ..[[, column[c], ]]..honey_all..[[)
]] .. renderIndustry(honeyAllList, honey1, honey2, honey3, honey4) .. [[

header("Recyclers", ]].. t_posy ..[[, column[c], ]]..recycler_all..[[)
]] .. renderIndustry(recyclerAllList, recycler1, recycler2, recycler3, recycler4) .. [[
]]

posy = 10
t_posy = 10
c=1
column = {10, 266, 522, 778}

screen_three = [[
local layer = createLayer()
local rx, ry = getResolution()

local font = loadFont("Oxanium", 12)
local font3 = loadFont("RobotoCondensed", 11)

column = {10, 266, 522, 778}

setDefaultFillColor(layer, Shape_Text, 0,0,1,1)
setDefaultStrokeColor(layer, Shape_Line, 0,.3,2,1)
setDefaultStrokeColor(layer, Shape_BoxRounded, 0,.3,2,1)

setNextFillColor(layer, 0,0,0,0)
setNextStrokeWidth(layer, 1)
addBoxRounded(layer, 0, 0, rx, ry, 10)

local div = rx/4
local posy = 10

local header = function(tag, y, p, n)
    setNextFillColor(layer, 0,0,1,0.2)
    setNextStrokeWidth(layer, .1)
    addBoxRounded(layer, p, y, div - 20, 20, 4)
    setNextTextAlign(layer, AlignH_Center, AlignV_Middle)
    setNextFillColor(layer, 1,1,1,1)
    addText(layer, font, "(" .. n .. ") " .. tag, div/2+(p)-10, y+11)    
end

for x = 1,5 do addLine (layer, div*x, 0, div*x, ry) end

local c = 1

header("Assembly Lines", ]].. t_posy ..[[, column[c], ]]..assembly_all..[[)
]] .. renderIndustry(assemblyAllList, assembly1, assembly2, assembly3, assembly4) .. [[

]]

posy = 10
t_posy = 10
c=1
column = {10, 266, 522, 778}

screen_four = [[
local layer = createLayer()
local rx, ry = getResolution()

local font = loadFont("Oxanium", 12)
local font3 = loadFont("RobotoCondensed", 11)

column = {10, 266, 522, 778}

setDefaultFillColor(layer, Shape_Text, 0,0,1,1)
setDefaultStrokeColor(layer, Shape_Line, 0,.3,2,1)
setDefaultStrokeColor(layer, Shape_BoxRounded, 0,.3,2,1)

setNextFillColor(layer, 0,0,0,0)
setNextStrokeWidth(layer, 1)
addBoxRounded(layer, 0, 0, rx, ry, 10)

local div = rx/4
local posy = 10

local header = function(tag, y, p, n)
    setNextFillColor(layer, 0,0,1,0.2)
    setNextStrokeWidth(layer, .1)
    addBoxRounded(layer, p, y, div - 20, 20, 4)
    setNextTextAlign(layer, AlignH_Center, AlignV_Middle)
    setNextFillColor(layer, 1,1,1,1)
    addText(layer, font, "(" .. n .. ") " .. tag, div/2+(p)-10, y+11)
end

for x = 1,5 do addLine (layer, div*x, 0, div*x, ry) end

local c = 1

header("Metalwork Industry", ]].. t_posy ..[[, column[c], ]]..metalwork_all..[[)
]] .. renderIndustry(metalworkAllList, metalwork1, metalwork2, metalwork3, metalwork4) .. [[

]]

screens[1].activate()
screens[2].activate()
screens[3].activate()
screens[4].activate()

screens[1].setRenderScript(screen_one)
screens[2].setRenderScript(screen_two)
screens[3].setRenderScript(screen_three)
screens[4].setRenderScript(screen_four)
--screens[5].setRenderScript(screen_five)