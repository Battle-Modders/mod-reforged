- [Installation Guide](https://github.com/Battle-Modders/mod-reforged/wiki/Installation-Guide)

- [Dev Diaries and Project Vision](https://github.com/Battle-Modders/mod-reforged/wiki)

- [Mod Compatibility and Recommendations](https://github.com/Battle-Modders/mod-reforged/wiki/Mod-Compatibility-and-Recommendations)

- [Nexus Mods Page](https://www.nexusmods.com/battlebrothers/mods/765)

- [Discord Server](https://discord.gg/uV3KzFFuMr)

## Building from the Source Code
If you wish to build the mod yourself from the source code, you can follow the following steps.
- Install [BBBuilder](https://github.com/TaroEld/BBbuilder). Complete its setup as described in its instructions.
- Clone the Reforged repository into a local directory on your drive.
- Use the following BBBuilder commands to build the core and assets parts of Reforged. Replace `REFORGEDPATH` in these commands with the directory path to the local repository.
  - Core: `BBBuilder.exe build \"REFORGEDPATH\" -rebuild -ex \"brushes,gfx,music,sounds,scripts/!mods_preload/mod_reforged_assets\" -zipname mod_reforged_core"`
  - Assets: `BBBuilder.exe build \"REFORGEDPATH\" -rebuild -ex \"mod_reforged,mod_reforged_AfterHooks,preload,scripts,ui\" -in \"scripts/!mods_preload/mod_reforged_assets\" -zipname mod_reforged_assets"`
