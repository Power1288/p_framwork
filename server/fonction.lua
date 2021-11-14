---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by ll.
--- DateTime: 11/11/2021 19:29
---

pfw = {}


pfw.getItem = function()
    return Item
end

pfw.getJob = function()
    return jobs
end

pfw.getGang = function()
    return Gangs
end

pfw.isAdmin = function(id,cb)
    local admin = false
    exports.mongodb:findOne({ collection="users", query = { identifier = GetPlayerIdentifier(id) } }, function (success, result)
        if not success then
            print('^3[ERROR] erreur de recherche')
            return
        end
        if result[1] then
            admin = result[1].isAdmin
        end
        cb(admin)
    end)
end

pfw.setAdmin = function(id)
    exports.mongodb:findOne({ collection="users", query = { identifier = GetPlayerIdentifier(id) } }, function (success, result)
        if not success then
            print('^3[ERROR] erreur de recherche')
            return
        end
        if result[1] then
            if result[1].isAdmin then
                TriggerClientEvent("pf:showNotificattion",id,"Le joueur fait deja partie du staff")
            else
                exports.mongodb:updateOne({ collection="users", query = { identifier = GetPlayerIdentifier(id) }, update = { ["$set"] = { isAdmin = true } } })
            end
        end
    end)
end

pfw.removaAdmin = function(id)
    exports.mongodb:findOne({ collection="users", query = { identifier = GetPlayerIdentifier(id) } }, function (success, result)
        if not success then
            print('^3[ERROR] erreur de recherche')
            return
        end
        if result[1] then
            if result[1].isAdmin then
                exports.mongodb:updateOne({ collection="users", query = { identifier = GetPlayerIdentifier(id) }, update = { ["$set"] = { isAdmin = false } } })
                TriggerClientEvent("pf:showNotificattion",id,"Le joueur a été retirer du staff")
            else
                TriggerClientEvent("pf:showNotificattion",id,"Le joueur n'es pas staff")
            end
        end
    end)
end





