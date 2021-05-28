leoAcePerm = false 

RegisterKeyMapping('+radioPanicButton', 'Panic Button On Radio', 'keyboard', config.panicButtonKey)
RegisterCommand('+radioPanicButton', function()
    if exports['rp-radio']:IsRadioOn() then 
        if config.usePmaVoice then 
            local currentFrequency = exports['pma-voice']:GetPlayerRadioChannel(GetPlayerServerId(PlayerId()))
            if checkRadioChannels(currentFrequency) then 
                if config.haveRadioOpen then 
                    if exports['rp-radio']:IsRadioOpen() then 
                        panicButton()
                    end 
                else 
                    panicButton()
                end 
            end 
        else
            local currentFrequency = exports['mumble-voip']:GetPlayerRadioChannel(GetPlayerServerId(PlayerId()))
            if checkRadioChannels(currentFrequency) then 
                if config.haveRadioOpen then 
                    if exports['rp-radio']:IsRadioOpen() then 
                        panicButton()
                    end
                else 
                    panicButton()
                end
            end 
        end
    end 
end, false)

RegisterNetEvent('radioPanicButton:client:panicNotify')
AddEventHandler('radioPanicButton:client:panicNotify', function(streetName, officerName)
    Notify('~o~' .. officerName .. '~w~ has pressed their ~r~Panic Button ~w~at ~b~' .. streetName)
end)

RegisterNetEvent('radioPanicButton:client:panicBlip')
AddEventHandler('radioPanicButton:client:panicBlip', function(coords, streetName, officerName)
    if leoAcePerm then
        local panicBlip = nil
        local panicBlips = {}

        local function CreateBlip(x, y, z, name, sprite, size, colour)
            panicBlip = AddBlipForCoord(x, y, z)
            SetBlipSprite(panicBlip, sprite)
            SetBlipDisplay(panicBlip, 4)
            SetBlipScale(panicBlip, size)
            SetBlipColour(panicBlip, colour)
            SetBlipAsShortRange(panicBlip, true)
        
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(name)
            EndTextCommandSetBlipName(panicBlip)
            table.insert(panicBlips, panicBlip)
            Citizen.Wait(config.blipTimeout * 1000)
            for _, blip in pairs(panicBlips) do
                RemoveBlip(blip)
            end
        end

        CreateBlip(coords.x, coords.y, coords.z, 'Panic Button - ' .. officerName, 103, 1.2, 49)
    end
end)

TriggerServerEvent('radioPanicButton:server:checkAcePermission')
RegisterNetEvent('radioPanicButton:client:checkAcePermission')
AddEventHandler('radioPanicButton:client:checkAcePermission', function(isAllowed)
    if isAllowed then 
        leoAcePerm = true 
    else 
        leoAcePerm = false 
    end
end)

RegisterNetEvent('radioPanicButton:client:playSound')
AddEventHandler('radioPanicButton:client:playSound', function(soundFile)
    SendNUIMessage({
        transactionType = 'playSound',
        transactionFile = soundFile,
        transactionVolume = config.panicButtonVolume
    })
end)
