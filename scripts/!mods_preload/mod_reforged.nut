::Reforged <- {
	Version = "0.1.0",
	ID = "mod_reforged",
	Name = "Reforged Mod",
};

::mods_registerMod(::Reforged.ID, ::Reforged.Version, ::Reforged.Name);
::mods_queue(::Reforged.ID, "mod_msu(>=1.2.0-rc.2), mod_dpf, mod_upd, mod_stack_based_skills, !mod_legends", function() {
	::Reforged.Mod <- ::MSU.Class.Mod(::Reforged.ID, ::Reforged.Version, ::Reforged.Name);	

	::include("mod_reforged/hooks/msu.nut");

	::Reforged.Mod.ModSettings.requireSettingValue(::getModSetting("mod_msu", "ExpandedSkillTooltips"), true);
	::Reforged.Mod.ModSettings.requireSettingValue(::getModSetting("mod_msu", "ExpandedItemTooltips"), true);

	local generalPage = ::Reforged.Mod.ModSettings.addPage("General");
	local legendaryDifficulty = generalPage.addBooleanSetting("LegendaryDifficulty", false, "Legendary Difficulty");
	legendaryDifficulty.getData().NewCampaign <- true;
	legendaryDifficulty.onBeforeChangeCallback(function( _newValue ) {
		::Reforged.Config.IsLegendaryDifficulty = _newValue;
	});

	::include("mod_reforged/hooks/msu.nut");
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

	foreach (perkGroupScript in ::IO.enumerateFiles("scripts/mods/mod_reforged/perk_groups"))
	{
		::DPF.Perks.PerkGroups.add(::new(perkGroupScript));
	}

	foreach (perkGroupCollectionScript in ::IO.enumerateFiles("scripts/mods/mod_reforged/perk_group_collections"))
	{
		::DPF.Perks.PerkGroupCategories.add(::new(perkGroupCollectionScript));
	}

	::DPF.Perks.addPerkGroupToTooltips();
});
