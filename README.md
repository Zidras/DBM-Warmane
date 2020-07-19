# Grab the latest version (5.02) [here](https://github.com/ajseward/DBM-Frostmourne/releases)
The master branch is used for development

# DBM-Frostmourne
Originally based on [DBM for Warmane - Icecrown](https://github.com/Ayaro1/DBM_Warmane_Icecrown). Most edits done by Sariyo, Gjeneth, Arrj, Nimloth, Zbruennig and anyone else mentioned in the changelog below.

A version of WotLK DBM with accurate timers for Warmane servers. Please see the Release tab to find the latest stable version.

### [LUA Diff between version 5.00 (the initial commit) and the original 3.3.5 DBM](https://github.com/ajseward/DBM-Frostmourne/tree/compare-to-dbm)



# Changelog 
#### General Notes
* This is a continuation of [DBM for Warmane - Icecrown](https://github.com/Ayaro1/DBM_Warmane_Icecrown)
* Timings are based on personal experience, vods, and logs of other guilds on Frostmourne. 
* Due to some form of spell batching / spell queuing, there is a small amount of randomness on a lot of boss abilities. 
* * Most of these are marked as CDs
* For example: Frost Blast on Kel'Thuzad, Locust Swarm (Cast, not the duration) on Anub'Rekhan, Noth's first Blink, and Eonar's Gift are the most random.

# 5.04 [IN DEVELOPMENT]

# Raids
# Ulduar

  #### Assembly of Iron 
  * Improved rune of death timer
  * Changed death tracking. 
  * Reduced lightning whirl cd by a lot.

  #### Mimiron 
  * Slightly reduced p1 to p2 timer

# 5.03
### General
* Cleaned up enable range frame calls. Should work now.

# Raids
# Ulduar

  #### Razorscale
  * Adjusted Turret Timers and warnings

  #### XT-002 
  * Adjusted tantrum timer to match server a bit better. 

  #### Assembly of Iron 
  * Warn rune of death soon when timer is complete since it seems to vary by ~1 second
  * Increased lightning tendril duration by 8.
  * Added timer for lightning whirl
  
  #### Kologarn
  * split eyebeam warnings to warn NEAR YOU when it damages you, and ON YOU when its targeting you.
  * Drastically reduced respawn time of arms. 

  #### Auriaya
  * Fixed guardian respawn timer

  #### Mimiron
  * Fixed phase timers being slightly off
  * Tagged proxmimity mines as a CD

# Vault of Archavon

  #### Emalon 
  * Reduced nova CD to match server. 

# 5.02
#### General
* Added Range Radar from later expansions

# Raids
# Naxxramas

  #### The Four Horsemen 
  * Added a timer for when marks will be cast.
  * Added a 10 yard range check
  
  #### Sapphirion
  * Added a 12 yard range check for the air phase.


# The Eye of Eternity 

  #### Malygos
  * Added a timer for Static Field cooldown in phase 3
  * Announce when targeted by Static Field, or when Static Field is near.

# Ulduar 

  #### XT-0002
  * Added 12 yard range check.

  #### Thorim
  * Fixed some typos causing lua errors

  #### Iron Council 
  * Added 20 yard range check if targeted by overwhelming power.

# Trial of the Crusader  

  #### Faction Champions
  * Major overhaul of the fight. Adds many more useful timers. -- Thanks Ayaro1

  #### Anub'arak
  * Added extra timers for emerges


# Icecrown Citadel
  * Added phases for Details 8.3 backport.

  #### Sindragosa
  * Removed chat spam from instability.

  ### The Lich King
  * Improved harvest soul and defile timers

# 5.01 
#### General 
* Added phase tracking support in Ulduar for Details! 8.3 backport

# 5.00 (zbruennig initial Frostmourne edits)

#### General
* Re-Added DBM-Profiles
* Removed malicious time bomb edit

# Raids 
# Naxxramas

  ### Noth the Plaguebringer
  * Added timer for Blink on 25 man
    
  ### Instructor Razuvious
  * Added duration timer for Mind Controls (from your raid team)
    
  ### Gothik the Harvester
  * Adjusted Phase 2 timer
  * Added timer for the gate opening
    
  ### Four Horsemen
  * Added timer for Sir Zeliek's Holy Wrath

  ### Grobbulus
  * Added a chat message when you get Mutating Injection
    
  ### Anub'rekhan
  * Adjust timer for Locust Swarm ending (not when he casts it, that's somewhat random)
    
  ### Grand Widow Faerlina
  * Added duration timer for Mind Controls (from your raid team)
    
  ### Kel'Thuzad
  * Adjusted Phase 2 timer
  * Adjusted the Range Check from 10 to 12 to better reflect the Frost Blast range on Warmane
  * Added timer for Mind Control on 25 man
  * Added timer for Frost Blast
  * Added warning timer for Mind Control
  * Added a bunch of warnings for Detonate Mana. You can't miss it now.

# The Obsidian Sanctum

  ### Sartharion
  * Adjusted timers for Tenebron / Vesperon / Shadron landing
  * Added a timer for Whelps spawning (from Tenebron's portal, as most groups don't kill his acolyte)
  * Added timers for portals activating for Vesperon and Shadron

# The Eye of Eternity

  ### Malygos
  * Added a timer for the first Vortex
  * Added a timer for the first intermission, when Malygos is attackable
  * Added a timer for the second intermission, when Malygos wipes his debuffs and starts casting Surge of Powers

# Ulduar

  ### Iron Council
  * Fixed an issue where engaging the boss isn't detected
  * Add timers for first ability in each phase
  * Add timer for Rune of Death cooldown
  * Add timer for Rune of Summoning cooldown
  * Adjust Overload warning to always show by default

  ### Hodir
  * Adjust timer for Flash Freeze

  ### Thorim
  * Added Chain Lightning timer
  * Added timer for Frostbolt Volley
  * Added timer for Frost Nova

  ### Freya
  * Added timer for Sunbeam
  * Added timer for Strengthened Iron Roots
  * Added timer for Allies of Nature (add spawns)

  ### General Vezax
  * Added timer for Mark of the Faceless CD

  ### Algalon
  * Big Bang now shows its alert even in a Black Hole

  ### Mimiron
  * Adjust timers between phases
  * Adjust Flame Suppressant timer
  * Adjust hard mode detection trigger


# 4.xx (Original DBM - Warmane - Icecrown Changes)

### General 
* Changed update download link to https://wow.ayaro.eu/addons/wotlk/
* Added the "/dbm rel" command to broadcast version check results to raid chat instead of self
* * This function requires you to be promoted in raid to avoid spam
* * This does not (yet) work for party chat
* Set the update notification to enabled by default
* * This does not appear to override settings with the notification disabled but works for fresh installs of this edited DBM
* Added the ElvUI main texture to DBM and set it to default
* * If you have ElvUI installed, you might see this texture twice in the dropdown list when choosing another texture
* Set the default size of the small bars to 207
* Removed some code that was edited out to reduce file size



# Raids

# Icecrown Citadel 

### Lord Marrowgar
  * Fixed Bone Spike timers
  * Fixed Bone Storm timer
  * Fixed Bone Storm cooldown timer
  * Added "Spikes up in..." timer for when Bone Spikes is being cast.
  * * This acts as a secondary timer next to the cooldown timer
  * Added "Whirlwind starts in..." timer for when Bone Storm is being cast.
  * * This acts as a secondary timer next to the cooldown timer

### Lady Deathwhisper 
  * Fixed heroic mode timers by breaking normal mode
  * Adjusted adds spawn timers to be more accurate
  * Adjusted the first dominate mind timer to be more accurate
  * * Ability is being used anywhere between 40 and 48 seconds so use it as a cooldown reset timer
  * Added the option to enable automatic removal of Mark/Gift of the Wild after 24 seconds of combat
  * * The 24 second delay is so that the buff is still active during first trinket uptime
  * * This option is enabled by default for dps and healers

### Gunship
  * Fixed combat start timer
  * Fixed the Battle Mage timer on Alliance side
  ###### Notes
  * Alliance and Horde have seperate code. 
  * I don't play Horde side so that's not getting fixed anytime soon unless someone is willing to provide data
  

### Deathbringer Saurfang
  * Fixed the timer for the first set of Bloodbeasts
  * Fixed combat start timer for the first pull on Alliance side
  ###### Notes
  * Alliance and Horde have seperate code. 
  * I don't play Horde side so that's not getting fixed anytime soon unless someone is willing to provide data

### Rotface
  * Fixed Vile Gas timer
  * Fixed Poison Slime Pipes timer
  * Adjusted the Range Check from 8 to 10 to better reflect the aoe range of Vile Gas on Warmane
  * Cleaned up code that was edited out to reduce file size and RAM load

### Festergut
  * Fixed Range Check to auto show
  * Adjusted the Range Check from 8 to 10 to better reflect the aoe range of Vile Gas on Warmane

### Blood-Queen Lana'thel
  * Adjusted the enrage timer to be more accurate

### Valithria Dreamwalker
  * Fixed the starting trigger for the bossmod, portal timers are showing again
  * Fixed Berserk timer for heroic difficulty (420 seconds)
  * Fixed Abom timers
  * Fixed Blazing Skeleton timers
  * Added timers and special warnings for Suppressors

### Sindragosa
  * Set the Range Check to always use Heroic Mode values (20) regardless of difficulty 
  * Added a raidchat notification "Gained_Instability" when casters/healers gain a stack of Instability 
  * Added a raidchat notification "Instability_Reset" when casters/healers drop their stacks of Instability

### The Lich King
  * Fixed combat start timer
  * Fixed the first phase 2 Soul Reaper timer - Thanks to Arrj @ Warmane - Icecrown
  * Fixed Harvest Souls timers for Heroic mode
  * * Timer for this can sometimes finish 1-3 seconds before the abilty is used cause Warmane


# Ruby Sanctum

### General Zarithrian
  * Adjusted Fear timer to be more accurate
  * * First fear seems to be a bit random
  * Adjusted timer for first adds to be more accurate
  * * First summon adds seems to be a bit random
  * Added "Adds arrive in..." timer

# Trial of the Crusader

### Northrend Beasts

#### Gormok the Impaler
  * Fixed combat start timer

#### Acidmaw & Dreadscale
  * Fixed combat start timer
  * Adjusted submerge timer to be more accurate, improvements still needed
  * Adjusted emerge timer to be more accurate

#### Icehowl
  * Fixed timer for Icehowls first Massive Crash
  * Added a seperate timer for the second Massive Crash in case the original timer from DBM doesn't trigger
  ###### Notes
  * It's possible to have two timers up for the second Massive Crash if and when the original timer triggers but that's better than having none

### Lord Jaraxxus
  * Fixed combat start timer for the first pull
  * Nether Power timers fix and warnings by Nimloth/Lothe @ Warmane Icecrown
  * Fixed timers for Nether Volcano's
  * Fixed timer for the first Nether Portal
  * Added a seperate timer with warning for the second Nether Portal since the original timer does not activate after the first portal spawns

### Anub'arak
 * Added a seperate timer, warning and special warning for the second submerge since the original does not reactivate after the first burrow

# Ulduar

### Razorscale
  * Fixed enrage timer

# Dungeons 

# Trial of the Champion 

### The Black Knight
  * Fixed combat start timer

# Pit of Saron

### Scourgelord Tyrannus 
  * Fixed combat start timer for the first pull
  * Fixed Forcefull Smash timer
