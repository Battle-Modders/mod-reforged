::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/hexe", function(q) {
	q.onInit = @() function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Hexe);
		b.TargetAttractionMult = 3.0;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_hexen_body_0" + ::Math.rand(1, 3));
		body.varySaturation(0.1);
		body.varyColor(0.05, 0.05, 0.05);
		local charm_body = this.addSprite("charm_body");
		charm_body.setBrush("bust_hexen_charmed_body_01");
		charm_body.Visible = false;
		local charm_armor = this.addSprite("charm_armor");
		charm_armor.setBrush("bust_hexen_charmed_dress_0" + ::Math.rand(1, 3));
		charm_armor.Visible = false;
		local head = this.addSprite("head");
		head.setBrush("bust_hexen_head_0" + ::Math.rand(1, 3));
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local charm_head = this.addSprite("charm_head");
		charm_head.setBrush("bust_hexen_charmed_head_0" + ::Math.rand(1, 2));
		charm_head.Visible = false;
		local injury = this.addSprite("injury");
		injury.setBrush("bust_hexen_01_injured");
		local hair = this.addSprite("hair");
		hair.setBrush("bust_hexen_hair_0" + ::Math.rand(1, 4));
		local charm_hair = this.addSprite("charm_hair");
		charm_hair.setBrush("bust_hexen_charmed_hair_0" + ::Math.rand(1, 5));
		charm_hair.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.m.Skills.add(::new("scripts/skills/actives/charm_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/hex_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/fake_drink_night_vision_skill"));

		// Reforged
		b.RangedDefense += 10;
		this.m.BaseProperties.IsAffectedByReach = false;
		this.getSkills().update()
	}

	// switcheroo function to replace loot drops with dummy object
	q.onDeath = @(__original) function( _killer, _skill, _tile, _fatalityType )
	{
		local itemsToChange = [
			"scripts/items/loot/jade_broche_item"
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

		if (_tile != null)
		{
			local n = 1 + (!::Tactical.State.isScenarioMode() && ::Math.rand(1, 100) <= ::World.Assets.getExtraLootChance() ? 1 : 0);

			for (local i = 0; i < n; i++)
			{
				local loot = ::MSU.Class.WeightedContainer([ // new loot drops
					[1.0, "scripts/items/loot/jade_broche_item"],
					[1.3, "scripts/items/loot/signet_ring_item"]
				]).rollChance(70);

				if (loot != null) ::new(loot).drop(_tile);
			}
		}
	}
});
