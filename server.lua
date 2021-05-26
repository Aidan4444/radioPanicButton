RegisterServerEvent('radioPanicButton:server:checkAcePermission')
AddEventHandler('radioPanicButton:server:checkAcePermission', function()
    if IsPlayerAceAllowed(source, config.acePermissionName) then
        TriggerClientEvent('radioPanicButton:client:checkAcePermission', source, true)
    else 
        TriggerClientEvent('radioPanicButton:client:checkAcePermission', source, false)
    end
end)

RegisterServerEvent('radioPanicButton:server:sendBlip')
AddEventHandler('radioPanicButton:server:sendBlip', function(coords, streetName, officerName, officerId)
    local playerName = officerName
    for _, playerId in ipairs(GetPlayers()) do 
        if IsPlayerAceAllowed(playerId, config.acePermissionName) then 
            if config.blipsInBroadcastChannels then 
                for _, broadcastChannel in pairs(config.broadcastChannels) do
                    local playersInBroadcastChannels = exports['mumble-voip']:GetPlayersInRadioChannels(broadcastChannel)
                    for _, player in pairs(playersInBroadcastChannels) do 
                        for id, _ in pairs(player) do 
                            if tostring(playerId) == tostring(id) then 
                                TriggerClientEvent('radioPanicButton:client:panicBlip', playerId, coords, streetName, playerName)
                            end 
                        end 
                    end 
                end 
            else 
                TriggerClientEvent('radioPanicButton:client:panicBlip', playerId, coords, streetName, playerName)
            end
        end 
    end 

    local checkConfigName = GetPlayerName(officerId)
    if config.useDiscordNameForLog then checkConfigName = GetDiscordUserTag(officerId) end 

	local embed = {
		{
			["color"] = 0x5996ff,
			["fields"] = {
				{
					["name"] = "**Officer:**",
					["value"] = checkConfigName,
					["inline"] = true,
				},{
					["name"] = "**Street Name:**",
					["value"] = streetName,
					["inline"] = false
				},
			},
		}
	}

    if config.logToDiscord then 
        PerformHttpRequest(config.discordWebhookUrl, 
        function(err, text, header) end, 
        'POST',
        json.encode({username = 'Panic Button', embeds = embed}), {["Content-Type"] = 'application/json'})
    end
end)

RegisterServerEvent('radioPanicButton:server:panicNotify')
AddEventHandler('radioPanicButton:server:panicNotify', function(streetName, officerName)
    local playerName = officerName
    for _, playerId in ipairs(GetPlayers()) do 
        if IsPlayerAceAllowed(playerId, config.acePermissionName) then 
            if config.blipsInBroadcastChannels then 
                for _, broadcastChannel in pairs(config.broadcastChannels) do
                    local playersInBroadcastChannels = exports['mumble-voip']:GetPlayersInRadioChannels(broadcastChannel)
                    for _, player in pairs(playersInBroadcastChannels) do 
                        for id, _ in pairs(player) do 
                            if tostring(playerId) == tostring(id) then 
                                TriggerClientEvent('radioPanicButton:client:panicBlip', playerId, coords, streetName, playerName)
                            end 
                        end 
                    end 
                end 
            else 
                TriggerClientEvent('radioPanicButton:client:panicBlip', playerId, coords, streetName, playerName)
            end
        end 
    end 
end)

RegisterServerEvent('radioPanicButton:server:panicButtonAudio')
AddEventHandler('radioPanicButton:server:panicButtonAudio', function(soundFile, radioChannel)
    for _, playerId in ipairs(GetPlayers()) do 
        if IsPlayerAceAllowed(playerId, config.acePermissionName) then 
            for _, broadcastChannel in pairs(config.broadcastChannels) do
                local playersInBroadcastChannels = exports['mumble-voip']:GetPlayersInRadioChannels(broadcastChannel)
                for _, player in pairs(playersInBroadcastChannels) do 
                    for id, _ in pairs(player) do 
                        if tostring(playerId) == tostring(id) then 
                            TriggerClientEvent('radioPanicButton:client:playSound', playerId, soundFile)
                        end 
                    end 
                end 
            end 
        end
    end 
end)

function GetDiscordUserTag(source)
    local identifiers = {}
    local identifierCount = GetNumPlayerIdentifiers(source)
      for a = 0, identifierCount do
          table.insert(identifiers, GetPlayerIdentifier(source, a))
      end
      for b = 1, #identifiers do
          if string.find(identifiers[b], "discord", 1) then
        local discordIdentifier = identifiers[b]
        local splitId = string.gsub(discordIdentifier, "discord:", "")
        return "<@"..splitId..">"
        end
    end
    return GetPlayerName(source)
end

curVersion = GetVersion()
local updatePath = "/Aidan4444/radioPanicButton"
local resourceName = "Radio Panic Button ("..GetCurrentResourceName()..")"
function checkVersion(err,response, headers)
    if err == 200 then
        local data = json.decode(response)
        local remoteVersion = data.fivem.version
        local changelog = data.fivem.changelog
        PrintDebugMessage("Version check returned "..err..", Local Version: "..curVersion..", Remote Version: "..remoteVersion, 4)
        if curVersion ~= remoteVersion and tonumber(curVersion) < tonumber(remoteVersion) then
            print("\n--------------------------------------------------------------------------")
            print("\n"..resourceName.." is outdated.\nNewest Version: "..remoteVersion.."\nYour Version: "..curVersion.."\nPlease update it from https://github.com"..updatePath.."")
            print("\nUpdate Changelog:\n"..changelog)
            print("\n--------------------------------------------------------------------------")
            updateAvailable = remoteVersion
        elseif tonumber(curVersion) > tonumber(remoteVersion) then
            print("Your version of "..resourceName.." seems to be higher than the current version.")
        else
            --print(resourceName.." is up to date!")
        end
    else
        PrintDebugMessage("radioPanicButton Version Check failed, please make sure its updated!")
    end
    
    SetTimeout(3600000, checkVersionHTTPRequest)
end

function checkVersionHTTPRequest()
    PerformHttpRequest("https://raw.githubusercontent.com/"..updatePath.."/master/version.json", checkVersion, "GET")
end

function GetVersion()
    local verFile = LoadResourceFile(GetCurrentResourceName(), "version.json")
    local verContent = json.decode(verFile)
end
