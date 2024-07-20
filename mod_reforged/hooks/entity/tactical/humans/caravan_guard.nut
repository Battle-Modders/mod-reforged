::Reforged.HooksMod.hook("scripts/entity/tactical/humans/caravan_guard", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.CaravanGuard);
		// b.IsSpecializedInSwords = true;
		// b.IsSpecializedInAxes = true;
		// b.IsSpecializedInMaces = true;
		// b.IsSpecializedInFlails = true;
		// b.IsSpecializedInPolearms = true;
		// b.IsSpecializedInThrowing = true;
		// b.IsSpecializedInHammers = true;
		// b.IsSpecializedInSpears = true;
		// b.IsSpecializedInCleavers = true;
		// b.IsSpecializedInSpears = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_caravan");
		this.getSprite("dirt").Visible = true;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		// Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_phalanx"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_throwing"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    __original();
	    ::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
	}
});
