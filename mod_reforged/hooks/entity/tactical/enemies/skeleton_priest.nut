// Ancient Priest
::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/skeleton_priest", function(q) {
	q.onInit = @() function()
	{
		this.skeleton.onInit();
		this.getSprite("body").setBrush("bust_skeleton_body_02");
		this.setDirty(true);
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.SkeletonPriest);
		b.TargetAttractionMult = 3.0;
		// b.IsAffectedByNight = false;			// Now handled by racial effect
		// b.IsAffectedByInjuries = false;		// Now handled by racial effect
		// b.IsImmuneToBleeding = true;			// Now handled by racial effect
		// b.IsImmuneToPoison = true;			// Now handled by racial effect
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.Skills.add(this.new("scripts/skills/actives/horror_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/miasma_skill"));

		// Reforged
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_inspiring_presence", function(o) {
			o.m.IsForceEnabled = true;
		}));
	}
});
