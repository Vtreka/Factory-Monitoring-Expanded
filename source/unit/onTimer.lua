local posy = 10
local t_posy = 10
c=1

column = {10, 266, 522, 778}

f_state = function(fid,F)
    state = core_unit[1].getElementIndustryInfoById(fid)["state"]
        if state < 1 and F == 0 then
        t = core_unit[1].getElementIndustryInfoById(fid)["currentProducts"]
        tt = string.gsub(system.getItem(t[1]["id"])["displayNameWithSize"], "Advanced","Adv.")
        tt = string.gsub(tt, "Uncommon","Unc.")
        tt = string.gsub(tt, "product","")
        return tt .. " - Error" .. state
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
        tt = string.gsub(tt, "Uncommon","Unc.")
        tt = string.gsub(tt, "product","")
        return tt .. " - Stopped"
        elseif state == 2 and F == 0 then 
        t = core_unit[1].getElementIndustryInfoById(fid)["currentProducts"]
        tt = string.gsub(system.getItem(t[1]["id"])["displayNameWithSize"], "Advanced","Adv.")
        tt = string.gsub(tt, "Uncommon","Unc.")
        tt = string.gsub(tt, "product","")
        return tt .. " - Running"
        elseif state == 3 and F == 0 then 
        t = core_unit[1].getElementIndustryInfoById(fid)["currentProducts"]
        tt = string.gsub(system.getItem(t[1]["id"])["displayNameWithSize"], "Advanced","Adv.")
        tt = string.gsub(tt, "Uncommon","Unc.")
        tt = string.gsub(tt, "product","")
        return tt .. " - Missing ingredient"
        elseif state == 4 and F == 0 then 
        t = core_unit[1].getElementIndustryInfoById(fid)["currentProducts"]
        tt = string.gsub(system.getItem(t[1]["id"])["displayNameWithSize"], "Advanced","Adv.")
        tt = string.gsub(tt, "Uncommon","Unc.")
        tt = string.gsub(tt, "product","")
        return tt .. " - Output full"
        elseif state == 5 and F == 0 then
        t = core_unit[1].getElementIndustryInfoById(fid)["currentProducts"]
        tt = string.gsub(system.getItem(t[1]["id"])["displayNameWithSize"], "Advanced","Adv.")
        tt = string.gsub(tt, "Uncommon","Unc.")
        tt = string.gsub(tt, "product","")
        return tt .. " - No output container"
        elseif state == 6 and F == 0 then 
        t = core_unit[1].getElementIndustryInfoById(fid)["currentProducts"]
        tt = string.gsub(system.getItem(t[1]["id"])["displayNameWithSize"], "Advanced","Adv.")
        tt = string.gsub(tt, "Uncommon","Unc.")
        tt = string.gsub(tt, "product","")
        return tt .. " - Pending"
        elseif state == 7 and F == 0 then
        t = core_unit[1].getElementIndustryInfoById(fid)["currentProducts"]
        tt = string.gsub(system.getItem(t[1]["id"])["displayNameWithSize"], "Advanced","Adv.")
        tt = string.gsub(tt, "Uncommon","Unc.")
        tt = string.gsub(tt, "product","")
        return tt .. " - Missing schematics"
        elseif state > 7 and F == 0 then
        t = core_unit[1].getElementIndustryInfoById(fid)["currentProducts"]
        tt = string.gsub(system.getItem(t[1]["id"])["displayNameWithSize"], "Advanced","Adv.")
        tt = string.gsub(tt, "Uncommon","Unc.")
        tt = string.gsub(tt, "product","")
        return tt .. " - Error" .. state
    end
end

f_stateWithElementName = function(fid)
    state = core_unit[1].getElementIndustryInfoById(fid)["state"]
    elementName = core_unit[1].getElementNameById(fid)
    elementName = string.gsub(elementName, "Craft ", "")
	
    if state == 1 then
		if isElementConfigured(fid) then
			return "Stopped     " .. elementName
		else
			return "Unconfig    " .. elementName
		end
	elseif state == 2 then return "Running     " .. elementName
	elseif state == 3 then return "Ingredient  " .. elementName
	elseif state == 4 then return "Output full " .. elementName
	elseif state == 5 then return "No output   " .. elementName
	elseif state == 6 then return "Pending     " .. elementName
	elseif state == 7 then return "Schematic   " .. elementName
	elseif state > 7 then return  "ERROR       " .. elementName
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
	elseif state == 2 then return "setNextFillColor(layer,0,1,0,1) "
	elseif state == 3 then return "setNextFillColor(layer,1,0,0.8,1) "
	elseif state == 4 then return "setNextFillColor(layer,1,0.5,0,1) "
	elseif state == 5 then return "setNextFillColor(layer,1,0,0,1) "
	elseif state == 6 then return "setNextFillColor(layer,0,0.5,1,1) "
	elseif state == 7 then return "setNextFillColor(layer,1,0,0,1) "
	else return ""
    end
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
        
        for index,id in ipairs(indy) do
            if index<10 then 
                num= "00" .. tostring(index) 
            elseif index<100 then 
                num= "0" .. tostring(index) 
            else 
                num = tostring(index) 
            end
            
            if posy >= border then 
                posy=20 c=c+1 
            end       
        
            if Show_Indy_name then
                stxt = stxt .."addText(layer, font3, \"" .. num.."\", ".. column[c] .. "," .. posy ..")\n" .. setNextFillColourByState(id) .. "addText(layer, font3,\"" .. f_stateWithElementName(id).. "\" , " .. column[c] + 20 .. "," .. posy .. ")\n"
        
                posy = posy +10
            else
                stxt = stxt .."addText(layer, font3, \"" .. num.."\", ".. column[c] .. "," .. posy ..")\n" .. setNextFillColourByState(id) .. "addText(layer, font3,\"" .. f_state(id,0).. "\" , " .. column[c] + 20 .. "," .. posy .. ")\n"
        
                posy = posy +10
            end
        end
            
            t_posy = posy
            return t_color .. stxt .. " c=" .. c .."\n"
        end
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

header("Metalwork Industry", ]].. t_posy ..[[, column[c], ]]..metalwork_all..[[)
]] .. indy_column(metalwork1,1,column[c],t_posy+40) .. [[
]] .. indy_column(metalwork2,2,column[c],t_posy) .. [[
]] .. indy_column(metalwork3,3,column[c],t_posy) .. [[
]] .. indy_column(metalwork4,4,column[c],t_posy) .. [[

header("Electronics Industry", ]].. t_posy ..[[, column[c], ]]..electronics_all..[[)
]] .. indy_column(electronics1,1,column[c],t_posy+40) .. [[
]] .. indy_column(electronics2,2,column[c],t_posy) .. [[
]] .. indy_column(electronics3,3,column[c],t_posy) .. [[
]] .. indy_column(electronics4,4,column[c],t_posy) .. [[


header("Glass Industry", ]].. t_posy ..[[, column[c], ]]..glass_all..[[)
]] .. indy_column(glass1,1,column[c],t_posy+40) .. [[
]] .. indy_column(glass2,2,column[c],t_posy) .. [[
]] .. indy_column(glass3,3,column[c],t_posy) .. [[
]] .. indy_column(glass4,4,column[c],t_posy) .. [[
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

header("3D Printers", ]].. t_posy ..[[, column[c], ]]..printer_all..[[)
]] .. indy_column(printer1,1,column[c],t_posy+40) .. [[
]] .. indy_column(printer2,2,column[c],t_posy) .. [[
]] .. indy_column(printer3,3,column[c],t_posy) .. [[
]] .. indy_column(printer4,4,column[c],t_posy) .. [[

header("Chemical Industry", ]].. t_posy ..[[, column[c], ]]..chemical_all..[[)
]] .. indy_column(chemical1,1,column[c],t_posy+40) .. [[
]] .. indy_column(chemical2,2,column[c],t_posy) .. [[
]] .. indy_column(chemical3,3,column[c],t_posy) .. [[
]] .. indy_column(chemical4,4,column[c],t_posy) .. [[

header("Refiners", ]].. t_posy ..[[, column[c], ]]..refiner_all..[[)
]] .. indy_column(refiner1,1,column[c],t_posy+40) .. [[
]] .. indy_column(refiner2,2,column[c],t_posy) .. [[
]] .. indy_column(refiner3,3,column[c],t_posy) .. [[
]] .. indy_column(refiner4,4,column[c],t_posy) .. [[

header("Smelters", ]].. t_posy ..[[, column[c], ]]..smelter_all..[[)
]] .. indy_column(smelter1,1,column[c],t_posy+40) .. [[
]] .. indy_column(smelter2,2,column[c],t_posy) .. [[
]] .. indy_column(smelter3,3,column[c],t_posy) .. [[
]] .. indy_column(smelter4,4,column[c],t_posy) .. [[

header("Honeycomb", ]].. t_posy ..[[, column[c], ]]..honey_all..[[)
]] .. indy_column(honey1,1,column[c],t_posy+40) .. [[
]] .. indy_column(honey2,2,column[c],t_posy) .. [[
]] .. indy_column(honey3,3,column[c],t_posy) .. [[
]] .. indy_column(honey4,4,column[c],t_posy) .. [[

header("Recyclers", ]].. t_posy ..[[, column[c], ]]..recycler_all..[[)
]] .. indy_column(recycler1,1,column[c],t_posy+40) .. [[
]] .. indy_column(recycler2,2,column[c],t_posy) .. [[
]] .. indy_column(recycler3,3,column[c],t_posy) .. [[
]] .. indy_column(recycler4,4,column[c],t_posy) .. [[
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
]] .. indy_column(assembly1,1,column[c],t_posy+40) .. [[
]] .. indy_column(assembly2,2,column[c],t_posy) .. [[
]] .. indy_column(assembly3,3,column[c],t_posy) .. [[
]] .. indy_column(assembly4,4,column[c],t_posy) .. [[

]]  

screens[1].activate()
screens[2].activate()
screens[3].activate()

screens[1].setRenderScript(screen_one)
screens[2].setRenderScript(screen_two)
screens[3].setRenderScript(screen_three)
--screens[4].setRenderScript(screen_four)
--screens[5].setRenderScript(screen_five)