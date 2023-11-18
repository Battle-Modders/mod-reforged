::Reforged <- {
	Version = "0.3.8",
	ID = "mod_reforged",
	Name = "Reforged Mod",
	GitHubURL = "https://github.com/Battle-Modders/mod-reforged",
	ItemTable = {},
	QueueBucket = {
		Late = [],
		FirstWorldInit = []
	}
};

local requiredMods = [
	"mod_msu >= 1.3.0-reforged.10",
	"mod_modern_hooks >= 0.4.0-reforged.1"
	"dlc_lindwurm",
	"dlc_unhold",
	"dlc_wildmen",
	"dlc_desert",
	"dlc_paladins",
	"mod_dynamic_perks >= 0.2.0"
	"mod_dynamic_spawns >= 0.2.1",
	"mod_item_tables >= 0.1.1",
	"mod_upd",
	"mod_stack_based_skills >= 0.5.0"
];

::Reforged.HooksMod <- ::Hooks.register(::Reforged.ID, ::Reforged.Version, ::Reforged.Name);
::Reforged.HooksMod.require(requiredMods);
::Reforged.HooksMod.conflictWith(
	"mod_legends"
);

local queueLoadOrder = [];
foreach (requirement in requiredMods)
{
	local idx = requirement.find(" ");
	queueLoadOrder.push(">" + (idx == null ? requirement : requirement.slice(0, idx)));
}

::Reforged.HooksMod.queue(queueLoadOrder, function() {
	::Reforged.Mod <- ::MSU.Class.Mod(::Reforged.ID, ::Reforged.Version, ::Reforged.Name);	

	::Reforged.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, ::Reforged.GitHubURL);
	::Reforged.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);

	::include("mod_reforged/hooks/msu.nut");
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

	::MSU.AI.addBehavior("RF_AttackLunge", "RF.AttackLunge", ::Const.AI.Behavior.Order.Darkflight, ::Const.AI.Behavior.Score.Attack);
	::MSU.AI.addBehavior("RF_CoverAlly", "RF.CoverAlly", ::Const.AI.Behavior.Order.Adrenaline, 60);
	::MSU.AI.addBehavior("RF_FollowUp", "RF.FollowUp", ::Const.AI.Behavior.Order.AttackDefault, 1);
	::MSU.AI.addBehavior("RF_HoldSteady", "RF.HoldSteady", ::Const.AI.Behavior.Order.BoostMorale, ::Const.AI.Behavior.Score.BoostMorale);
	::MSU.AI.addBehavior("RF_Onslaught", "RF.Onslaught", ::Const.AI.Behavior.Order.BoostMorale, ::Const.AI.Behavior.Score.BoostMorale);
	::MSU.AI.addBehavior("RF_KataStep", "RF.KataStep", ::Const.AI.Behavior.Order.Adrenaline, ::Const.AI.Behavior.Score.Attack);
	::MSU.AI.addBehavior("RF_Blitzkrieg", "RF.Blitzkrieg", ::Const.AI.Behavior.Order.Rally, ::Const.AI.Behavior.Score.Rally);
	::MSU.AI.addBehavior("RF_SanguineCurse", "RF.SanguineCurse", ::Const.AI.Behavior.Order.Hex, ::Const.AI.Behavior.Score.Hex);

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
	foreach (func in ::Reforged.QueueBucket.FirstWorldInit)
	{
		func();
	}
	delete ::Reforged.QueueBucket;
}, ::Hooks.QueueBucket.FirstWorldInit);
