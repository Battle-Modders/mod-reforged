::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/ghoul", function(q) {
	q.onInit = @() function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Ghoul);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_ghoul_body_01");
		body.varySaturation(0.25);
		body.varyColor(0.06, 0.06, 0.06);
		local head = this.addSprite("head");
		head.setBrush("bust_ghoul_head_01");
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		this.m.Head = ::Math.rand(1, 3);
		local injury = this.addSprite("injury");
		injury.setBrush("bust_ghoul_01_injured");
		injury.Visible = false;
		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_body_bloodied_02");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.45;
		this.setSpriteOffset("status_rooted", this.createVec(-4, 7));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/actives/ghoul_claws"));
		this.m.Skills.add(::new("scripts/skills/actives/gruesome_feast"));
		this.m.Skills.add(::new("scripts/skills/effects/gruesome_feast_effect"));
		// this.m.Skills.add(::new("scripts/skills/actives/swallow_whole_skill")); // only added during grow function for size 3

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastSmall + 1;
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_deep_cuts"));
	}

	q.grow = @(__original) function( _instant = false )
	{
		local sizeBefore = this.m.Size;

		__original(_instant);

		if (this.m.Size > sizeBefore)
		{
			switch (this.m.Size)
			{
				case 2:
					this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastMedium + 1;
					this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
					break;

				case 3:
					this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastLarge + 1;
					this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_menacing"));
					this.m.Skills.add(::new("scripts/skills/actives/swallow_whole_skill"));
					break;
			}
		}
	}

	q.getLootForTile = @(__original) function( _killer, _loot )
	{
		__original(_killer, _loot);

		// We implement our own drop rate for growth pearls, so we delete any that was spawned by vanilla
		for (local i = _loot.len() - 1; i > 0; i--)
		{
			if (_loot[i].getID() == "misc.growth_pearls")
			{
				_loot.remove(i);
			}
		}

		if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
		{
			local chanceToRoll;
			if (this.m.Size == 1)
			{
				chanceToRoll = 10;
			}
			else if (this.m.Size == 2)
			{
				chanceToRoll = 25;
			}
			else // this.m.Size == 3
			{
				chanceToRoll = 50;
			}

			if (::Math.rand(1, 100) <= chanceToRoll)
			{
				_loot.push(::new("scripts/items/loot/growth_pearls_item"));
			}
		}

		return _loot;
	}
});
