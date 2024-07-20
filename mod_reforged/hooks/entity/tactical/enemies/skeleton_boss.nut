// The Conqueror
::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/skeleton_boss", function(q) {
	q.onInit = @() function()
	{
		this.skeleton.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.SkeletonBoss);
		// b.IsAffectedByNight = false;			// Now handled by racial effect
		// b.IsAffectedByInjuries = false;		// Now handled by racial effect
		// b.IsImmuneToBleeding = true;			// Now handled by racial effect
		// b.IsImmuneToPoison = true;			// Now handled by racial effect
		b.IsImmuneToDisarm = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));

		// Reforged
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_inspiring_presence", function(o) {
			o.m.IsForceEnabled = true;
		}));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_cleaver"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_exploit_opening"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_formidable_approach"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_emperor")); TODO: Later when a framework for aura skills is available
	}
});
