::Reforged.HooksMod.hook("scripts/entity/tactical/humans/conscript", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Conscript);
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
		// this.m.Skills.add(::new("scripts/skills/perks/perk_brawny"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_nimble"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_fast_adaption"));
		// this.m.Skills.add(::new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(::new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_poise"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
		__original();
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
	}

	q.onSpawned = @() function()
	{
		this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_phalanx"));
	}
});
