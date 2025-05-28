::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/spider", function(q) {
	q.onInit = @() { function onInit()
	{
		this.actor.onInit();
		this.setRenderCallbackEnabled(true);
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Spider);
		// b.IsAffectedByNight = false;		// Now handled by racial effect
		// b.IsImmuneToPoison = true;		// Now handled by racial effect
		// b.IsImmuneToDisarm = true;		// Now handled by racial effect

		// if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 25)
		// {
		// 	b.DamageDirectAdd += 0.05;

		// 	if (::World.getTime().Days >= 50)
		// 	{
		// 		b.DamageDirectAdd += 0.05;
		// 		b.MeleeDefense += 5;
		// 		b.RangedDefense += 5;
		// 	}
		// }

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.MaxTraversibleLevels = 3;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local legs_back = this.addSprite("legs_back");
		legs_back.setBrush("bust_spider_legs_back");
		local body = this.addSprite("body");
		body.setBrush("bust_spider_body_0" + ::Math.rand(1, 4));

		if (::Math.rand(0, 100) < 90)
		{
			body.varySaturation(0.3);
		}

		if (::Math.rand(0, 100) < 90)
		{
			body.varyColor(0.1, 0.1, 0.1);
		}

		if (::Math.rand(0, 100) < 90)
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
		this.setSize(::Math.rand(70, 90) * 0.01);
		this.m.Skills.add(::new("scripts/skills/actives/spider_bite_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/web_skill"));
		// this.m.Skills.add(::new("scripts/skills/actives/footwork")); // Replaced by perk
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(::new("scripts/skills/racial/spider_racial"));

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastSmall;
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_strength_in_numbers"));
		this.m.Skills.add(::Reforged.new("scripts/skills/perks/perk_rf_between_the_ribs", function(o) {
			o.m.RequiredWeaponType = null;
			o.m.RequiredDamageType = null;
		}));
	}}.onInit;

	q.getLootForTile = @(__original) { function getLootForTile( _killer, _loot )
	{
		__original(_killer, _loot);

		// We implement our own drop rate for webbed valuables, so we delete any that was spawned by vanilla
		for (local i = _loot.len() - 1; i > 0; i--)
		{
			if (_loot[i].getID() == "misc.webbed_valuables")
			{
				_loot.remove(i);
			}
		}

		if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
		{
			if (::Math.rand(1, 100) <= 10)
			{
				_loot.push(::new("scripts/items/loot/webbed_valuables_item"));
			}
		}

		return _loot;
	}}.getLootForTile;
});
