[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![Discord Shield][discord-shield]][discord-invite]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <h3 align="center">radioPanicButton</h3>

  <p align="center">
    This script is easy to setup and is fully configurable.
    <br />
    <a href="https://github.com/Aidan4444/radioPanicButton/issues">Report Bug</a>
    ·
    <a href="https://github.com/Aidan4444/radioPanicButton/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li><a href="#features">Features</a></li>
    <li><a href="#requirements">Requirements</a></li>
    <li><a href="#showcase">Showcase</a></li>
    <li><a href="#example-config">Example Config</a></li>
    <li><a href="#installation-mumble-voip">Installation (mumble-voip)</a></li>
    <li><a href="#installation-pma-voice">Installation (pma-voice)</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



## Features
* Panic Button Audio
* Dispatch Audio (from LSPDFR)
* Discord logging 
* Blip for panic button
* Notification for panic button
* Each client can customize their keybind
* Fully customizable
* Supports mumble-voip and pma-voice


## Requirements
* [mumble-voip](https://forum.cfx.re/t/release-mumble-voip-rp-radio/1083683) or [pma-voice](https://forum.cfx.re/t/release-voip-pma-voice-mumble-voip-alternative/1896255)
* [rp-radio](https://forum.cfx.re/t/release-mumble-voip-rp-radio/1083683)


## Showcase
[Showcase Video](https://streamable.com/rc6ksz)

![image|690x29, 100%](https://cdn.discordapp.com/attachments/831462056229994497/846989150535417876/8026304cff389a4a54ca5dcfc92911f6.png)

![image|333x163, 100%](https://cdn.discordapp.com/attachments/831462056229994497/846989127601356800/a6135ec06fd504aacbb2e48ca9ca224e.png)


## Example Config
```lua
config = {
    usePmaVoice = false, -- If set to true it will use pma-voice, if set to false it will use mumble-voip

    acePermissionName = 'panicButton', -- Example for config: add_ace group.leo panicButton allow [For Blips and Notification]

    logToDiscord = false, -- Logs panic button presses to Discord
    useDiscordNameForLog = true, -- If set to true it will put the user's @ instead of their in game name, unless they don't have a Discord account linked
    discordWebhookUrl = '', -- Webhook to log panic button presses to 

    playPanicButtonAudio = true, -- Plays a beeping noise when you hit the panic button
    playDispatchAudio = true, -- Plays the dispatch audio (We have a 10-99...)
    panicButtonVolume = 0.8, -- Panic button and dispatch audio volume

    showBlip = true, -- Shows a blip of the officer's location
    blipsInBroadcastChannels = true, -- Will only show blips to the people in the channels specified in the broadcastChannels table below
    blipTimeout = 60, -- Amount of time before the panic button blip gets deleted (in seconds)
    
    showNotification = true, -- Shows a notification saying "[playerName] pressed their panic button at [streetName]"
    notificationsInBroadcastChannels = true, -- Will only show notifications to the people in the channels specified in the broadcastChannels table below

    haveRadioOpen = true, -- Makes it so you have to have your radio open to hit the panic button

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
```


## Installation (mumble-voip)
1. Download the latest [release](https://github.com/Aidan4444/radioPanicButton/releases/latest)
2. Rename the resource to just "radioPanicButton"
3. Configure the [config.lua](https://github.com/Aidan4444/radioPanicButton/blob/master/config.lua) file 
4. Add to your server.cfg `ensure radioPanicButton`
5. Setup ace permissions *(more info in config file)*


## Installation (pma-voice)
1. Download the latest [release](https://github.com/Aidan4444/radioPanicButton/releases/latest)
2. Rename the resource to just "radioPanicButton"
3. Configure the [config.lua](https://github.com/Aidan4444/radioPanicButton/blob/master/config.lua) file 
4. Add to your server.cfg `ensure radioPanicButton`
5. Setup ace permissions *(more info in config file)*
6. In the [config.lua](https://github.com/Aidan4444/radioPanicButton/blob/master/config.lua) file set `usePmaVoice = true`
7. Add the following code below to **pma-voice**

### pma-voice/server/server.lua
```lua
function getPlayersInRadioChannel(channel)
	local returnChannel = radioData[channel]
	if returnChannel then
		return returnChannel
	end
	-- channel doesnt exist
	return {}
end

function getPlayersInRadioChannels(...)
	local channels = { ... }
	local players = {}

	for i = 1, #channels do
		local channel = tonumber(channels[i])

		if channel ~= nil then
			if radioData[channel] ~= nil then
				players[#players + 1] = radioData[channel]
			end
		end
	end

	return players
end

exports('getPlayersInRadioChannel', getPlayersInRadioChannel)
exports('GetPlayersInRadioChannel', getPlayersInRadioChannel)

exports('GetPlayersInRadioChannels', getPlayersInRadioChannels)
exports('GetPlayersInRadioChannels', getPlayersInRadioChannels)
```

### pma-voice/client/client.lua
```lua
function GetPlayersInRadioChannels(...)

    local channels = { ... }

    local players = {}

    for i = 1, #channels do

        local channel = tonumber(channels[i])

        if channel ~= nil then

            if radioData[channel] ~= nil then

                players[#players + 1] = radioData[channel]

            end

        end

    end

    return players

end

function GetPlayerRadioChannel(serverId)

    if serverId ~= nil then 

        if voiceData.radio > 0 then 

            

            return voiceData.radio

        end 

    end 

end

exports("GetPlayersInRadioChannels", GetPlayersInRadioChannels)

exports("GetPlayerRadioChannel", GetPlayerRadioChannel)
```


## Roadmap

See the [open issues](https://github.com/othneildrew/Best-README-Template/issues) for a list of proposed features (and known issues).


## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


## Contact

Discord      - [Aidan_ogg#0001](https://discordapp.com/users/705110046563893259)

FiveM Forums - [Aidan_ogg](https://forum.cfx.re/u/aidan_ogg)

FiveM Post   - [Radio Panic Button](https://forum.cfx.re/t/standalone-release-radio-panic-button-rp-radio/2969686)

[![Discord Banner][discord-banner]][discord-invite]






<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Aidan4444/radioPanicButton.svg?style=for-the-badge
[contributors-url]: https://github.com/Aidan4444/radioPanicButton/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Aidan4444/radioPanicButton.svg?style=for-the-badge
[forks-url]: https://github.com/Aidan4444/radioPanicButton/network/members
[stars-shield]: https://img.shields.io/github/stars/Aidan4444/radioPanicButton.svg?style=for-the-badge
[stars-url]: https://github.com/Aidan4444/radioPanicButton/stargazers
[issues-shield]: https://img.shields.io/github/issues/Aidan4444/radioPanicButton.svg?style=for-the-badge
[issues-url]: https://github.com/Aidan4444/radioPanicButton/issues
[license-shield]: https://img.shields.io/github/license/Aidan4444/radioPanicButton.svg?style=for-the-badge
[license-url]: https://github.com/Aidan4444/radioPanicButton/blob/master/LICENSE
[discord-invite]: https://discord.gg/vxDde5utc5
[discord-shield]: https://discord.com/api/guilds/847541172876607538/widget.png?style=shield
[discord-banner]: https://discord.com/api/guilds/847541172876607538/widget.png?style=banner2
