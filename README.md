[![Game Version](https://img.shields.io/badge/wow-3.3.5-blue.svg)](https://github.com/Zidras/DBM-Icecrown/tree/Warmane-Icecrown)
[![Discord](https://discordapp.com/api/guilds/598993375479463946/widget.png?style=shield)](https://discord.gg/CyVWDWS)

# DBM for Warmane-Icecrown

Core addon backport from retail by Barsoomx: (https://github.com/Barsoomx/DBM-wowcircle).

This version aims to deliver more accurate timers and features from retail to Warmane-Icecrown server raids.

# What's new?
- Boss modules now have dedicated fields for type of bar and associated voice speech (countdown for bars, and sound on Special Warnings)
![image](https://user-images.githubusercontent.com/10605951/120121605-44e74c00-c19c-11eb-809b-7ceaee2336c8.png)
- Support for Voice Packs:
![image](https://user-images.githubusercontent.com/10605951/120121681-bf17d080-c19c-11eb-9c5c-77e131e92c14.png)
- Integration with Bunny's Weakauras backport;
- And more!

# HOW TO INSTALL FOR THE FIRST TIME
**Disclaimer: If you have used DBM before and you wish to save old DBM profiles, backup your WTF folder, because we will be performing a clean install as this is a retail backport and therefore it is not compatible with 2010's version of DBM. To proceed with the clean installation process, do the following steps:**

1. On your addons folder (Interface/Addons), select every DBM folder (everything that starts with DBM-) and **delete** them.
2. On your SavedVariables folder (WTF/Account/[AccountName]/SavedVariables), select every DBM file (everything that starts with DBM-) and **delete** them. **THIS STEP WILL REMOVE YOUR DBM CONFIGURATIONS/PROFILES!**
3. On **each** of your Characters SavedVariables folder (WTF/Account/[AccountName]/[ServerName]/[CharacterName]/SavedVariables). Select every DBM file (everything that starts with DBM-) and **delete** them. **THIS STEP WILL REMOVE YOUR DBM CONFIGURATIONS/PROFILES!**

**With no remnants of old DBM files we are now ready to start the installation process.**

1. Download the addon from the **main** repository (https://github.com/Zidras/DBM-Icecrown/archive/refs/heads/main.zip).
2. Inside the zip file, open DBM-Icecrown-main. Copy/Paste all those folders (DBM-Core, DBM-GUI, etc) into your addons folder (Interface/Addons). DO NOT put the DBM-Icecrown-main folder directly into the addon folder, it will not work.
3. Load your game client into your character selection screen. On the bottom left corner, click AddOns and enable all the DBM entries like so:
![image](https://user-images.githubusercontent.com/10605951/127546459-1dd1eb99-8360-40c2-9ffa-093e365cd01b.png)
![image](https://user-images.githubusercontent.com/10605951/127546757-e086103a-34bd-48c5-8555-a734031e1ecc.png)

# HOW TO KEEP THE ADDON UPDATED
Updating DBM follows the standard procedure that applies to any addon installation. Everytime there are new changes*, do these steps:
1. Download the addon from the **main** repository (https://github.com/Zidras/DBM-Icecrown/archive/refs/heads/main.zip).
2. Inside the zip file, open DBM-Icecrown-main. Select all the folders (DBM-Core, DBM-GUI, etc) and press Copy (Ctrl+C).
3. (**Advisable**) On your addons folder (Interface/Addons), before pasting, select the DBM folders that are there and delete them (you will not lose your profiles doing this, don't worry - those are on WTF folder and there is no need to touch that anymore). This ensures that there is no remnant file that could potentially conflict with latest releases.
4. On your addons folder (Interface/Addons), Paste (Ctrl+V) the previously copied folders here. DO NOT put the DBM-Icecrown-main folder directly into the addon folder, it will not work.

*To know when there are changes, you can Star/Watch this repository on GitHub (this requires a GitHub account) to receive notifications. Additionally, you can join the [Discord](https://discord.gg/CyVWDWS) server where there is a dedicated channel that posts everytime there is a new commit.

# QUICK START
To open the options window, type `/dbm` into your chat and hit enter or use the minimap icon. For more commands, type `/dbm help`.

# Problems
* If you've discovered something that's clearly wrong, or if you get an error, please create a [ticket](https://github.com/Zidras/DBM-Icecrown/issues).
* Feel free to join our [Discord](https://discord.gg/CyVWDWS) to talk, get help and discuss anything DBM related!
