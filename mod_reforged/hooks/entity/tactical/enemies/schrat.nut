::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/schrat", function(q) {
	q.onInit = @() function()
	{
		this.actor.onInit();
		local clouds = ::Tactical.getWeather().createCloudSettings();
		clouds.Type = this.getconsttable().CloudType.Fog;
		clouds.MinClouds = 20;
		clouds.MaxClouds = 20;
		clouds.MinVelocity = 3.0;
		clouds.MaxVelocity = 9.0;
		clouds.MinAlpha = 0.35;
		clouds.MaxAlpha = 0.45;
		clouds.MinScale = 2.0;
		clouds.MaxScale = 3.0;
		::Tactical.getWeather().buildCloudCover(clouds);
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Schrat);
		// b.IsImmuneToBleeding = true;				// Now handled by racial effect
		// b.IsImmuneToPoison = true;				// Now handled by racial effect
		// b.IsImmuneToKnockBackAndGrab = true;		// Now handled by racial effect
		// b.IsImmuneToStun = true;					// Now handled by racial effect
		// b.IsImmuneToRoot = true;					// Now handled by racial effect
		// b.IsIgnoringArmorOnAttack = true;		// Now handled by racial effect
		// b.IsAffectedByNight = false;				// Now handled by racial effect
		// b.IsAffectedByInjuries = false;			// Now handled by racial effect
		// b.IsImmuneToDisarm = true;				// Now handled by racial effect

		// if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 250)
		// {
		// 	b.MeleeSkill += 5;
		// }

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_schrat_body_01");
		body.varySaturation(0.2);
		body.varyColor(0.05, 0.05, 0.05);
		this.m.BloodColor = body.Color;
		local head = this.addSprite("head");
		head.setBrush("bust_schrat_head_0" + ::Math.rand(1, 2));
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_schrat_01_injured");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.54;
		this.setSpriteOffset("status_rooted", this.createVec(0, 0));
		this.setSpriteOffset("status_stunned", this.createVec(0, 10));
		this.setSpriteOffset("arrow", this.createVec(0, 10));
		this.m.Skills.add(::new("scripts/skills/racial/schrat_racial"));
		this.m.Skills.add(::new("scripts/skills/effects/rf_sapling_harvest_effect"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(::new("scripts/skills/actives/grow_shield_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/uproot_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/uproot_zoc_skill"));

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastLarge + 1;
		this.m.Skills.add(::Reforged.new("scripts/skills/perks/perk_rf_dent_armor", function(o) {
			o.m.RequiredDamageType = null;
		}));
	}

	q.getLootForTile = @(__original) function( _killer, _loot )
	{
		local ret = __original(_killer, _loot);

		// We implement our own drop rate for schrat loot, so we delete any that was spawned by vanilla
		local itemsToChange = [
			"misc.ancient_wood",
			"misc.glowing_resin",
			"misc.heart_of_the_forest"
		]
		for (local i = ret.len() - 1; i > 0; i--)
		{
			if (itemsToChange.find(ret[i].getID()) != null)
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
					[2.0, "scripts/items/misc/ancient_wood_item"],
					[2.0, "scripts/items/misc/glowing_resin_item"],
					[1.0, "scripts/items/misc/heart_of_the_forest_item"]
				]).roll();

				ret.push(::new(loot));
			}
		}

		return ret;
	}
});
