::mods_hookExactClass("entity/tactical/enemies/unhold_bog", function(o) {
	o.onInit = function()
	{
	    this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.UnholdBog);
		b.IsImmuneToDisarm = true;
		b.IsImmuneToRotation = true;

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 90)
		// {
		// 	b.DamageTotalMult += 0.1;
		// }

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_unhold_body_03";
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_unhold_body_03");
		body.varySaturation(0.1);
		body.varyColor(0.09, 0.09, 0.09);
		local injury_body = this.addSprite("injury");
		injury_body.Visible = false;
		injury_body.setBrush("bust_unhold_03_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("bust_unhold_head_03");
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		this.addSprite("helmet");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(-10, 16));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battering_ram"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/racial/unhold_racial"));
		this.m.Skills.add(this.new("scripts/skills/actives/sweep_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/sweep_zoc_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/fling_back_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/unstoppable_charge_skill"));

		// Reforged
		this.m.BaseProperties.Reach = 5;
		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.BaseProperties.MeleeSkill += 10;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_internal_hemorrhage"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_survival_instinct"));
			this.m.Skills.add(::MSU.new("scripts/skills/effects/return_favor_effect", function(o) {
				o.onTurnStart = function() {}; // don't remove on turn start i.e. make it permanent
			}));
		}

		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_rattle"));
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_rf_dismantle", function(o) {
			o.m.IsForceEnabled = true;
		}));
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_rf_formidable_approach"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_menacing"));
	}
});
