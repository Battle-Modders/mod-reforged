::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/ghost", function(q) {
	q.onInit = @() function()
	{
		this.actor.onInit();
		this.setRenderCallbackEnabled(true);
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Ghost);
		// b.IsImmuneToBleeding = true;				// Now handled by racial effect
		// b.IsImmuneToPoison = true;				// Now handled by racial effect
		// b.IsImmuneToKnockBackAndGrab = true;		// Now handled by racial effect
		// b.IsImmuneToStun = true;					// Now handled by racial effect
		// b.IsImmuneToRoot = true;					// Now handled by racial effect
		// b.IsImmuneToDisarm = true;				// Now handled by racial effect
		// b.IsImmuneToFire = true;					// Now handled by racial effect
		// b.IsIgnoringArmorOnAttack = true;		// Now handled by racial effect
		// b.IsAffectedByNight = false;				// Now handled by racial effect
		// b.IsAffectedByInjuries = false;			// Now handled by racial effect

		// if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 140)
		// {
		// 	b.MeleeDefense += 5;
		// }

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.SameMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.MaxTraversibleLevels = 3;
		this.m.Items.getAppearance().Body = "bust_ghost_01";
		this.addSprite("socket").setBrush("bust_base_undead");
		this.addSprite("fog").setBrush("bust_ghost_fog_02");
		local body = this.addSprite("body");
		body.setBrush("bust_ghost_01");
		body.varySaturation(0.25);
		body.varyColor(0.2, 0.2, 0.2);
		local head = this.addSprite("head");
		head.setBrush("bust_ghost_01");
		head.varySaturation(0.25);
		head.varyColor(0.2, 0.2, 0.2);
		local blur_1 = this.addSprite("blur_1");
		blur_1.setBrush("bust_ghost_01");
		blur_1.varySaturation(0.25);
		blur_1.varyColor(0.2, 0.2, 0.2);
		local blur_2 = this.addSprite("blur_2");
		blur_2.setBrush("bust_ghost_01");
		blur_2.varySaturation(0.25);
		blur_2.varyColor(0.2, 0.2, 0.2);
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("status_rooted", this.createVec(-5, -5));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(::new("scripts/skills/racial/ghost_racial"));
		this.m.Skills.add(::new("scripts/skills/actives/ghastly_touch"));
		this.m.Skills.add(::new("scripts/skills/actives/horrific_scream"));

		// Reforged
		this.m.BaseProperties.IsAffectedByReach = false;
		this.getSkills().update()
	}

	// Vanilla does not utilize its getLoot-framework for geists, so we need to add that here
	q.onDeath = @(__original) function( _killer, _skill, _tile, _fatalityType )
	{
		local tileLoot = this.getLootForTile(_killer, []);
		this.dropLoot(_tile, tileLoot, this.m.IsCorpseFlipped);

		__original(_killer, _skill, _tile, _fatalityType);
	}

	q.getLootForTile = @(__original) function( _killer, _loot )
	{
		__original(_killer, _loot);

		if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
		{
			if (::Math.rand(1, 100) <= 20)
			{
				_loot.push(::new("scripts/items/loot/rf_geist_tear_item"));
			}
		}

		return _loot;
	}
});
