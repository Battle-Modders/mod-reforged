::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/spider_eggs", function(q) {
	q.onInit = @() { function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.SpiderEggs);
		b.IsImmuneToKnockBackAndGrab = true;
		b.IsImmuneToStun = true;
		b.IsImmuneToRoot = true;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsImmuneToHeadshots = true;
		b.IsAffectedByNight = false;
		b.IsMovable = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToDisarm = true;
		b.TargetAttractionMult = 1.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		local flip = ::Math.rand(0, 1) == 1;
		local body = this.addSprite("body");
		body.setBrush("nest_01");
		body.setHorizontalFlipping(flip);
		this.addDefaultStatusSprites();
		// this.m.Skills.add(::new("scripts/skills/racial/skeleton_racial"));	// Probably vanilla mistake to ever give eggs such a weird racial. Now they no longer take reduced damage from fire and piercing attacks
		this.m.Skills.update();

		//Reforged
		this.m.BaseProperties.IsAffectedByReach = false;
		this.getSkills().update()
	}}.onInit;
});
