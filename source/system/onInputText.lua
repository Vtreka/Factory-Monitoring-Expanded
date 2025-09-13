local T=text

indy_type ={"metalwork","printer","chemical","glass","refiner","smelter","assembler", "electronics", "honey", "recycler"}

--local check=string.find(T,"/help")


if string.find(T,"help") then
 system.print("--- Industry locator ---")   
 system.print("Syntax:")
 system.print("[machine_type] [tier] [number]")
 system.print("ex: assembler t1 1")
 system.print("possible machine types: metalwork, printer, chemical, glass, refiner, honey, smelter, electronics, assembler, recycler")
 system.print("to clear an arrow type: clear [index]")
 system.print("ex: clear 18")
 system.print("")
 system.print("For assistance contact Vtreka in game or on discord")    
 end
if string.find(T,"clear") then
    str = string.gsub(T, "clear" ,"")
 core_unit[1].deleteSticker(tonumber(str))
 end

if string.find(T, indy_type[1]) then
   str = string.gsub(T, indy_type[1],"")
   
       if string.find(str, "t1") then 
          str = string.gsub(str, "t1","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(metalwork1[iid])
          --core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down")
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t2") then 
          str = string.gsub(str, "t2","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(metalwork2[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t3") then 
          str = string.gsub(str, "t3","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(metalwork3[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t4") then 
          str = string.gsub(str, "t4","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(metalwork4[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
    
elseif string.find(T, indy_type[2]) then
   str = string.gsub(T, indy_type[2],"")
   
       if string.find(str, "t1") then 
          str = string.gsub(str, "t1","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(printer1[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t2") then 
          str = string.gsub(str, "t2","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(printer2[id])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t3") then 
          str = string.gsub(str, "t3","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(printer3[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t4") then 
          str = string.gsub(str, "t4","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(printer4[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
elseif string.find(T, indy_type[3]) then
   str = string.gsub(T, indy_type[3],"")
   
       if string.find(str, "t1") then 
          str = string.gsub(str, "t1","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(chemical1[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+6,"down"))
          end
        if string.find(str, "t2") then 
          str = string.gsub(str, "t2","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(chemical2[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+6,"down"))
          end
        if string.find(str, "t3") then 
          str = string.gsub(str, "t3","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(chemical3[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+6,"down"))
          end
        if string.find(str, "t4") then 
          str = string.gsub(str, "t4","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(chemical4[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+6,"down"))
          end
elseif string.find(T, indy_type[4]) then
   str = string.gsub(T, indy_type[4],"")
   
       if string.find(str, "t1") then 
          str = string.gsub(str, "t1","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(glass1[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+6,"down"))
          end
        if string.find(str, "t2") then 
          str = string.gsub(str, "t2","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(glass2[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+6,"down"))
          end
        if string.find(str, "t3") then 
          str = string.gsub(str, "t3","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(glass3[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+6,"down"))
          end
        if string.find(str, "t4") then 
          str = string.gsub(str, "t4","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(glass4[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+6,"down"))
          end     
elseif string.find(T, indy_type[5]) then
   str = string.gsub(T, indy_type[5],"")
   
       if string.find(str, "t1") then 
          str = string.gsub(str, "t1","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(refiner1[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t2") then 
          str = string.gsub(str, "t2","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(refiner2[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t3") then 
          str = string.gsub(str, "t3","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(refiner3[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t4") then 
          str = string.gsub(str, "t4","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(refiner4[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
elseif string.find(T, indy_type[6]) then
   str = string.gsub(T, indy_type[6],"")
   
       if string.find(str, "t1") then 
          str = string.gsub(str, "t1","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(smelter1[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t2") then 
          str = string.gsub(str, "t2","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(smelter2[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t3") then 
          str = string.gsub(str, "t3","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(smelter3[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t4") then 
          str = string.gsub(str, "t4","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(smelter4[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
elseif string.find(T, indy_type[7]) then
   str = string.gsub(T, indy_type[7],"")
   
       if string.find(str, "t1") then 
          str = string.gsub(str, "t1","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(assembly1[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t2") then 
          str = string.gsub(str, "t2","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(assembly2[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t3") then 
          str = string.gsub(str, "t3","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(assembly3[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t4") then 
          str = string.gsub(str, "t4","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(assembly4[iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
elseif string.find(T, indy_type[8]) then
   str = string.gsub(T, indy_type[8],"")
   
       if string.find(str, "t1") then 
          str = string.gsub(str, "t1","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(electronics[1][iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t2") then 
          str = string.gsub(str, "t2","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(electronics[2][iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t3") then 
          str = string.gsub(str, "t3","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(electronics[3][iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t4") then 
          str = string.gsub(str, "t4","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(electronics[4][iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end    
    elseif string.find(T, indy_type[9]) then
   str = string.gsub(T, indy_type[9],"")
   
       if string.find(str, "t1") then 
          str = string.gsub(str, "t1","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(recycler[1][iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t2") then 
          str = string.gsub(str, "t2","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(recycler[2][iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t3") then 
          str = string.gsub(str, "t3","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(recycler[3][iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end
        if string.find(str, "t4") then 
          str = string.gsub(str, "t4","")
          iid = tonumber(str)
          c_pos = core_unit[1].getElementPositionById(recycler[4][iid])
          system.print("Arrow added. Index : " .. core_unit[1].spawnArrowSticker(c_pos[1],c_pos[2],c_pos[3]+4,"down"))
          end    
end