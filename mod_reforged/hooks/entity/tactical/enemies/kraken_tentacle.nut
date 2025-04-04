::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/kraken_tentacle", function(q) {
	q.onInit = @() function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.KrakenTentacle);
		b.IsAffectedByNight = false;
		b.IsImmuneToKnockBackAndGrab = true;
		b.IsImmuneToPoison = true;
		b.IsImmuneToHeadshots = true;
		b.IsMovable = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_kraken_tentacle_01");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.68;
		this.setSpriteOffset("status_rooted", this.createVec(5, 25));
		this.setSpriteOffset("arrow", this.createVec(0, 25));
		this.setSpriteOffset("status_stunned", this.createVec(0, 25));
		this.m.Skills.add(::new("scripts/skills/actives/kraken_move_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/kraken_bite_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/kraken_ensnare_skill"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow"));	// Is redundant because of IsImmuneToHeadshots, but we leave it for now to visualize this kind of immunity
		this.m.Skills.add(::new("scripts/skills/perks/perk_underdog"));
		::Tactical.getTemporaryRoster().add(this);

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastLarge;
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
	}
});
