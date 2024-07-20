::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/goblin_shaman", function(q) {
	q.onInit = @() function()
	{
		this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.GoblinShaman);
		b.Vision = 8;
		b.TargetAttractionMult = 2.0;
		b.IsAffectedByNight = false;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("bust_goblin_02_head_01");
		this.addDefaultStatusSprites();
		this.m.Skills.add(this.new("scripts/skills/racial/goblin_shaman_racial"));
		this.m.Skills.add(this.new("scripts/skills/actives/root_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/insects_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/grant_night_vision_skill"));
	}
});
