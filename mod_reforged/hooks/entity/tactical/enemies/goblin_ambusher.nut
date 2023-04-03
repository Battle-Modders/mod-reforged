::mods_hookExactClass("entity/tactical/enemies/goblin_ambusher", function(o) {
	o.onInit = function()
	{
	    this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.GoblinAmbusher);
		b.DamageDirectMult = 1.25;
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("bust_goblin_01_head_0" + this.Math.rand(1, 3));
		this.getSprite("quiver").Visible = true;
		this.addDefaultStatusSprites();

		// if (!this.m.IsLow)
		// {
			b.IsSpecializedInBows = true;
			b.Vision = 8;

			// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 180)
			// {
			// 	b.DamageDirectMult = 1.35;
			// }
		// }

		this.m.Skills.add(this.new("scripts/skills/racial/goblin_ambusher_racial"));

		// Reforged
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_through_the_ranks"));
    		if (::Math.rand(1, 100) <= 25) this.m.Skills.add(::new("scripts/skills/perks/perk_rf_eyes_up"));
    	}
	}

	// local assignRandomEquipment = o.assignRandomEquipment;
	// o.assignRandomEquipment = function()
	// {
	//     assignRandomEquipment();

	//     if (::Reforged.Config.IsLegendaryDifficulty)
	//     {
	//     	::Reforged.Skills.addPerkGroup(this, "pg.rf_dagger", 4);
	//     }
	//     else
	//     {
	//     	::Reforged.Skills.addPerkGroup(this, "pg.rf_dagger", 3);
	//     }
	// }

	local makeMiniboss = o.makeMiniboss;
	o.makeMiniboss = function()
	{
		local ret = makeMiniboss();
		if (ret)
		{
			this.m.Skills.removeByID("perk.overwhelm"); // revert vanilla
			this.m.Skills.removeByID("perk.fast_adaption"); // revert vanilla
			// Rest from vanilla: Dodge, Relentless, Head Hunter

			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_eyes_up"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_hip_shooter"));
	    	if (::Reforged.Config.IsLegendaryDifficulty)
    		{
    			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_fresh_and_furious"));
    			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_marksmanship"));
    		}
		}

		return ret;
	}
});
