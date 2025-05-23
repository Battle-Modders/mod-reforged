::Reforged.HooksMod.hook("scripts/entity/tactical/humans/barbarian_chosen", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local tattoos = [
			3,
			4,
			5,
			6
		];

		if (::Math.rand(1, 100) <= 66)
		{
			local tattoo_body = this.actor.getSprite("tattoo_body");
			local body = this.actor.getSprite("body");
			tattoo_body.setBrush("tattoo_0" + tattoos[::Math.rand(0, tattoos.len() - 1)] + "_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (::Math.rand(1, 100) <= 50)
		{
			local tattoo_head = this.actor.getSprite("tattoo_head");
			tattoo_head.setBrush("tattoo_0" + tattoos[::Math.rand(0, tattoos.len() - 1)] + "_head");
			tattoo_head.Visible = true;
		}

		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BarbarianChosen);
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
		this.m.Skills.add(::new("scripts/skills/perks/perk_adrenalin"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_berserk"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_killing_frenzy"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_devastating_strikes"));	// This is now replaced with "Calculated Strikes"
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));	// Now granted to all humans by default
		// this.m.Skills.add(::new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_calculated_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exude_confidence"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_feral_rage"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_menacing"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_survival_instinct"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_vigorous_assault"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
		__original();
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
	}
});
