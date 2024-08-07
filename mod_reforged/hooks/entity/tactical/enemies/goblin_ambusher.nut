::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/goblin_ambusher", function(q) {
	q.onInit = @() function()
	{
		this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.GoblinAmbusher);
		// b.DamageDirectMult = 1.25;
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("bust_goblin_01_head_0" + ::Math.rand(1, 3));
		this.getSprite("quiver").Visible = true;
		this.addDefaultStatusSprites();

		// if (!this.m.IsLow)
		// {
			// b.IsSpecializedInBows = true;
			// b.Vision = 8;

			// if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 180)
			// {
			// 	b.DamageDirectMult = 1.35;
			// }
		// }

		this.m.Skills.add(::new("scripts/skills/racial/goblin_ambusher_racial"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_bow"));
	}

	q.makeMiniboss = @(__original) function()
	{
		local ret = __original();
		if (ret)
		{
			this.m.Skills.removeByID("perk.fast_adaption"); // revert vanilla
			// Rest from vanilla: Dodge, Relentless, Head Hunter, Overwhelm

			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_target_practice"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_hip_shooter"));
		}

		return ret;
	}
});
