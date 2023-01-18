::mods_hookExactClass("entity/tactical/enemies/skeleton_heavy", function(o) {
	o.onInit = function()
	{
	   	this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SkeletonHeavy);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		// b.IsSpecializedInAxes = true;
		// b.IsSpecializedInCleavers = true;

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 100)
		// {
		// 	b.IsSpecializedInPolearms = true;
		// }

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

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();

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
	    if (offhand != null && offhandItem.isItemType(::Const.Items.ItemType.Shield))
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
	    }
	}

	local makeMiniboss = o.makeMiniboss;
	o.makeMiniboss = function()
	{
		local ret = makeMiniboss();

		if (ret)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_pattern_recognition"));
			if (::Reforged.Config.IsLegendaryDifficulty)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_unstoppable"));
			}
		}

		return ret;
	}
});
