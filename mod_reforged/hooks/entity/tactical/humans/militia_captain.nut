::Reforged.HooksMod.hook("scripts/entity/tactical/humans/militia_captain", function(q) {
	q.onInit = @() function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.MilitiaCaptain);
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
		this.getSprite("socket").setBrush("bust_base_militia");
		this.getSprite("accessory_special").setBrush("bust_militia_band_02");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert")); // given back conditionally (if shield)
		// this.m.Skills.add(this.new("scripts/skills/actives/rally_the_troops")); // Replaced by perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		// Reforged
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_rally_the_troops", function(o) {
			o.m.Cooldown = 3;
		}));

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_onslaught"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_hold_steady"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_shield_sergeant"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exude_confidence"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_strength_in_numbers"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    __original();
	    ::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);

	    if (this.isArmedWithShield())
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_phalanx"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
	    }
	}
});
