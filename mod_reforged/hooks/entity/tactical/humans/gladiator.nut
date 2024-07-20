::Reforged.HooksMod.hook("scripts/entity/tactical/humans/gladiator", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Gladiator);
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
		this.getSprite("socket").setBrush("bust_base_southern");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		// this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect")); // Replaced with perk
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		// this.m.Skills.add(this.new("scripts/skills/actives/footwork")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_poise"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_survival_instinct"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_the_rush_of_battle"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
		__original();

		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);

		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			if (::Reforged.Items.isDuelistValid(weapon))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
			}
			else
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
			}

			if (weapon.getRangeMax() == 2) this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm"));
		}
	}

	q.makeMiniboss = @(__original) function()
	{
		local ret = __original();
		if (ret)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_pattern_recognition"));
		}

		return ret;
	}
});
