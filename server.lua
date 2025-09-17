local Core = exports.apCore:GetCoreObject()
local logger = require '@apCore.modules.logger'

RegisterNetEvent('ipIdentity:PlayerLoaded', function(citizenid)
    local src = source
    if Core.Player.Login(src, citizenid) then
        print('Player ' .. src .. ' has loaded in with citizenid: ' .. citizenid)
    end
end)
lib.callback.register('ipIdentity:NewCharacter', function(source, data)
    local newData = {}
    newData.cid = 1
    newData.charinfo = data
    local src = source
    if Core.Player.Login(src, false, newData) then
        return true
    end
end)

lib.callback.register('ipIdentity:GetUser', function(source, license)
    local license = license or GetPlayerIdentifierByType(source, 'license')
    local user = MySQL.query.await('SELECT * FROM players WHERE license = ?', { license })
    if user and user[1] then
        user[1].position = json.decode(user[1].position)
        return user[1]
    end
    return nil  
end)

lib.callback.register('ipIdentity:GetClothing', function(source, citizenid)
    local result = MySQL.query.await('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', {citizenid, 1})
    if result and result[1] then
        return result[1].model, json.decode(result[1].skin)
    end
    return nil
end)