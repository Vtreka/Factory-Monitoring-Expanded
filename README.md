# Dual Universe - Factory Monitoring Expanded
Fork of BartasRS Factory Monitoring Expanded - https://github.com/BartasRS/Factory-Monitoring-Expanded
![image](https://user-images.githubusercontent.com/94600381/222389623-ad7aa55e-e8ce-4b87-8a8c-e2e8b5bd2b31.png)

<br>
This version displays Metalworks, Electronics and Glass industry on screen 1, 3D Printers, Chemical Industry, Refiners, Honeycombs, Smelters and Recyclers on screen 2 and, finally Assemblers on screen 3. Should be ok for most people but can be expanded up to 9 screens if required<br>
Note: The 9 screen variant of the script is based on the original and has not been updated.
<br><br>
## Installation
Copy [3 screen version](https://github.com/Vtreka/Factory-Monitoring-Expanded/blob/main/PB.json) into Programming Board in game <br><br>
Simply connect core and 3 screens in any order (and optionally a databank) to Programing Board and run the script. Refresh rate (In Lua Parameters) is set to 5, suggest this not be lowered to avoid lag situation.<br><br>
<b>Lua Parameters</b><br><br>
Refresh timer - value in seconds, set above 3 for really big factories<br>
Show name - Checkbox does nothing currently. In future will allow to display Industry Unit name instead of the item that is being crafted<br>
border - bottom display line position, use to fine tune (increments of 10) if some headers are at the bottom. Maximum is 600.<br>
tier1colour - Set Tier 1 Colour<br>
tier2colour - Set Tier 2 Colour<br>
tier3colour - Set Tier 3 Colour<br>
tier4colour - Set Tier 4 Colour<br>

<br>
Script comes with industry locator. Type <i>help</i> in Lua Tab to see available commands.

<hr>
The script is made so it should be fairly easy to shuffle contents between screens or add more screens to it (up to 9) if you wish so. If you need any help with customising it reach me in game (Vtreka) or on Discord (Vtreka#1337).

<br>
<hr>
<b>Version 2.3.1 updates:</b><br>
    - Addded sorting by name when "Show Indy name" is not enabled<br>
    - Removed additional space added to items with product in the name<br><br>
    
<b>Version 2.3 updates:</b><br>
Enabled Show Name parameter to switch between showing Industry Unit name instead of element being crafted. <br><br>

Note: Naming convention is currently as follows:<br>
    - Show indy name Checked: Machine state then Industry Unit name<br>
    - Show indy name Unchecked: Element being crafted then Machine state<br><br>

Thanks to BlimpieBoy for contributions to code.<br>
Next updates: Planning to allow for State to be set as a prefix or suffix using Parameters and adding in sorting within each tier. <br><br>

<b>Version 2.2 updates:</b><br>
    - Can now connect Databank to save Parameters between updates (The first time you connect a Databank it will have no data saved and you should get a message in the Lua chat channel that says "No parameters saved to Databank. Restart the Programming Board"). The Parameters are saved when the Programming Board is deactivated, so do that then re-activate the Programming Board<br>
    - Combined separate onStart code into Unit:onStart
    - Added onStop event to save databank values
    - Reverted some changes in Unit:onTimer until I get my head around how to implement sorting by element name and options for different naming and orders of industry state <br><br>

<b>Version 2.1 updates:</b><br>
    - Adding Recyclers<br>
    - Added catch for industry units that haven't been configured yet (indy unit placed but no item select to be crafted)<br>
    - Added in the Tier colours as parameters<br>
    - Moved parameters to stop errors received when updating parameters<br>
    - Preparing for function to show Industry Unit name including Parameter checkbox<br>
