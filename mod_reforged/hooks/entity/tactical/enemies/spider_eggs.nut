::mods_hookExactClass("entity/tactical/enemies/spider_eggs", function(o) {
	o.onInit = function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SpiderEggs);
		b.IsImmuneToKnockBackAndGrab = true;
		b.IsImmuneToStun = true;
		b.IsImmuneToRoot = true;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsAffectedByNight = false;
		b.IsMovable = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToDisarm = true;
		b.TargetAttractionMult = 1.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		local flip = this.Math.rand(0, 1) == 1;
		local body = this.addSprite("body");
		body.setBrush("nest_01");
		body.setHorizontalFlipping(flip);
		this.addDefaultStatusSprites();
		this.m.Skills.add(this.new("scripts/skills/racial/skeleton_racial"));
		this.m.Skills.update();

		//Reforged
		this.m.BaseProperties.IsAffectedByReach = false;
		this.getSkills().update()
	}
});
