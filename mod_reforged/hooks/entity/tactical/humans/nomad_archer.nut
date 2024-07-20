::Reforged.HooksMod.hook("scripts/entity/tactical/humans/nomad_archer", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.NomadArcher);
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");

		if (::Math.rand(1, 100) <= 20)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
			dirt.Alpha = ::Math.rand(150, 255);
		}

		// b.IsSpecializedInBows = true; // Replaced with perk
		b.Vision = 8;

		// if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 30)
		// {
		// 	b.RangedSkill += 5;

		// 	if (::World.getTime().Days >= 60)
		// 	{
		// 		this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
		// 		b.RangedDefense += 5;
		// 	}
		// }

		this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));

		// if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 20)
		// {
		// 	this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		// }
	}

	q.onSetupEntity = @() function()
	{
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
	}

});
