::mods_hookExactClass("entity/tactical/humans/noble_billman", function(o) {
	o.onInit = function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Billman);
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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); // Replaced with perk

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_battle_fervor"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bolster"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_follow_up"));

		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_anticipation"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_finesse"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_leverage"));
    	}
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();

	    local weapon = this.getMainhandItem();
	    if (weapon == null) return;

	    switch (weapon.getID())
	    {
	    	case "weapon.billhook":
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm"));
	    		if (::Reforged.Config.IsLegendaryDifficulty)
	    		{
	    			this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
	    			this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
	    		}
	    		break;

	    	case "weapon.pike":
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm"));
	    		if (::Reforged.Config.IsLegendaryDifficulty)
	    		{
	    			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_through_the_gaps"));
	    			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_long_reach"));
	    		}
	    		break;

    		case "weapon.polehammer":
    			this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_hammer"));
    			if (::Reforged.Config.IsLegendaryDifficulty)
	    		{
	    			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_deep_impact"));
	    			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_long_reach"));
	    		}
    			break;
	    }
	}
});
