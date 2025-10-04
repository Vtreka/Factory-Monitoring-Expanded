if options and options.Turn_Screens_Off_on_Exit and screens then
    for _, screen in ipairs(screens) do
        if screen then
            if screen.clearScriptOutput then
                screen.clearScriptOutput() 
            end
            if screen.deactivate then
            screen.deactivate()
            end
        end
    end
end

if databank ~= nil then
    databank.setStringValue("options", json.encode(options))
    system.print("LUA Parameters saved to Databank")
end