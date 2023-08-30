::Reforged <- {
	Version = "0.1.22",
	ID = "mod_reforged",
	Name = "Reforged Mod",
	GitHubURL = "https://github.com/Battle-Modders/mod-reforged",
	ItemTable = {}
};

::mods_registerMod(::Reforged.ID, ::Reforged.Version, ::Reforged.Name);
::mods_queue(::Reforged.ID, "mod_msu(>=1.3.0-reforged.7), dlc_lindwurm, dlc_unhold, dlc_wildmen, dlc_desert, dlc_paladins, mod_dynamic_perks(>=0.1.1), mod_upd, mod_stack_based_skills, !mod_legends", function() {
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
