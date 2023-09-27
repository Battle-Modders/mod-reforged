::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/skeleton_heavy_bodyguard", function(q) {
	q.onInit = @(__original) function()
	{
	   this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SkeletonHeavy);
		b.Initiative -= 50;
		// b.IsAffectedByNight = false;			// Now handled by racial effect
		// b.IsAffectedByInjuries = false;		// Now handled by racial effect
		// b.IsImmuneToBleeding = true;			// Now handled by racial effect
		// b.IsImmuneToPoison = true;			// Now handled by racial effect
		// b.IsSpecializedInAxes = true;
		// b.IsSpecializedInCleavers = true;
		// b.IsSpecializedInPolearms = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_man_of_steel"));

		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_personal_armor"));
    	}
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    __original();

	    local weapon = this.getMainhandItem();
	    if (weapon == null) return;

	    if (weapon.isWeaponType(::Const.Items.WeaponType.Sword))
	    {
	    	::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);

	    	local aoo = this.getSkills().getAttackOfOpportunity();
	    	if (aoo != null && aoo.isDuelistValid())
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
	    	}

	    	if (weapon.isItemType(::Const.Items.ItemType.OneHanded))
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_double_strike"));
	    	}
	    	else
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_death_dealer"));
	    	}

	    	if (::Reforged.Config.IsLegendaryDifficulty)
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_double_strike"));
	    	}
	    }
	    else if (weapon.isWeaponType(::Const.Items.WeaponType.Cleaver))
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sanguinary"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_cleaver"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_swordlike"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bloodbath"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_double_strike"));
	    	local aoo = this.getSkills().getAttackOfOpportunity();
	    	if (aoo != null && aoo.isDuelistValid())
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
	    	}
	    	if (::Reforged.Config.IsLegendaryDifficulty)
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
	    	}
	    }
	    else if (weapon.isWeaponType(::Const.Items.WeaponType.Polearm))
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_leverage"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_intimidate"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_long_reach"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_death_dealer"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
	    	if (::Reforged.Config.IsLegendaryDifficulty)
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sweeping_strikes"));
	    	}
	    }

	    local offhand = this.getOffhandItem();
	    if (offhand != null && offhand.isItemType(::Const.Items.ItemType.Shield))
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
	    }
	}
});
