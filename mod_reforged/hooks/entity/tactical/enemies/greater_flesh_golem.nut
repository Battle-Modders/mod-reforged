::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/greater_flesh_golem", function(q) {
	q.onInit = @() function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.GreaterFleshGolem);
		b.IsImmuneToDisarm = true;
		b.IsImmuneToRotation = true;
		b.IsImmuneToStun = true;
		b.IsImmuneToKnockBackAndGrab = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_undead");
		this.addSprite("body");
		this.addSprite("injury");
		this.addSprite("armor");
		this.addSprite("head");
		this.addSprite("helmet");
		local variant = ::Math.rand(1, 3);
		this.setVariant(variant);
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(-10, 16));
		this.setSpriteOffset("status_stunned", this.createVec(0, 10));
		this.setSpriteOffset("arrow", this.createVec(0, 10));
		this.m.Skills.add(::new("scripts/skills/racial/flesh_golem_racial"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(::new("scripts/skills/actives/greater_flesh_golem_attack_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/flurry_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/spike_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/corpse_hurl_skill"));

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastHuge;
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_menacing"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
	}
});
