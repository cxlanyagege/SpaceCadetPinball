<!-- markdownlint-disable-file MD033 -->

# SpaceCadetPinball

## Summary

Reverse engineering of `3D Pinball for Windows - Space Cadet`, a game bundled with Windows.

## How to play

Place compiled executable into a folder containing original game resources (not included).\
Supports data files from Windows and Full Tilt versions of the game.

## Changes for openvela

- `CMakeLists.txt` - NuttX CMake build configuration
- `Makefile` - NuttX Make build configuration  
- `Kconfig` - Kconfig configuration for menuconfig
- `Make.defs` - Build system integration

## Source

* `pinball.exe` from `Windows XP` (SHA-1 `2A5B525E0F631BB6107639E2A69DF15986FB0D05`) and its public PDB
* `CADET.EXE` 32bit version from `Full Tilt! Pinball` (SHA-1 `3F7B5699074B83FD713657CD94671F2156DBEDC4`)

## Tools used

`Ghidra`, `Ida`, `Visual Studio`

## What was done

* All structures were populated, globals and locals named.
* All subs were decompiled, C pseudo code was converted to compilable C++. Loose (namespace?) subs were assigned to classes.

## Configuration
The application can be configured through menuconfig:
```
Application Configuration -> Examples -> Space Cadet Pinball

Options:
- Program name: pinball (default)
- Task priority: 100
- Stack size: 32768 bytes
- Heap size: 65536 bytes (if task heap is enabled)
```

## Build Instructions

1. Enable in menuconfig:
```bash
./build.sh vendor/openvela/boards/vela/configs/goldfish-armeabi-v7a-ap --cmake menuconfig
# Navigate to: Application Configuration -> Examples -> [*] Space Cadet Pinball
```

2. Build:
```bash
./build.sh vendor/openvela/boards/vela/configs/goldfish-armeabi-v7a-ap --cmake -j$(sysctl -n hw.ncpu)
```

3. Run in emulator:
```bash
./emulator.sh vela
nsh> pinball
```

## TODO: Platform Adaptation Required

The following components need to be adapted for NuttX:
- [ ] Replace SDL2 graphics with NuttX graphics (LVGL/NX)
- [ ] Replace SDL2_mixer audio with NuttX audio system
- [ ] Implement input handling for NuttX
- [ ] Update main entry point (currently uses SDL main)
- [ ] Remove/replace imgui SDL implementations

## Plans

* ~~Decompile original game~~
* ~~Resizable window, scaled graphics~~
* ~~Loader for high-res sprites from CADET.DAT~~
* ~~Cross-platform port using SDL2, SDL2_mixer, ImGui~~
* Full Tilt Cadet features
* Localization support
* Maybe: Support for the other two tables - Dragon and Pirate
* Maybe: Game data editor

## On 64-bit bug that killed the game

I did not find it, decompiled game worked in x64 mode on the first try.\
It was either lost in decompilation or introduced in x64 port/not present in x86 build.\
Based on public description of the bug (no ball collision), I guess that the bug was in `TEdgeManager::TestGridBox`
