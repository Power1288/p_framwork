---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by ll.
--- DateTime: 11/11/2021 19:40
---


RegisterCommand("setAdmin",function(source,args,rawCommand)
    pfw.isAdmin(source,function(admin)
        if admin then
            if args[1] then
                local id = tonumber(args[1])
                pfw.setAdmin(id)
            else
                TriggerClientEvent("pf:showNotificattion",source,"Veuiller saisir un id")
            end
        else
            TriggerClientEvent("pf:showNotificattion",source,"Vous n'êtes pas staff")
        end
    end)
end)
RegisterCommand("removeAdmin",function(source,args,rawCommand)
    pfw.isAdmin(source,function(admin)
        if admin then
            local id = tonumber(args[1])
            if id then
                pfw.removaAdmin(id)
            else
                TriggerClientEvent("pf:showNotificattion",source,"Veuiller saisir un id")
            end
        end
    end)
end)
RegisterCommand("admin",function(source,args,rawCommand)
    local staff = ""
    pfw.isAdmin(source,function(admin)
        if admin then
            staff = "Admin"
            TriggerClientEvent("pf:showNotificattion",source,("Vous êtes %s"):format(staff))
        else
            staff = "joueur"
            TriggerClientEvent("pf:showNotificattion",source,("Vous êtes %s"):format(staff))
        end
    end)
end)

RegisterCommand("car",function(source,args,rawCommand)
    pfw.isAdmin(source,function(admin)
        if admin then
            local model = args[1]
            if model then
                TriggerClientEvent("pf:spawnVehicule",source,model)
            else
                TriggerClientEvent("pf:showNotificattion",source,"Veuiller saisir un model")
            end
        else
            TriggerClientEvent("pf:showNotificattion",source,"Vous n'etes pas staff")
        end
    end)
end)

RegisterCommand("additem",function(source,args,rawCommand)
    pfw.isAdmin(source,function(admin)
        if admin then
            if not args[1] then
                TriggerClientEvent('pf:showNotificattion',source,'Veuiller saisir un id')
                return
            end

            if not args[2] then
                TriggerClientEvent('pf:showNotificattion',source,'Veuiller saisir un item')
                return
            end
            if not args[3] then
                return
            end

            pfw.addItem(tonumber(args[1]),args[2],tonumber(args[3]))
        end
    end)
end)

RegisterCommand("removeItem",function(source,args,rawCommand)
    pfw.isAdmin(source,function(admin)
        if admin then
            if not args[1] then
                TriggerClientEvent('pf:showNotificattion',source,'Veuiller saisir un id')
                return
            end

            if not args[2] then
                TriggerClientEvent('pf:showNotificattion',source,'Veuiller saisir un item')
                return
            end
            if not args[3] then
                return
            end
            pfw.removeItem(tonumber(args[1]),args[2],tonumber(args[3]))
        end
    end)
end)

RegisterCommand('giveMoney',function(source,args,rawCommand)
    pfw.isAdmin(source,function(admin)
        if not admin then
            TriggerClientEvent("pf:showNotificattion",source,"Vous n'etes pas staff")
            return
        end
        if not args[1] then
            TriggerClientEvent("pf:showNotificattion",source,"Veuiller definir un id")
            return
        end
        if not args[2] then
            TriggerClientEvent("pf:showNotificattion",source,"Veuiller definir un montant")
            return
        end
        if type(tonumber(args[1])) ~= "number" then
            TriggerClientEvent("pf:showNotificattion",source,"Veuiller definir un nombre")
            return
        end
        if type(tonumber(args[2])) ~= "number" then
            TriggerClientEvent("pf:showNotificattion",source,"Veuiller definir un nombre")
            return
        end
        pfw.addMoney(args[1],args[2])
    end)
end)

RegisterCommand('giveBank',function(source,args,rawCommand)
    pfw.isAdmin(source,function(admin)
        if not admin then
            TriggerClientEvent("pf:showNotificattion",source,"Vous n'etes pas staff")
            return
        end
        if not args[1] then
            TriggerClientEvent("pf:showNotificattion",source,"Veuiller definir un id")
            return
        end
        if not args[2] then
            TriggerClientEvent("pf:showNotificattion",source,"Veuiller definir un montant")
            return
        end
        if type(tonumber(args[1])) ~= "number" then
            TriggerClientEvent("pf:showNotificattion",source,"Veuiller definir un nombre")
            return
        end
        if type(tonumber(args[2])) ~= "number" then
            TriggerClientEvent("pf:showNotificattion",source,"Veuiller definir un nombre")
            return
        end
        pfw.addMoneyBank(args[1],args[2])
    end)
end)

RegisterCommand("setjob",function(source,args,rawCommand)
    pfw.isAdmin(source,function(admin)
        if not admin then
            TriggerClientEvent("pf:showNotificattion",source,"Vous n'etes pas staff")
            return
        end
        if not args[1] then
            TriggerClientEvent("pf:showNotificattion",source,"Vous definir un id")
            return
        end
        if type(tonumber(args[1])) ~= "number" then
            TriggerClientEvent("pf:showNotificattion",source,"Vous definir un chiffre")
            return
        end
        if not args[2] then
            TriggerClientEvent("pf:showNotificattion",source,"Vous definir un job")
            return
        end
        if not args[3] then
            TriggerClientEvent("pf:showNotificattion",source,"Vous definir un grade")
            return
        end
        if type(tonumber(args[3])) ~= "number" then
            TriggerClientEvent("pf:showNotificattion",source,"Vous definir un chiffre")
            return
        end
        local job
        local value
        local gradeFound = false
        for k,v in pairs(pfw.getJob())do
            if k == args[2] then
                job = k
                value = v
                for a,b in pairs(value.grade)do
                    if tonumber(args[3]) == a then
                        gradeFound = true
                    end
                end
            end
        end
        if job == nil then
            TriggerClientEvent("pf:showNotificattion",source,"job invalid")
            return
        end
        if not gradeFound then
            TriggerClientEvent("pf:showNotificattion",source,"grade invalide")
            return
        end
        pfw.setJob(tonumber(args[1]),args[2],tonumber(args[3]))
    end)
end)


