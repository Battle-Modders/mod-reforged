::Reforged.Assets <- {
	Version = "0.1.3",
	ID = "mod_reforged_assets",
	Name = "Reforged Mod Assets",
};

local hooksMod = ::Hooks.register(::Reforged.Assets.ID, ::Reforged.Assets.Version, ::Reforged.Assets.Name);
hooksMod.require([
	"mod_msu",
	"mod_modern_hooks",
	"mod_reforged"
]);

hooksMod.queue(">mod_msu", function() {
	local msu_mod = ::MSU.Class.Mod(::Reforged.Assets.ID, ::Reforged.Assets.Version, ::Reforged.Assets.Name);

	msu_mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, "https://github.com/Battle-Modders/mod_reforged_assets");
	msu_mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);
	msu_mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.NexusMods, "https://www.nexusmods.com/battlebrothers/mods/765");
});
