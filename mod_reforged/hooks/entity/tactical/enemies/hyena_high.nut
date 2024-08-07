::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/hyena_high", function(q) {
	q.onInit = @() function()
	{
		this.hyena.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.FrenziedHyena);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		b.DamageTotalMult = 1.25;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		local body = this.getSprite("body");
		body.setBrush("bust_hyena_0" + ::Math.rand(4, 6));
		local head = this.getSprite("head");
		head.setBrush("bust_hyena_0" + ::Math.rand(4, 6) + "_head");
		this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
	}
});
