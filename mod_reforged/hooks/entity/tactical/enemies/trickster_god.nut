::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/trickster_god", function(q) {
	q.onInit = @() function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.TricksterGod);
		b.IsImmuneToDisarm = true;
		b.IsImmuneToRoot = true;
		b.IsImmuneToStun = true;
		b.IsImmuneToPoison = true;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.ImmobileMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_trickster_god_body_01");
		local injury_body = this.addSprite("injury");
		injury_body.Visible = false;
		injury_body.setBrush("bust_trickster_god_01_injured");
		local head = this.addSprite("head");
		head.setBrush("bust_trickster_god_head_01");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(-10, 16));
		this.setSpriteOffset("status_stunned", this.createVec(-32, 30));
		this.setSpriteOffset("arrow", this.createVec(0, 10));
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_stalwart"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(::new("scripts/skills/racial/trickster_god_racial"));
		this.m.Skills.add(::new("scripts/skills/actives/teleport_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/gore_skill"));

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastEnormous;
		this.m.Skills.add(::new("scripts/skills/actives/rf_gore_zoc_skill"));
		this.m.Skills.add(::Reforged.new("scripts/skills/perks/perk_rf_dent_armor", function(o) {
			o.m.RequiredDamageType = null;
		}));
		this.m.Skills.add(::Reforged.new("scripts/skills/effects/return_favor_effect", function(o) {
			o.onTurnStart = function() {}; // don't remove on turn start i.e. make it permanent
		}));
	}

	q.assignRandomEquipment = @(__original) function()
	{
		__original();

		// any skills that should be added based on equipment
	}
});
