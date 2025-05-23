::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/unhold_frost", function(q) {
	q.onInit = @() function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.UnholdFrost);
		// b.DamageTotalMult += 0.15;
		// b.IsImmuneToDisarm = true;		// Now handled by racial effect
		// b.IsImmuneToRotation = true;		// Now handled by racial effect

		// if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 90)
		// {
		// 	b.DamageTotalMult += 0.1;
		// }

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_unhold_body_01";
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_unhold_body_01");
		body.varySaturation(0.1);
		body.varyColor(0.04, 0.04, 0.04);
		local injury_body = this.addSprite("injury");
		injury_body.Visible = false;
		injury_body.setBrush("bust_unhold_01_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("bust_unhold_head_01");
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		this.addSprite("helmet");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(-10, 16));
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_killing_frenzy"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_battering_ram"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_stalwart"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(::new("scripts/skills/racial/unhold_racial"));
		this.m.Skills.add(::new("scripts/skills/actives/sweep_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/sweep_zoc_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/fling_back_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/unstoppable_charge_skill"));

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastHuge + 1;
		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rattle"));
		this.m.Skills.add(::Reforged.new("scripts/skills/perks/perk_rf_dismantle", function(o) {
			o.m.RequiredDamageType = null;
			o.m.RequiredWeaponType = null;
		}));
		this.m.Skills.add(::Reforged.new("scripts/skills/perks/perk_rf_formidable_approach"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_menacing"));
	}
});
