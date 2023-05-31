![BADGE](https://img.shields.io/badge/Version-R_1.0.0-green)
# GHDS Joypad

A LUA script to make using guitars on GHDS games with DeSmuME require less BloatWare(tm) (namely antimicrox and autohotkey)

## Installation
### Required : 
- [DeSmuME](https://desmume.org/)
- Lua 5.1.5 DLL [(x32)](https://sourceforge.net/projects/luabinaries/files/5.1.5/Windows%20Libraries/Dynamic/lua-5.1.5_Win32_dll16_lib.zip/download) [(x64)](https://sourceforge.net/projects/luabinaries/files/5.1.5/Windows%20Libraries/Dynamic/lua-5.1.5_Win64_dll16_lib.zip/download)
- [GHDS Joypad.lua](https://github.com/arcanxeros/GHDSJoypad/raw/main/GHDS%20Joypad.lua)

### Lua51.dll
DeSmuME doesnt have the lua51.dll included by default. This dll is required to execute lua scripts.  
Simply extract "lua5.1.dll" from the downloaded zip, rename it to "lua51.dll" and put it into DeSmuME's folder.


### Configuration
In order for this script to work as intended, Your controls must be set accordingly : 

- Config > Control Config  
![png](https://github.com/arcanxeros/GHDSJoypad/blob/main/images/1.png?raw=true)  
-> "Auto-Whammy" is used to automatically move the whammy left & right. Given it is impossible to read gamepad inputs outside of DeSmuME's emulated DS buttons, this is the only way possible to achieve whammy.  
-> "Touch Toggle" is used to swap between mouse touchscreen and simulated stylus movement.  
-> "Gizmos Toggle" is a debug feature. this button toggles rendering of a few usefull things (currently Stylus position and path)

- Config > Slot 2 (GBA Slot)  
![png](https://github.com/arcanxeros/GHDSJoypad/blob/main/images/2.png?raw=true)  

- Config > Hotkey Config  
![png](https://github.com/arcanxeros/GHDSJoypad/blob/main/images/3.png?raw=true)  

- Config > Microphone Settings  
![png](https://github.com/arcanxeros/GHDSJoypad/blob/main/images/4.png?raw=true)  


    
## Compatibility

The script *should* work with every GHDS Games, though I did not test with all games.

|Game                               |Compatibility|                                               |
|:----------------------------------|:------------|:----------------------------------------------|
|`Guitar Hero On Tour`              |`Untested`   |                                               |
|`Guitar Hero On Tour : Decades`    |`Untested`   |                                               |
|`Guitar Hero On Tour : Modern Hits`|`Working`    |"StarPower Activation" set to "Microphone Only"|
|`Band Hero`                        |`Working`    | No extra in-game settings required            |

(1) - SP Activation set to "Microphone Only" required to prevent automatic instant SP activation as soon as the game can.
      Caused by the fact that the game triggers SP when you press any of the DS buttons
      
## Usage

#### Loading the script
- Boot your game in DeSmuMe
- Open a new LUA script window (Tools > Lua Scripting > New Lua Script Window...)  
![png](https://github.com/arcanxeros/GHDSJoypad/blob/main/images/6.png?raw=true)  
- Click "Browse" and select the downloaded lua file  
![png](https://github.com/arcanxeros/GHDSJoypad/blob/main/images/8.png?raw=true)  

If the console output says "```script returned but is still running registered functions```", the scripts is running !

#### In Game
A new text should appear in the game.  
![png](https://github.com/arcanxeros/GHDSJoypad/blob/main/images/5.png?raw=true)  
This Tells you in which mode you currently are : 
- in MOUSE TOUCHSCREEN, the touchscreen will react to your mouse inputs, but not to your guitar. This is the default mode
- in JOYPAD TOUCHSCREEN, the touchscreen will react to your guitar (strum & auto-whammy), but not to your mouse.

You can swap modes anytime by pressing LEFT/"Touch Toggle".

## Happy bloatwareless Shredding !
