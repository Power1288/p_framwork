---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by ll.
--- DateTime: 13/11/2021 23:36
---

RegisterNetEvent("setDefaultJob")
AddEventHandler("setDefaultJob",function()
    local source = source
    exports.mongodb:findOne({collection="users_infos",query = {identifier = GetPlayerIdentifier(source)}},function(succes,result)
        if not succes then
            print("^2[ERROR] Recherche du job non succes")
            return
        end
        if not result[1] then
            return
        end
        if result[1].job then
            return
        end
        exports.mongodb:updateOne({ collection="users_infos", query = { _id = result[1]._id }, update = { ["$set"] = { job = "unemployed", grade = 0 } } })
        print("^2[MongoDb] Job crée avec succes")
    end)
end)


setJob = function(id,jobs,grade)
    if not id then
        print("id invalid")
        return
    end
    if not jobs then
        print("jobs invalid")
        return
    end
    if not grade then
        print("grade invalide")
        return
    end
    local job
    local value
    local gradeFound = false
    local newGrade
    for k,v in pairs(pfw.getJob())do
        if k == jobs then
            job = k
            value = v
            for a,b in pairs(value.grade)do
                if grade == a then
                    gradeFound = true
                    newGrade = b
                end
            end
        end
    end
    if job == nil then
        print("job invalide2")
        return
    end
    if not gradeFound then
        print("grade invalide")
        return
    end

    exports.mongodb:findOne({collection="users_infos",query = {identifier = GetPlayerIdentifier(id)}},function(succes,result)
        if not succes then
            print("^2[ERROR] Recherche de job non succes")
            return
        end
        if not result[1] then
            return
        end

        exports.mongodb:updateOne({ collection="users_infos", query = { _id = result[1]._id }, update = { ["$set"] = { job = job, grade = newGrade } } })
        print("^2[MongoDb] Job crée avec succes")
    end)
end


