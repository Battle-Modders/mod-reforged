::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/sand_golem", function(q) {
	q.onInit = @() function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.SandGolem);
		// b.IsAffectedByNight = false;			// Now handled by racial effect
		// b.IsImmuneToDisarm = true;			// Now handled by racial effect
		// b.IsImmuneToBleeding = true;			// Now handled by racial effect
		// b.IsImmuneToPoison = true;			// Now handled by racial effect
		// b.IsImmuneToStun = true;				// Now handled by racial effect
		// b.IsImmuneToFire = true;				// Now handled by racial effect
		// b.IsImmuneToHeadshots = true;		// Now handled by racial effect
		// b.IsAffectedByInjuries = false;		// Now handled by racial effect
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.Variant = ::Math.rand(1, 2);
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_golem_body_0" + this.m.Variant + "_small");
		body.varySaturation(0.2);
		body.varyColor(0.06, 0.06, 0.06);
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.45;
		this.setSpriteOffset("status_rooted", this.createVec(-4, 7));
		this.m.Skills.add(::new("scripts/skills/racial/golem_racial"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow"));	// Redundant because of IsImmuneToHeadshots
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(::new("scripts/skills/actives/merge_golem_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/throw_golem_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/headbutt_skill"));

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastSmall + 1;
		this.m.Skills.add(::Reforged.new("scripts/skills/perks/perk_rf_concussive_strikes", function(o) {
			o.m.RequiredWeaponType = null;
		}));
	}

	q.getLootForTile = @(__original) function( _killer, _loot )
	{
		local ret = __original(_killer, _loot);

		// We implement our own drop rate for glittering rocks, so we delete any that was spawned by vanilla
		for (local i = ret.len() - 1; i > 0; i--)
		{
			if (ret[i].getID() == "misc.glittering_rock")
			{
				ret.remove(i);
			}
		}

		if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
		{
			if (::Math.rand(1, 100) <= 25)
			{
				ret.push(::new("scripts/items/loot/glittering_rock_item"));
			}
		}

		return ret;
	}
});
