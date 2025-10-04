# Dual Universe - Factory Monitoring Expanded
Fork of BartasRS Factory Monitoring Expanded - https://github.com/BartasRS/Factory-Monitoring-Expanded
<img width="1740" height="1394" alt="image" src="https://github.com/user-attachments/assets/a5823ec7-32ab-4b75-88ba-95f682ec2ac9" />

<br>
4 Screen default version displays Electronics, 3D Printers, Chemical Industry and Glass industry on screen 1, Refiners, Smelters, Honeycomb and Recyclers on screen 2, Assembly Lines on screen 3 and Metalwork Industry on screen 4. Should be ok for most people but can be expanded up to 10 screens if required (myDU Server must be able to support more than default 9 out links). Separate JSON files for 1-3 and 10 screens are also available<br>

<br><br>
## Installation
Copy [4 screen version](https://github.com/Vtreka/Factory-Monitoring-Expanded/blob/main/PB.json) into Programming Board in game or version you wish to use <br><br>
Simply connect core and appropriate number of screens in any order (and optionally a databank) to Programing Board and run the script. Refresh rate (In Lua Parameters) is set to 5, suggest this not be lowered to avoid lag situation.<br><br>
<b>**Lua Parameters**</b><br>
Turn Screens Off on Exit - Deactivate connected screens when the Programming Board stops<br>
Show Maintain Batch - Display maintain and batch amounts for each machine <br>
Show Indy Name - Will display Industry Unit name instead of the item that is being crafted<br>
Show State - Toggle display of the machine state text<br>
Sort By Item Tier - Will sort by tier of item being crafted instead of Industry Unit tier <br>
Sort By State - Sort industry units by their state value <br>
State Sort Mode - When sorting by state, choose 'A' for alphabetical or 'V' for State value sorting <br>
Border - Bottom display line position, use to fine tune (increments of 10) if some headers are at the bottom. Maximum is 600.<br>
Refresh timer - Value in seconds, set above 3 for really big factories<br>
Brightness - Adjust brightness of all text and background <br>
Font Size - Set base font size for displayed text <br>
Background - Set background colour "r, g, b" or image URL<br>
Tier 1 Colour - Set Tier 1 Colour<br>
Tier 2 Colour - Set Tier 2 Colour<br>
Tier 3 Colour - Set Tier 3 Colour<br>
Tier 4 Colour - Set Tier 4 Colour<br>
Tier 5 Colour - Set Tier 5 Colour<br>

<br>
Script comes with industry locator. Type <i>help</i> in Lua Tab to see available commands.

<hr>
The script is made so it should be fairly easy to shuffle contents between screens or add more screens to it (up to 9) if you wish so. If you need any help with customising it reach me in game or on Discord (Vtreka).

<br>
<hr>
<b>Version 3.3 updates:</b><br>
    -Fixed script to announce how many machines you have and how many screens it will require<br>
    -Attempting script fix to auto adjust sections to the next screen if required<br>
    -Introduced limit to stop filling screen over 50kb threshold (screen will not render if it does)
<br>
<b>Version 3.2 updates:</b><br>
    -Added Brightness parameter to control text and background transparency<br>
    -Added option to turn screens off when the Programming Board stops<br>
    -Added ability to adjust Font Size in parameters <br>
    -Created JSON files for 1-4 and 10 screen variants<br>
<br>
<b>Version 3.1 updates:</b><br>
    -Added Background parameter, can set as RGB colour or a URL<br>
<br>
<b>Version 3.0 updates:</b><br>
    -Added and right Aligned Maintain/Batch values<br>
    -Added toggle to show/hide state value<br>
<br>
<b>Version 2.6 updates:</b><br>
    - Added parameter to choose alphabetical or value-based state sorting<br>
<br>
<b>Version 2.5 updates:</b><br>
    - Added displaying state of Industrial Unit as a Prefix or Suffix<br>
    - Added option to sort by state<br>
<br>
<b>Version 2.4 updates:</b><br>
    - Added option to sort by item tier instead of Industry Unit tier<br>
    - Added Tier 5 colour parameter<br>
<br>
<b>Version 2.3.1 updates:</b><br>
    - Addded sorting by name when "Show Indy name" is not enabled<br>
    - Removed additional space added to items with product in the name<br>
<br>   
<b>Version 2.3 updates:</b><br>
Enabled Show Name parameter to switch between showing Industry Unit name instead of element being crafted. <br>
<br>
Note: Naming convention is currently as follows:<br>
    - Show indy name Checked: Machine state then Industry Unit name<br>
    - Show indy name Unchecked: Element being crafted then Machine state<br>
<br>
Thanks to BlimpieBoy for contributions to code.<br>
<br>
<b>Version 2.2 updates:</b><br>
    - Can now connect Databank to save Parameters between updates (The first time you connect a Databank it will have no data saved and you should get a message in the Lua chat channel that says "No parameters saved to Databank. Restart the Programming Board"). The Parameters are saved when the Programming Board is deactivated, so do that then re-activate the Programming Board<br>
    - Combined separate onStart code into Unit:onStart
    - Added onStop event to save databank values
    - Reverted some changes in Unit:onTimer until I get my head around how to implement sorting by element name and options for different naming and orders of industry state <br>
<br>
<b>Version 2.1 updates:</b><br>
    - Adding Recyclers<br>
    - Added catch for industry units that haven't been configured yet (indy unit placed but no item select to be crafted)<br>
    - Added in the Tier colours as parameters<br>
    - Moved parameters to stop errors received when updating parameters<br>
    - Preparing for function to show Industry Unit name including Parameter checkbox<br>
