::Reforged <- {
	Version = "0.6.19",
	ID = "mod_reforged",
	Name = "Reforged Mod",
	GitHubURL = "https://github.com/Battle-Modders/mod-reforged",
	ItemTable = {},
	QueueBucket = {
		Late = [],
		VeryLate = [], // For experimental modules only
		AfterHooks = [],
		FirstWorldInit = []
	}
};

local requiredMods = [
	"vanilla >= 1.5.0-15",
	"mod_modular_vanilla >= 0.3.6",
	"mod_msu >= 1.5.0",
	"mod_nested_tooltips >= 0.1.7",
	"mod_modern_hooks >= 0.4.10"
	"dlc_lindwurm",
	"dlc_unhold",
	"dlc_wildmen",
	"dlc_desert",
	"dlc_paladins",
	"mod_dynamic_perks >= 0.4.0"
	"mod_dynamic_spawns >= 0.3.5",
	"mod_item_tables >= 0.1.3",
	"mod_upd",
	"mod_stack_based_skills >= 0.5.1"
];

::Reforged.HooksMod <- ::Hooks.register(::Reforged.ID, ::Reforged.Version, ::Reforged.Name);
::Reforged.HooksMod.require(requiredMods);
::Reforged.HooksMod.conflictWith([
	"mod_legends",
	"mod_WMS", // Weapon Mastery Standardization by LordMidas. The functionality is integrated into Reforged. https://www.nexusmods.com/battlebrothers/mods/366
	"mod_betterFencing", // Better Fencing by LordMidas. The functionality is integrated into Reforged. https://www.nexusmods.com/battlebrothers/mods/369
	"tnf_modRNG" // Part of Tweaks and Fixes by LeVilainJoueur. https://www.nexusmods.com/battlebrothers/mods/69
]);

local queueLoadOrder = [];
foreach (requirement in requiredMods)
{
	local idx = requirement.find(" ");
	queueLoadOrder.push(">" + (idx == null ? requirement : requirement.slice(0, idx)));
}

// TODO: Establish a cleaner way to organize "Early" bucket hooks on a per-file basis
::Reforged.HooksMod.queue(queueLoadOrder, function() {
	::Reforged.HooksMod.hook("scripts/items/shields/shield", function(q) {
		// Hook the vanilla function so that ShieldExpert does not reduce damage to shields.
		// We do this in Early bucket so that subsequent hooks on this function are not affected
		q.applyShieldDamage = @(__original) function( _damage, _playHitSound = true )
		{
			// We double the damage because ShieldExpert reduces it by half
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)
				_damage *= 2;

			__original(_damage, _playHitSound);
		}
	});
}, ::Hooks.QueueBucket.Early);

::Reforged.HooksMod.queue(queueLoadOrder, function() {
	::Reforged.Mod <- ::MSU.Class.Mod(::Reforged.ID, ::Reforged.Version, ::Reforged.Name);

	::Reforged.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, ::Reforged.GitHubURL);
	::Reforged.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);
	::Reforged.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.NexusMods, "https://www.nexusmods.com/battlebrothers/mods/765");

	::Reforged.Mod.Debug.setFlag("ai", false);

	::include("mod_reforged/hooks/misc.nut");
	::include("mod_reforged/ui/load.nut");

	local function requireSettingValue( _setting, _value )
	{
		if (_setting.set(true)) _setting.lock(format("Required by %s (%s)", ::Reforged.Name, ::Reforged.ID));
		else ::MSU.QueueErrors.add(format("%s (%s) requires the MSU setting \'%s\' to be \'%s\'", ::Reforged.Name, ::Reforged.ID, _setting.getID(), _value + ""));
	}

	requireSettingValue(::getModSetting("mod_msu", "ExpandedSkillTooltips"), true);
	requireSettingValue(::getModSetting("mod_msu", "ExpandedItemTooltips"), true);

	foreach (file in ::IO.enumerateFiles("mod_reforged/msu_systems"))
	{
		::include(file);
	}

	::include("mod_reforged/hooks/config/strings.nut");

	foreach (file in ::IO.enumerateFiles("mod_reforged/hooks/config"))
	{
		::include(file);
	}

	foreach (file in ::IO.enumerateFiles("mod_reforged"))
	{
		::include(file);
	}
});

::Reforged.HooksMod.queue(queueLoadOrder, function() {
	foreach (func in ::Reforged.QueueBucket.Late)
	{
		func();
	}
}, ::Hooks.QueueBucket.Late);

::Reforged.HooksMod.queue(queueLoadOrder, function() {
	foreach (func in ::Reforged.QueueBucket.VeryLate)
	{
		func();
	}
}, ::Hooks.QueueBucket.VeryLate);

::Reforged.HooksMod.queue(queueLoadOrder, function() {
	foreach (file in ::IO.enumerateFiles("mod_reforged_AfterHooks"))
	{
		::include(file);
	}
	foreach (func in ::Reforged.QueueBucket.AfterHooks)
	{
		func();
	}
}, ::Hooks.QueueBucket.AfterHooks);

::Reforged.HooksMod.queue(queueLoadOrder, function() {
	foreach (func in ::Reforged.QueueBucket.FirstWorldInit)
	{
		func();
	}
	delete ::Reforged.QueueBucket;
}, ::Hooks.QueueBucket.FirstWorldInit);

// Helper function to move an already registered unit to the end of the vanilla tables, so that savegames remain compatible
local moveUnitTypeToBack = function( _entityType )
{
	if (!(_entityType in ::Const.EntityType))
	{
		::logWarning("Reforged: " + _entityType + " does not exist in ::Const.EntityType, so it could not be moved back");
		return;
	}

	local entityName = ::Const.Strings.EntityName[::Const.EntityType[_entityType]];
	local entityNamePlural = ::Const.Strings.EntityNamePlural[::Const.EntityType[_entityType]];
	local entityOrientationIcon = ::Const.EntityIcon[::Const.EntityType[_entityType]];

	// We remove the entity from the
	::Reforged.HooksMod.queue(queueLoadOrder, function() {
		::Const.EntityType.rawdelete(_entityType);
		::Const.Strings.EntityName.remove(::Const.Strings.EntityName.find(entityName));
		::Const.Strings.EntityNamePlural.remove(::Const.Strings.EntityNamePlural.find(entityNamePlural));
		::Const.EntityIcon.remove(::Const.EntityIcon.find(entityOrientationIcon));
	}, ::Hooks.QueueBucket.VeryEarly);

	::Reforged.HooksMod.queue(queueLoadOrder, function() {
		local highestID = 0;
		foreach (key, value in ::Const.EntityType)
		{
			if (typeof value == "integer" && value > highestID)
				highestID = value;
		}

		::Const.EntityType[_entityType] <- ++highestID;
		::Const.Strings.EntityName.push(entityName);
		::Const.Strings.EntityNamePlural.push(entityNamePlural);
		::Const.EntityIcon.push(entityOrientationIcon);
	}, ::Hooks.QueueBucket.AfterHooks);
}

// These are new vanilla types, which break savegame compatibility by their addition
// As a temporary solution we delete them VeryEarly from the vanilla tables/arrays and add them back AfterHooks
// Todo: remove this, once we do a savegame breaking release
moveUnitTypeToBack("LesserFleshGolem");
moveUnitTypeToBack("GreaterFleshGolem");
moveUnitTypeToBack("FaultFinder");
moveUnitTypeToBack("GrandDiviner");
moveUnitTypeToBack("FleshCradle");
