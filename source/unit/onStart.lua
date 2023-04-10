-- Script created by Bartas (ingame), BartasRS#2742 (Discord)
-- Updates provided by Vtreka (ingame), Vtreka#1337 (Discord)
-- Contributions provided by BlimpieBoy (ingame), Blimpieboy#0903 (Discord)

system.print(" --- Factory Monitor Expanded v2.3.1 ---")
system.print ("type 'help' for available commands")

--[[ LUA PARAMETERS ]]
useDatabankValues = true --export: If checked and if values were saved in databank, parmaters will be loaded from the databank, if not, following ones will be used
Show_Indy_name = false --export: Shows Industry Unit name instead of element being crafted if checked
border = 550 --export: Bottom display line<br>Maximum 600<br>Use to adjust
Refresh_timer = 5 --export: Screen(s) refresh timer in seconds
tier1colour = '1, 1, 1' --export: Set Tier 1 Colour
tier2colour = '0, 1, 0' --export: Set Tier 2 Colour
tier3colour = '0, 0, 1' --export: Set Tier 3 Colour
tier4colour = '.3, 0, .5' --export: Set Tier 4 Colour

system.print("Refresh timer set to: "..Refresh_timer.." seconds")

options = {}
options.Show_Indy_name = Show_Indy_name
options.border = border
options.tier1colour = tier1colour
options.tier2colour = tier2colour
options.tier3colour = tier3colour
options.tier4colour = tier4colour

databank = nil
screens = {}
core_unit = {}
--local json = require('dkjson')

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
    if (databank.hasKey("options")) and (useDatabankValues == true) then
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

elementIdList = core_unit[1].getElementIdList()


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

-- Assembly Lines --

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
    
    if (elementType:find("metalwork industry")) then
            if (elementType:find("basic")) then 
            table.insert(metalwork1,id)  metalwork_count[1] = metalwork_count[1] + 1        
            elseif (elementType:find("uncommon")) then 
            table.insert(metalwork2,id)  metalwork_count[2] = metalwork_count[2] + 1 
            elseif (elementType:find("advanced")) then
            table.insert(metalwork3,id) metalwork_count[3] = metalwork_count[3] + 1
            elseif (elementType:find("rare")) then
            table.insert(metalwork4,id)  metalwork_count[4] = metalwork_count[4] + 1
            end
    end
    if (elementType:find("electronics industry")) then
            if (elementType:find("basic")) then
            table.insert(electronics1,id)  electronics_count[1] = electronics_count[1] + 1
            elseif (elementType:find("uncommon")) then
            table.insert(electronics2,id)  electronics_count[2] = electronics_count[2] + 1
            elseif (elementType:find("advanced")) then
            table.insert(electronics3,id)  electronics_count[3] = electronics_count[3] + 1
            elseif (elementType:find("rare")) then 
            table.insert(electronics4,id)  electronics_count[4] = electronics_count[4] + 1
            end
    end 
    if (elementType:find("glass furnace")) then
            if (elementType:find("basic")) then  
            table.insert(glass1,id)  glass_count[1] = glass_count[1] + 1
            elseif (elementType:find("uncommon")) then 
            table.insert(glass2,id)  glass_count[2] = glass_count[2] + 1
            elseif (elementType:find("advanced")) then 
            table.insert(glass3,id)  glass_count[3] = glass_count[3] + 1
            elseif (elementType:find("rare")) then 
            table.insert(glass4,id)  glass_count[4] = glass_count[4] + 1
            end
    end 
    if (elementType:find("3d printer")) then
            if (elementType:find("basic")) then 
            table.insert(printer1,id)  printer_count[1] = printer_count[1] + 1
            elseif (elementType:find("uncommon")) then 
            table.insert(printer2,id)  printer_count[2] = printer_count[2] + 1
            elseif (elementType:find("advanced")) then 
            table.insert(printer3,id)  printer_count[3] = printer_count[3] + 1
            elseif (elementType:find("rare")) then 
            table.insert(printer4,id)  printer_count[4] = printer_count[4] + 1
            end
    end
    if (elementType:find("chemical industry")) then
            if (elementType:find("basic")) then 
            table.insert(chemical1,id)  chemical_count[1] = chemical_count[1] + 1
            elseif (elementType:find("uncommon")) then 
            table.insert(chemical2,id)  chemical_count[2] = chemical_count[2] + 1
            elseif (elementType:find("advanced")) then 
            table.insert(chemical3,id)  chemical_count[3] = chemical_count[3] + 1
            elseif (elementType:find("rare")) then 
            table.insert(chemical4,id)  chemical_count[4] = chemical_count[4] + 1
            end
    end
    if (elementType:find("refiner")) and not (elementType:find("honeycomb")) then
            if (elementType:find("basic")) then 
            table.insert(refiner1,id)  refiner_count[1] = refiner_count[1] + 1
            elseif (elementType:find("uncommon")) then 
            table.insert(refiner2,id)  refiner_count[2] = refiner_count[2] + 1
            elseif (elementType:find("advanced")) then 
            table.insert(refiner3,id)  refiner_count[3] = refiner_count[3] + 1
            elseif (elementType:find("rare")) then 
            table.insert(refiner4,id)  refiner_count[4] = refiner_count[4] + 1
            end
    end
    if (elementType:find("smelter")) then
            if (elementType:find("basic")) then 
            table.insert(smelter1,id)  smelter_count[1] = smelter_count[1] + 1
            elseif (elementType:find("uncommon")) then 
            table.insert(smelter2,id)  smelter_count[2] = smelter_count[2] + 1
            elseif (elementType:find("advanced")) then 
            table.insert(smelter3,id)  smelter_count[3] = smelter_count[3] + 1
            elseif (elementType:find("rare")) then 
            table.insert(smelter4,id)  smelter_count[4] = smelter_count[4] + 1
            end
    end
    if (elementType:find("assembly line")) then
            if (elementType:find("basic")) then 
            table.insert(assembly1,id)  assembly_count[1] = assembly_count[1] + 1
            elseif (elementType:find("uncommon")) then 
            table.insert(assembly2,id)  assembly_count[2] = assembly_count[2] + 1
            elseif (elementType:find("advanced")) then 
            table.insert(assembly3,id)  assembly_count[3] = assembly_count[3] + 1
            elseif (elementType:find("rare")) then 
            table.insert(assembly4,id)  assembly_count[4] = assembly_count[4] + 1
            end
    end
    if (elementType:find("honeycomb")) then
            if (elementType:find("basic")) then 
            table.insert(honey1,id)  honey_count[1] = honey_count[1] + 1
            elseif (elementType:find("uncommon")) then 
            table.insert(honey2,id)  honey_count[2] = honey_count[2] + 1
            elseif (elementType:find("advanced")) then 
            table.insert(honey3,id)  assembly_count[3] = honey_count[3] + 1
            elseif (elementType:find("rare")) then 
            table.insert(honey4,id)  honey_count[4] = honey_count[4] + 1
            end
    end
    if (elementType:find("recycler")) then
            if (elementType:find("basic")) then 
            table.insert(recycler1,id)  recycler_count[1] = recycler_count[1] + 1
            elseif (elementType:find("uncommon")) then 
            table.insert(recycler2,id)  recycler_count[2] = recycler_count[2] + 1
            elseif (elementType:find("advanced")) then 
            table.insert(recycler3,id)  recycler_count[3] = recycler_count[3] + 1
            elseif (elementType:find("rare")) then 
            table.insert(recycler4,id)  recycler_count[4] = recycler_count[4] + 1
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
all_count = honey_all + metalwork_all + electronics_all + glass_all + printer_all + chemical_all + refiner_all + smelter_all + assembly_all + recycler_all

if all_count > 265 then system.print("Crazy factory detected! You will need more than 1 screen!") 
    else system.print("Factory not so big, you might want to use single screen script.") end

unit.setTimer("refresh",Refresh_timer)