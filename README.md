<div align="center">

# DBM-Warmane (3.3.5a)

[![Game Version](https://img.shields.io/badge/wow-3.3.5-blue.svg)](https://github.com/Zidras/DBM-Warmane)
[![GitHub Actions](https://github.com/Zidras/DBM-Warmane/workflows/lint/badge.svg?branch=main&event=push)](https://github.com/Zidras/DBM-Warmane/actions?query=workflow%3Alint+branch%3Amain)
[![Twitch](https://img.shields.io/twitch/status/the_zidras?style=social)](https://www.twitch.tv/the_zidras)
[![Discord](https://img.shields.io/discord/598993375479463946.svg?label=&logo=discord&logoColor=ffffff&color=7389D8&labelColor=6A7EC2)](https://discord.gg/CyVWDWS)
[![PayPal](https://img.shields.io/endpoint?url=https://www.stormfx.com/img/svg/paypal.json)](https://paypal.me/zidras)


</div>

Core addon backport from retail by Barsoomx: (https://github.com/Barsoomx/DBM-wowcircle).

This repository aims to deliver more accurate timers and features from retail to all four Warmane WotLK realms - Icecrown, Lordaeron, Frostmourne and Onyxia.

# What's new?
- Boss modules now have dedicated fields for type of bar and associated voice speech (countdown for bars, and sound on Special Warnings)
![image](https://user-images.githubusercontent.com/10605951/120121605-44e74c00-c19c-11eb-809b-7ceaee2336c8.png)
- Support for Voice Packs:
![image](https://user-images.githubusercontent.com/10605951/120121681-bf17d080-c19c-11eb-9c5c-77e131e92c14.png)
- Integration with Bunny's Weakauras backport:
![image](https://user-images.githubusercontent.com/10605951/130357929-c8cb1cb7-e5ff-40bf-a36f-2587d966bca5.png)
- And more!

## Support
If you would like to show your appreciation for my work (**which is by no means required**), you can donate in two ways:
- [**Streamelements**](https://streamelements.com/the_zidras/tip): your Twitch name will show on my stream at the time of the donation, and in the widget as the latest donation!
- [**PayPal**](https://paypal.me/zidras).

# HOW TO INSTALL FOR THE FIRST TIME
**Disclaimer: If you have used DBM before and you wish to save old DBM profiles, backup your WTF folder, because we will be performing a clean install as this is a retail backport and therefore it is not compatible with 2010's version of DBM. To proceed with the clean installation process, do the following steps:**

1. On your addons folder (Interface/Addons), select every DBM folder (everything that starts with DBM-) and **delete** them.
2. On your SavedVariables folder (WTF/Account/[AccountName]/SavedVariables), select every DBM file (everything that starts with DBM-) and **delete** them. **THIS STEP WILL REMOVE YOUR DBM CONFIGURATIONS/PROFILES!**
3. On **each** of your Characters SavedVariables folder (WTF/Account/[AccountName]/[ServerName]/[CharacterName]/SavedVariables). Select every DBM file (everything that starts with DBM-) and **delete** them. **THIS STEP WILL REMOVE YOUR DBM CONFIGURATIONS/PROFILES!**

**With no remnants of old DBM files we are now ready to start the installation process.**

1. Download the addon from the **main** repository (https://github.com/Zidras/DBM-Warmane/archive/refs/heads/main.zip).
2. Inside the zip file, open DBM-Warmane-main. Copy/Paste all those folders (DBM-Core, DBM-GUI, etc) into your addons folder (Interface/Addons). DO NOT put the DBM-Warmane-main folder directly into the addon folder, it will not work.
3. Load your game client into your character selection screen. On the bottom left corner, click AddOns and enable all the DBM entries like so:
![image](https://user-images.githubusercontent.com/10605951/127546459-1dd1eb99-8360-40c2-9ffa-093e365cd01b.png)
![image](https://user-images.githubusercontent.com/10605951/127546757-e086103a-34bd-48c5-8555-a734031e1ecc.png)

# HOW TO KEEP THE ADDON UPDATED
Updating DBM follows the standard procedure that applies to any addon installation. Everytime there are new changes*, do these steps:
1. Download the addon from the **main** repository (https://github.com/Zidras/DBM-Warmane/archive/refs/heads/main.zip).
2. Inside the zip file, open DBM-Warmane-main. Select all the folders (DBM-Core, DBM-GUI, etc) and press Copy (Ctrl+C).
3. (**Advisable**) On your addons folder (Interface/Addons), before pasting, select the DBM folders that are there and delete them (you will not lose your profiles doing this, don't worry - those are on WTF folder and there is no need to touch that anymore). This ensures that there is no remnant file that could potentially conflict with latest releases.
4. On your addons folder (Interface/Addons), Paste (Ctrl+V) the previously copied folders here. DO NOT put the DBM-Warmane-main folder directly into the addon folder, it will not work.

*To know when there are changes, you can Star/Watch this repository on GitHub (this requires a GitHub account) to receive notifications. Additionally, you can join the [Discord](https://discord.gg/CyVWDWS) server where there is a dedicated channel that posts everytime there is a new commit.

# QUICK START
To open the options window, type `/dbm` into your chat and hit enter or use the minimap icon. For more commands, type `/dbm help`.

# Problems
* If you've discovered something that's clearly wrong, or if you get an error, please create a [ticket](https://github.com/Zidras/DBM-Warmane/issues).
* If the problem is related to a boss mechanic or timer, a [Transcriptor](https://github.com/Zidras/Transcriptor-WOTLK) log (with debug level 3) will be required - instructions can be found [here](https://github.com/Zidras/Transcriptor-WOTLK#how-to-use).
* Feel free to join our [Discord](https://discord.gg/CyVWDWS) to talk, get help and discuss anything DBM related!
