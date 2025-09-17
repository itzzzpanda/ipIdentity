local topC
local coordsSpawn = vector4(-75.35, -803.35, 243.39, 252.28)

local function CamAnim(coords)
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, true)
    local x, y, z = coords.x, coords.y, coords.z
    local suc, nz = GetGroundZAndNormalFor_3dCoord(x, y, z, false)
    if suc == 1 then z = nz else z = z - 1.0 end
    SetEntityCoords(ped, x, y, z, false, false, false, true)
    
    RequestAnimDict("amb@world_human_clipboard@male@idle_a")
    while not HasAnimDictLoaded("amb@world_human_clipboard@male@idle_a") do
        Wait(0)
    end
    
    local newspaperHash = GetHashKey("prop_cliff_paper")
    RequestModel(newspaperHash)
    while not HasModelLoaded(newspaperHash) do
        Wait(0)
    end
    
    local newspaperProp = CreateObject(newspaperHash, x, y, z, true, true, true)
    AttachEntityToEntity(newspaperProp, ped, GetPedBoneIndex(ped, 60309), 
        0.0970, -0.0280, -0.0170, 107.4008, 3.2712, -10.5080, true, true, false, true, 1, true)
    TaskPlayAnim(ped, "amb@world_human_clipboard@male@idle_a", "idle_a", 8.0, -8.0, -1, 1, 0, false, false, false)
    DoScreenFadeIn(1000)
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(cam, x, y, z + 1200.0)
    SetCamRot(cam, -90.0, 0.0, 0.0, 2)
    SetCamActiveWithInterp(cam, topC, 2000, 1, 1)
    DestroyCam(topC, false)
    ShakeCam(cam, "SWITCH_HAND_SHAKE", 1.2)
    Wait(3000)
    SetCamCoord(cam, x, y, z + 600.0)
    SetCamRot(cam, -90.0, 0.0, 0.0, 2)
    ShakeCam(cam, "SWITCH_HAND_SHAKE", 1.2)
    PlaySoundFrontend(-1, "Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true)
    Wait(2000)
    SetCamCoord(cam, x, y, z + 150.0)
    SetCamRot(cam, -90.0, 0.0, 0.0, 2)
    ShakeCam(cam, "SWITCH_HAND_SHAKE", 1.2)
    PlaySoundFrontend(-1, "Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true)
    Wait(2000)
    SetCamCoord(cam, x, y, z + 50.0)
    SetCamRot(cam, -90.0, 0.0, 0.0, 2)
    ShakeCam(cam, "SWITCH_HAND_SHAKE", 1.2)
    PlaySoundFrontend(-1, "Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true)
    Wait(2000)
    SetCamCoord(cam, x, y, z + 10.0)
    SetCamRot(cam, -90.0, 0.0, 0.0, 2)
    ShakeCam(cam, "SWITCH_HAND_SHAKE", 1.2)
    PlaySoundFrontend(-1, "Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true)
    Wait(2000)
    ClearTimecycleModifier()
    PlaySoundFrontend(-1, "Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true)
    local spinTime = 6000
    local start = GetGameTimer()
    while GetGameTimer() - start < spinTime do
        local progress = (GetGameTimer() - start) / spinTime
        local angle = progress * 2.0 * math.pi
        local radius = 2.0
        local camX = x + math.cos(angle) * radius
        local camY = y + math.sin(angle) * radius
        local camZ = z + 1.5
        SetCamCoord(cam, camX, camY, camZ)
        PointCamAtCoord(cam, x, y, z + 1.0)
        Wait(0)
    end
    DoScreenFadeOut(800)
    Wait(800)
    
    ClearPedTasksImmediately(ped)
    if DoesEntityExist(newspaperProp) then
        DeleteObject(newspaperProp)
    end
    
    RenderScriptCams(false, true, 1200, true, true)
    DestroyCam(cam, false)
    StopCamShaking(cam, true)
    Wait(200)
    DoScreenFadeIn(800)
    FreezeEntityPosition(ped, false)
end

local function CamAnimNew(coords, gender)
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, true)
    local x, y, z = coords.x, coords.y, coords.z
    local suc, nz = GetGroundZAndNormalFor_3dCoord(x, y, z, false)
    repeat
        suc, nz = GetGroundZAndNormalFor_3dCoord(x, y, z, false)
    until nz ~= 0.0
    if suc == 1 then z = nz end
    SetEntityCoords(ped, x, y, z, false, false, false, true)

    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(cam, x, y, z + 1200.0)
    SetCamRot(cam, -90.0, 0.0, 0.0, 2)
    SetCamActiveWithInterp(cam, topC, 2000, 1, 1)
    DestroyCam(topC, false)
    ShakeCam(cam, "SWITCH_HAND_SHAKE", 1.2)
    Wait(3000)
    SetCamCoord(cam, x, y, z + 600.0)
    SetCamRot(cam, -90.0, 0.0, 0.0, 2)
    ShakeCam(cam, "SWITCH_HAND_SHAKE", 1.2)
    PlaySoundFrontend(-1, "Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true)
    Wait(2000)
    SetCamCoord(cam, x, y, z + 150.0)
    SetCamRot(cam, -90.0, 0.0, 0.0, 2)
    ShakeCam(cam, "SWITCH_HAND_SHAKE", 1.2)
    PlaySoundFrontend(-1, "Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true)
    Wait(2000)
    ClearTimecycleModifier()
    PlaySoundFrontend(-1, "Hit_In", "PLAYER_SWITCH_CUSTOM_SOUNDSET", true)
    RenderScriptCams(false, true, 1200, true, true)
    DestroyCam(cam, false)
    StopCamShaking(cam, true)
    Wait(200)
    FreezeEntityPosition(ped, false)
    TriggerEvent('vms_charcreator:openCreator', gender)
end

function SessionStarted()
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()
    SetEntityCoords(PlayerPedId(), coordsSpawn.x, coordsSpawn.y, coordsSpawn.z, false, false, false, true)
    DoScreenFadeOut(1000)
    local topCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    topC = topCam
    SetCamCoord(topCam, 0.0, 0.0, 1200.0)
    SetCamRot(topCam, -90.0, 0.0, 0.0, 2)
    SetCamActive(topCam, true)
    ShakeCam(topCam, "SWITCH_HAND_SHAKE", 1.2)
    SetTimecycleModifier("player_transition")
    SetTimecycleModifierStrength(1.0)
    RenderScriptCams(true, true, 1000, true, true)
    DoScreenFadeIn(1000)
    
    local user = lib.callback.await('ipIdentity:GetUser', false)
    if user then
        lib.callback('ipIdentity:GetClothing', false, function(model, skinData)
            local pedModel = tonumber(model) or GetHashKey(model)
            RequestModel(pedModel)
            while not HasModelLoaded(pedModel) do Wait(0) end
            SetPlayerModel(PlayerId(), pedModel)
            SetModelAsNoLongerNeeded(pedModel)
            exports['illenium-appearance']:setPedAppearance(PlayerPedId(), skinData)
        end, user.citizenid)
        TriggerServerEvent('ipIdentity:PlayerLoaded', user.citizenid)
        Wait(8000)
        CamAnim(user.position)
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
    else
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "SHOW_UI",
        })
    end
end

-- Main Thread

CreateThread(function()
    while true do
        Wait(0)
        if NetworkIsSessionStarted() then
            SessionStarted()
            return
        end
    end
end)

RegisterNUICallback('REGISTER_IDENTITY', function(data, cb)
    SetNuiFocus(false, false)
    local success = lib.callback.await('ipIdentity:NewCharacter', false, data)
    if success then
        CamAnimNew(coordsSpawn, data.gender)
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
    else
        print('Failed to create character')
    end
    cb('ok')
end)