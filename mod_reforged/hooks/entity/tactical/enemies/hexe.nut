::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/hexe", function(q) {
	q.onInit = @() { function onInit()
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
	}}.onInit;

	q.getLootForTile = @(__original) { function getLootForTile( _killer, _loot )
	{
		local ret = __original(_killer, _loot);

		// We implement our own drop rate for jade brooches, so we delete any that was spawned by vanilla
		for (local i = ret.len() - 1; i > 0; i--)
		{
			if (ret[i].getID() == "misc.jade_broche")
			{
				ret.remove(i);
			}
		}

		if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
		{
			local n = 1 + (!::Tactical.State.isScenarioMode() && ::Math.rand(1, 100) <= ::World.Assets.getExtraLootChance() ? 1 : 0);

			for (local i = 0; i < n; i++)
			{
				local loot = ::MSU.Class.WeightedContainer([ // new loot drops
					[1.0, "scripts/items/loot/jade_broche_item"],
					[1.3, "scripts/items/loot/signet_ring_item"]
				]).rollChance(70);

				if (loot != null) ret.push(::new(loot));
			}
		}

		return ret;
	}}.getLootForTile;
});
