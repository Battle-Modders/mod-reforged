::Reforged.HooksMod.hook("scripts/entity/tactical/humans/bounty_hunter_ranged", function(q) {
	q.onInit = @(__original) function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BountyHunterRanged);
		b.TargetAttractionMult = 1.1;
		b.Vision = 8;
		// b.IsSpecializedInCrossbows = true;
		// b.IsSpecializedInBows = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/actives/footwork")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); // Replaced with perk

		// Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		}
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    __original();

	    local weapon = this.getMainhandItem();
	    if (weapon == null) return;

		if (weapon.isWeaponType(::Const.Items.WeaponType.Bow))
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_target_practice"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_bow"));

		    if (::Math.rand(1, 100) <= 50)
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_eyes_up"));
			}

			else
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_flaming_arrows"));
			}

			if (::Reforged.Config.IsLegendaryDifficulty)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_hip_shooter"));
			}
	    }

    	else
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_power_shot"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_crossbow"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_iron_sights"));

    		if (::Reforged.Config.IsLegendaryDifficulty)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_muscle_memory"));
			}
    	}
	}
});
