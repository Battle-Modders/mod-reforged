::Reforged.HooksMod.hook("scripts/entity/tactical/humans/barbarian_thrall", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local tattoos = [
			2,
			3
		];

		if (::Math.rand(1, 100) <= 66)
		{
			local tattoo_body = this.actor.getSprite("tattoo_body");
			local body = this.actor.getSprite("body");
			tattoo_body.setBrush("warpaint_0" + tattoos[::Math.rand(0, tattoos.len() - 1)] + "_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (::Math.rand(1, 100) <= 66)
		{
			local tattoo_head = this.actor.getSprite("tattoo_head");
			tattoo_head.setBrush("warpaint_0" + tattoos[::Math.rand(0, tattoos.len() - 1)] + "_head");
			tattoo_head.Visible = true;
		}

		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BarbarianThrall);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_wildmen_01");
		this.m.Skills.add(this.new("scripts/skills/actives/barbarian_fury_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));	// Now granted to all humans by default
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));

		// if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 20)
		// {
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		// }

		// Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_survival_instinct"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
		__original();
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 3);
	}
});
