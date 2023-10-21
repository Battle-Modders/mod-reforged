::Reforged.HooksMod.hook("scripts/entity/tactical/humans/nomad_outlaw", function(q) {
	q.onInit = @() function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.NomadOutlaw);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");

		if (this.Math.rand(1, 100) <= 15)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			this.getSprite("eye_rings").Visible = true;
		}

		// if (!this.m.IsLow)
		// {
		// 	b.IsSpecializedInSwords = true;
		// 	b.IsSpecializedInAxes = true;
		// 	b.IsSpecializedInMaces = true;
		// 	b.IsSpecializedInFlails = true;
		// 	b.IsSpecializedInPolearms = true;
		// 	b.IsSpecializedInThrowing = true;
		// 	b.IsSpecializedInHammers = true;
		// 	b.IsSpecializedInSpears = true;
		// 	b.IsSpecializedInCleavers = true;

		// 	if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		// 	{
		// 		b.MeleeSkill += 5;
		// 		b.RangedSkill += 5;
		// 	}
		// }

		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		// {
		// 	this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
		// }

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_vigorous_assault"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
    	}
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    __original();

	    if (::Reforged.Config.IsLegendaryDifficulty)
	    {
	    	::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 5);
	    }
	    else
	    {
	    	::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
	    }
	}
});
