::Reforged <- {
	Version = "0.1.0",
	ID = "mod_reforged",
	Name = "Reforged Mod",
};

::mods_registerMod(::Reforged.ID, ::Reforged.Version, ::Reforged.Name);
::mods_queue(::Reforged.ID, "mod_msu(>=1.2.0-rc.2), mod_dpf, mod_upd, mod_stack_based_skills, !mod_legends", function() {
	::Reforged.Mod <- ::MSU.Class.Mod(::Reforged.ID, ::Reforged.Version, ::Reforged.Name);	

	::include("mod_reforged/hooks/msu.nut");
	::include("mod_reforged/ui/load.nut");

	::Reforged.Mod.ModSettings.requireSettingValue(::getModSetting("mod_msu", "ExpandedSkillTooltips"), true);
	::Reforged.Mod.ModSettings.requireSettingValue(::getModSetting("mod_msu", "ExpandedItemTooltips"), true);

	foreach (file in ::IO.enumerateFiles("mod_reforged/mod_settings"))
	{
		::include(file);
	}

	::include("mod_reforged/hooks/hook_dpf.nut");

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

	::DPF.Perks.addPerkGroupToTooltips();
});
