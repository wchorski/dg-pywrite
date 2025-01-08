---
{"dg-publish":true,"permalink":"/developer/emulation/RPCS3/","tags":["emulation","gaming"],"created":"2024-11-26T17:07:19.000-06:00","updated":"2024-11-26T17:07:19.000-06:00"}
---

Playstation 3 emulator

## Manage / transfer save data
[link](https://rpcs3.net/quickstart# Manage Save Data](https://rpcs3.net/quickstart#manage_saves)
  
- For Windows users, save data files can be managed in `\dev_hdd0\home\00000001\savedata\`

- For Linux users, save data files can be managed in `~/.config/rpcs3/dev_hdd0/`

- For macOS users, save data files can be managed in `~/Library/Application Support/rpcs3/dev_hdd0/home/00000001/savedata/`

- For FreeBSD users, save data files can be managed in `~/.config/rpcs3/dev_hdd0/`

[[developer/emulation/Game Emulation\|Game Emulation]]

## SteamDeck
[[developer/emulation/Batocera on SteamDeck\|Batocera]]

### Optimization
Title **Dead Nation**: getting to 30fps

I'll only note down settings that were changed. default ones omitted from this list as u don't need to change them

- CPU
	- PPU Decoder: Recompiler LLVM
	- SPU Decoder: Recomipler (LLVM)
	- SPU XFloat: Approx.
	- SPU BLock: Safe
	- Preferred SPU: Auto
- GPU
	- Renderer: Vulkan
	- Zcull: Relaxed
	- Shader Quality: low
	- Default Resolution: 720x480 (may try 1280x720)