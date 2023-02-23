::mods_hookExactClass("entity/tactical/enemies/skeleton_medium_polearm", function(o) {
	o.onInit = function()
	{
	    this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SkeletonMedium);
		b.Initiative -= 20;
		// b.IsAffectedByNight = false;			// Now handled by racial effect
		// b.IsAffectedByInjuries = false;		// Now handled by racial effect
		// b.IsImmuneToBleeding = true;			// Now handled by racial effect
		// b.IsImmuneToPoison = true;			// Now handled by racial effect

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 100)
		// {
		// 	b.IsSpecializedInPolearms = true;
		// }

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_follow_up"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_long_reach"));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_intimidate"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_leverage"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_man_of_steel"));
    	}
	}
});
