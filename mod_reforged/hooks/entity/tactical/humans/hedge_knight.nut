::mods_hookExactClass("entity/tactical/humans/hedge_knight", function(o) {
	o.onInit = function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.HedgeKnight);
		b.TargetAttractionMult = 1.0;
		// b.IsSpecializedInSwords = true;
		// b.IsSpecializedInAxes = true;
		// b.IsSpecializedInMaces = true;
		// b.IsSpecializedInFlails = true;
		// b.IsSpecializedInPolearms = true;
		// b.IsSpecializedInThrowing = true;
		// b.IsSpecializedInHammers = true;
		// b.IsSpecializedInSpears = true;
		// b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_devastating_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); // Replaced with perk

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_personal_armor"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_survival_instinct"));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.removeByID("perk.rf_personal_armor");
    		this.m.Skills.add(::new("scripts/skills/perks/perk_fortified_mind"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_killing_frenzy"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_man_of_steel"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_pattern_recognition"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
    	}
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();

	    ::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);

	    local weapon = this.getMainhandItem();
	    if (weapon != null)
	    {
	    	if (weapon.isAOE())
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sweeping_strikes"));
	    		if (::Reforged.Config.IsLegendaryDifficulty)
	    		{
	    			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_death_dealer"));
	    		}
	    	}
	    	else
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_internal_hemorrhage"));
	    		if (::Reforged.Config.IsLegendaryDifficulty)
	    		{
	    			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_deep_impact"));
	    		}
	    	}
	    }
	}

	local makeMiniboss = o.makeMiniboss;
	o.makeMiniboss = function()
	{
		local ret = makeMiniboss();
		if (ret)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_clarity"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_lone_wolf"));
	    	if (::Reforged.Config.IsLegendaryDifficulty)
    		{
    			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_unstoppable"));
    			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_retribution"));
    		}
		}

		return ret;
	}
});
