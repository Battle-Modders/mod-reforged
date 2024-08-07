::Reforged.HooksMod.hook("scripts/entity/tactical/humans/barbarian_drummer", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local tattoos = [
			3,
			4,
			5,
			6
		];
		local tattoo_body = this.actor.getSprite("tattoo_body");
		local body = this.actor.getSprite("body");
		tattoo_body.setBrush("tattoo_0" + tattoos[::Math.rand(0, tattoos.len() - 1)] + "_" + body.getBrush().Name);
		tattoo_body.Visible = true;
		local tattoo_head = this.actor.getSprite("tattoo_head");
		tattoo_head.setBrush("tattoo_0" + tattoos[::Math.rand(0, tattoos.len() - 1)] + "_head");
		tattoo_head.Visible = true;
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BarbarianMarauder);
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		// b.IsSpecializedInSwords = true;
		// b.IsSpecializedInAxes = true;
		// b.IsSpecializedInMaces = true;
		// b.IsSpecializedInFlails = true;
		// b.IsSpecializedInPolearms = true;
		// b.IsSpecializedInThrowing = true;
		// b.IsSpecializedInHammers = true;
		// b.IsSpecializedInSpears = true;
		// b.IsSpecializedInCleavers = true;
		this.m.Skills.update();
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_wildmen_01");
		this.m.Skills.add(::new("scripts/skills/actives/barbarian_fury_skill"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_underdog"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_anticipation"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));	// Now granted to all humans by default
		// this.m.Skills.add(::new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));

		// if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 30)
		// {
			// this.m.Skills.add(::new("scripts/skills/effects/dodge_effect")); // Replaced as perk
		// }

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_survival_instinct"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
		__original();

		foreach (item in this.getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag))
		{
			::Reforged.Skills.addMasteryOfEquippedWeapon(this)
		}
	}
});
