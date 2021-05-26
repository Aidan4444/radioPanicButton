function checkRadioChannels(frequency)
    for _, radioChannel in pairs(config.radioChannels) do
        if radioChannel == frequency then 
            return true 
        end 
    end 
    
    return false
end 

function checkBroadcastChannels(frequency)
    for _, broadcastChannel in pairs(config.broadcastChannels) do
        if broadcastChannel == frequency then 
            return true 
        else 
            return false
        end 
    end 
end 

function panicButton()
    panicButtonAudio()
    panicButtonBlip()
    panicButtonNotify()
end 

function panicButtonAudio() 
    
    if config.playPanicButtonAudio then 
        TriggerServerEvent('radioPanicButton:server:panicButtonAudio', 'panicButton', 0.8)
        Wait(4600)
    end 

    if config.playDispatchAudio then 
        TriggerServerEvent('radioPanicButton:server:panicButtonAudio', 'DISPATCH_INTRO_01', 0.8)
        Wait(900)
        TriggerServerEvent('radioPanicButton:server:panicButtonAudio', 'WE_HAVE_01', 0.8)
        Wait(700)
        TriggerServerEvent('radioPanicButton:server:panicButtonAudio', 'CRIME_OFFICER_IN_NEED_OF_ASSISTANCE_03', 0.8)
        Wait(1300)
        TriggerServerEvent('radioPanicButton:server:panicButtonAudio', 'OUTRO_02', 0.8)
    end 
end 

function panicButtonBlip()
    if config.showBlip then 
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local street1, street2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
        local streetName = GetStreetNameFromHashKey(street1)
        local officerName = GetPlayerName(PlayerId())
        local officerId = GetPlayerServerId(PlayerId())
        TriggerServerEvent('radioPanicButton:server:sendBlip', coords, streetName, officerName, officerId)
    end 
end

function panicButtonNotify()
    if config.showNotification then 
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local street1, street2 = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
        local streetName = GetStreetNameFromHashKey(street1)
        local officerName = GetPlayerName(PlayerId())
        TriggerServerEvent('radioPanicButton:server:panicNotify', streetName, officerName)
    end 
end

function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(true, true)
end
