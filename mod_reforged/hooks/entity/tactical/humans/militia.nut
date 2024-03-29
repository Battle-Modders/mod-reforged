::Reforged.HooksMod.hook("scripts/entity/tactical/humans/militia", function(q) {
	q.onInit = @() function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Militia);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.getSprite("accessory_special").setBrush("bust_militia_band_01");
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

	    // Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_strength_in_numbers"));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.BaseProperties.Hitpoints += 10;
    		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
    	}
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    __original();

	    if (::Reforged.Config.IsLegendaryDifficulty)
	    {
	    	::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
	    }
	    else
	    {
	    	::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 2);
	    }

	    if (this.isArmedWithShield())
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_phalanx"));
    		if (::Reforged.Config.IsLegendaryDifficulty)
		    {
		    	this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
		    }
    	}
	}
});
