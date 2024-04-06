::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/spider", function(q) {
	q.onInit = @() function()
	{
		this.actor.onInit();
		this.setRenderCallbackEnabled(true);
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Spider);
		// b.IsAffectedByNight = false;		// Now handled by racial effect
		// b.IsImmuneToPoison = true;		// Now handled by racial effect
		// b.IsImmuneToDisarm = true;		// Now handled by racial effect

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
	}

	// switcheroo function to replace loot drops with dummy object
	q.onDeath = @(__original) function( _killer, _skill, _tile, _fatalityType )
	{
		local itemsToChange = [
			"scripts/items/loot/webbed_valuables_item"
		]
		local new = ::new;
		::new = function(_scriptName)
		{
			local item = new(_scriptName);
			if (itemsToChange.find(_scriptName) != null)
			{
				item.drop <- @(...)null;
			}
			return item;
		}
		__original(_killer, _skill, _tile, _fatalityType);
		::new = new;

		if (_tile != null && this.Math.rand(1, 100) <= 10)
		{
			local loot = this.new("scripts/items/loot/webbed_valuables_item");
			loot.drop(_tile);
		}
	}
});
