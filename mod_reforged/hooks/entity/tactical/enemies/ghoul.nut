::mods_hookExactClass("entity/tactical/enemies/ghoul", function(o) {
	o.onInit = function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Ghoul);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_ghoul_body_01");
		body.varySaturation(0.25);
		body.varyColor(0.06, 0.06, 0.06);
		local head = this.addSprite("head");
		head.setBrush("bust_ghoul_head_01");
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		this.m.Head = this.Math.rand(1, 3);
		local injury = this.addSprite("injury");
		injury.setBrush("bust_ghoul_01_injured");
		injury.Visible = false;
		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_body_bloodied_02");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.45;
		this.setSpriteOffset("status_rooted", this.createVec(-4, 7));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/actives/ghoul_claws"));
		this.m.Skills.add(this.new("scripts/skills/actives/gruesome_feast"));
		this.m.Skills.add(this.new("scripts/skills/effects/gruesome_feast_effect"));
		this.m.Skills.add(this.new("scripts/skills/actives/swallow_whole_skill"));

		// Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_deep_cuts"));

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_survival_instinct"));
		}
	}
});
