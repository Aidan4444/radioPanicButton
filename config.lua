config = {
    acePermissionName = 'panicButton', -- Example for config: add_ace group.leo "panicButton" allow [For Blips and Notification]

    logToDiscord = false, -- Logs panic button presses to Discord
    useDiscordNameForLog = true -- If set to true it will put the user's @ instead of their in game name, unless they don't have a Discord account linked
    discordWebhookUrl = '', -- Webhook to log panic button presses to 

    playPanicButtonAudio = true, -- Plays a beeping noise when you hit the panic button
    playDispatchAudio = true, -- Plays the dispatch audio (We have a 10-99...)
    panicButtonVolume = 0.8, -- Panic button and dispatch audio volume

    showBlip = true, -- Shows a blip of the officer's location
    blipsInBroadcastChannels = true, -- Will only show blips to the people in the channels specified in the broadcastChannels table below
    blipTimeout = 60, -- Amount of time before the panic button blip gets deleted (in seconds)
    
    showNotification = true, -- Shows a notification saying "[playerName] pressed their panic button at [streetName]"
    notificationsInBroadcastChannels = true, -- Will only show notifications to the people in the channels specified in the broadcastChannels table below

    haveRadioOpen = false, -- Makes it so you have to have your radio open to hit the panic button

    panicButtonKey = 'n', -- This will be the original key for the panic button, each client can further customise the keybind inn their GTA V keybinds menu under the FiveM tab

    radioChannels = { 
        [1] = 1, -- Allows the panic button to be used in frequency 1
        [2] = 2, -- Allows the panic button to be used in frequency 1
        [3] = 3, -- Allows the panic button to be used in frequency 1
    },

    broadcastChannels = {
        [1] = 1, -- Broadcasts the panic button to frequency 1 
        [2] = 2, -- Broadcasts the panic button to frequency 1 
    },
}