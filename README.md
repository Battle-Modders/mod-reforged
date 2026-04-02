# Quick Links

- [Installation Guide](https://github.com/Battle-Modders/mod-reforged/wiki/Installation-Guide)

- [Dev Diaries and Project Vision](https://github.com/Battle-Modders/mod-reforged/wiki)

- [Mod Compatibility and Recommendations](https://github.com/Battle-Modders/mod-reforged/wiki/Mod-Compatibility-and-Recommendations)

- [Nexus Mods Page](https://www.nexusmods.com/battlebrothers/mods/765)

- [Discord Server](https://discord.gg/uV3KzFFuMr)

# Installation
1. Download the .zip files attached to the latest releases of:
- `mod_reforged_core`: https://github.com/Battle-Modders/mod-reforged/releases
- `mod_reforged_assets`: https://github.com/Battle-Modders/mod_reforged_assets/releases

2. Place the files in your `Battle Brothers\data` folder in your game installation directory. Do NOT unzip the files.

3. Install all the dependencies. View the [Installation Guide](https://github.com/Battle-Modders/mod-reforged/wiki/Installation-Guide) for the list.

# Building from the Source Code
If you wish to build the mod yourself from the source code, you can follow the following steps.
- Install [BBBuilder](https://github.com/TaroEld/BBbuilder). Complete its setup as described in its instructions.
- Clone the Reforged repository into a local directory on your drive.
- Use the following BBBuilder commands to build the core and assets parts of Reforged. Replace `REFORGEDPATH` in these commands with the directory path to the local repository.
  - Core: `BBBuilder.exe build \"REFORGEDPATH\" -rebuild -ex \"brushes,gfx,music,sounds,scripts/!mods_preload/mod_reforged_assets\" -zipname mod_reforged_core"`
  - Assets: `BBBuilder.exe build \"REFORGEDPATH\" -rebuild -ex \"mod_reforged,mod_reforged_AfterHooks,preload,scripts,ui\" -in \"scripts/!mods_preload/mod_reforged_assets\" -zipname mod_reforged_assets"`
