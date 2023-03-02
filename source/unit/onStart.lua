--screen 1
Refresh_timer = 5 --export: Screen(s) refresh timer in seconds
system.print("Refresh timer set to: "..Refresh_timer.." seconds")

--[[ LUA PARAMETERS ]]
Show_name = false --export: shows display name if checked
border = 550 --export: Bottom display line<br>Maximum 600<br>Use to adjust
tier1colour = '1, 1, 1' --export: Set Tier 1 Colour
tier2colour = '0, 1, 0' --export: Set Tier 2 Colour
tier3colour = '0, 0, 1' --export: Set Tier 3 Colour
tier4colour = '.3, 0, .5' --export: Set Tier 4 Colour

--[[
metalworks
electronics
glass
printer
chemical
refiner
smelter
assembly
honey
recycler
]]



unit.setTimer("refresh",Refresh_timer)