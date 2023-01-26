::mods_hookExactClass("entity/tactical/enemies/spider", function(o) {
	o.onInit = function()
	{
		this.actor.onInit();
		this.setRenderCallbackEnabled(true);
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Spider);
		b.IsAffectedByNight = false;
		b.IsImmuneToPoison = true;
		b.IsImmuneToDisarm = true;

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 25)
		// {
		// 	b.DamageDirectAdd += 0.05;

		// 	if (this.World.getTime().Days >= 50)
		// 	{
		// 		b.DamageDirectAdd += 0.05;
		// 		b.MeleeDefense += 5;
		// 		b.RangedDefense += 5;
		// 	}
		// }

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.MaxTraversibleLevels = 3;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local legs_back = this.addSprite("legs_back");
		legs_back.setBrush("bust_spider_legs_back");
		local body = this.addSprite("body");
		body.setBrush("bust_spider_body_0" + this.Math.rand(1, 4));

		if (this.Math.rand(0, 100) < 90)
		{
			body.varySaturation(0.3);
		}

		if (this.Math.rand(0, 100) < 90)
		{
			body.varyColor(0.1, 0.1, 0.1);
		}

		if (this.Math.rand(0, 100) < 90)
		{
			body.varyBrightness(0.1);
		}

		local legs_front = this.addSprite("legs_front");
		legs_front.setBrush("bust_spider_legs_front");
		legs_front.Color = body.Color;
		legs_front.Saturation = body.Saturation;
		legs_back.Color = body.Color;
		legs_back.Saturation = body.Saturation;
		local head = this.addSprite("head");
		head.setBrush("bust_spider_head_01");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_spider_01_injured");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(7, 10));
		this.setSpriteOffset("status_stunned", this.createVec(0, -20));
		this.setSpriteOffset("arrow", this.createVec(0, -20));
		this.setSize(this.Math.rand(70, 90) * 0.01);
		this.m.Skills.add(this.new("scripts/skills/actives/spider_bite_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/web_skill"));
		// this.m.Skills.add(this.new("scripts/skills/actives/footwork")); // Replaced by perk
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/racial/spider_racial"));

	    // Reforged
	    this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastSmall;
	    this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_strength_in_numbers"));
		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.BaseProperties.MeleeDefense += 10;
			this.m.BaseProperties.RangedDefense += 10;
			this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
		}
	}
});
