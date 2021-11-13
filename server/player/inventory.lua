---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by ll.
--- DateTime: 12/11/2021 14:00
---



function pfw.getInventory(id,cb)
    exports.mongodb:findOne({collection="users_inventory",query = {identifier = GetPlayerIdentifier(id)}},function(succes,result)
        if not succes then
            print("^2[ERROR] Recherche de l'inventaire non succes")
            return
        end
        if not result[1] then
                local item = {}
                cb(item)
            return
        end
        cb(result[1].item)
    end)
end

function pfw.addItem(id,itemName,count)
    if not id then
        print("ERREUR ID invalid Inventaire")
        return
    end
    if not itemName then
        print("ERREUR itemName invalid Inventaire")
        return
    end
    if not count then
        print("ERREUR count invalid Inventaire")
        return
    end
    local itemInventory = {}
    local items = pfw.getItem()
    local item
    for k, v in pairs(items) do
        if v.name == itemName then
            item = v
        end
    end
    if item == nil then
        TriggerClientEvent("pf:showNotificattion",id,"Item invalide")
        return
    end
    exports.mongodb:findOne({collection ="users_inventory", query = {identifier = GetPlayerIdentifier(id)}},function(succes,result)
        if not succes then
            print("^2[ERROR] Recherche de l'inventaire non succes")
            return
        end
        if not result[1] then
            table.insert(itemInventory,{name = item.name,label = item.label , weight = item.weight, usable = item.usable ,count = count})
            exports.mongodb:insertOne({ collection="users_inventory", document = {identifier = GetPlayerIdentifier(id), item = itemInventory } }, function (success, result, insertedIds)
                if not success then
                    print("[MongoDB][Example] Error in insertOne: "..tostring(result))
                    return
                end
                print("[MongoDB][Example] Inventaire crée. New ID: "..tostring(insertedIds[1]))
            end)
            return
        end
        local itemInv = result[1].item
        for a,b in pairs(itemInv)do
            if b.name == itemName then
                print(json.encode(itemInv))
                b.count = b.count + count
                print(json.encode(itemInv))
                exports.mongodb:updateOne({ collection="users_inventory", query = { identifier = GetPlayerIdentifier(id)}, update = { ["$set"] = { item = itemInv } } })
                return
            end
        end
        for _,c in pairs(result)do
            print(json.encode(c.item))
            itemTable = c.item
        end
        table.insert(itemTable,{name = item.name,label = item.label , weight = item.weight, usable = item.usable ,count = count})
        exports.mongodb:updateOne({ collection="users_inventory", query = { identifier = GetPlayerIdentifier(id)}, update = { ["$set"] = { item = itemTable } } })
    end)
end

function pfw.removeItem(id,itemName,count)
    pfw.getInventory(id,function(inventaire)
        if not id then
            print("ERREUR ID invalid Inventaire")
            return
        end
        if not itemName then
            print("ERREUR itemName invalid Inventaire")
            return
        end
        if not count then
            print("ERREUR count invalid Inventaire")
            return
        end
        local items = pfw.getItem()
        local item
        for k, v in pairs(items) do
            if v.name == itemName then
                item = v
            end
        end
        if item == nil then
            TriggerClientEvent("pf:showNotificattion",id,"Item invalide")
            return
        end
        for k,v in pairs(inventaire)do
            if v.name == itemName then
                newCount = v.count - count
                if newCount > 0 then
                    v.count = newCount
                    exports.mongodb:updateOne({ collection="users_inventory", query = { identifier = GetPlayerIdentifier(id)}, update = { ["$set"] = { item = inventaire } } })
                else
                    inventaire[k] = nil
                    exports.mongodb:updateOne({ collection="users_inventory", query = { identifier = GetPlayerIdentifier(id)}, update = { ["$set"] = { item = inventaire } } })
                end
            end
        end
    end)
end