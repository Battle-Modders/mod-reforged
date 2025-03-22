::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/direwolf", function(q) {
	q.onInit = @() function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Direwolf);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_direwolf_0" + ::Math.rand(1, 3));

		if (::Math.rand(0, 100) < 90)
		{
			body.varySaturation(0.2);
		}

		if (::Math.rand(0, 100) < 90)
		{
			body.varyColor(0.05, 0.05, 0.05);
		}

		local head = this.addSprite("head");
		head.setBrush("bust_direwolf_0" + ::Math.rand(1, 3) + "_head");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local head_frenzy = this.addSprite("head_frenzy");
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_direwolf_injured");
		local body_blood = this.addSprite("body_blood");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.54;
		this.setSpriteOffset("status_rooted", this.createVec(0, 0));
		this.m.Skills.add(::new("scripts/skills/actives/werewolf_bite"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastMedium;
		this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(::Reforged.new("scripts/skills/perks/perk_rf_from_all_sides", function(o) {
			o.m.RequiredWeaponType = null;
		}));
	}

	q.getLootForTile = @(__original) function( _killer, _loot )
	{
		__original(_killer, _loot);

		// We implement our own drop rate for sabertooths, so we delete any that was spawned by vanilla
		for (local i = _loot.len() - 1; i > 0; i--)
		{
			if (_loot[i].getID() == "misc.sabertooth")
			{
				_loot.remove(i);
			}
		}

		if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
		{
			local chanceToRoll = ::MSU.isKindOf(this, "direwolf_high") ? 30 : 20;

			local n = 1 + (!::Tactical.State.isScenarioMode() && ::Math.rand(1, 100) <= ::World.Assets.getExtraLootChance() ? 1 : 0);

			for (local i = 0; i < n; i++)
			{
				if (::Math.rand(1, 100) <= chanceToRoll)
				{
					_loot.push(::new("scripts/items/loot/sabertooth_item"));
				}
			}
		}

		return _loot;
	}

	// VanillaFix: Vanillas direwolfs sometimes cause scripterrors.
	// We overwrite this temporarily with a fixed version using mostly the copy-pasted vanilla implementation, until vanillas fixes that on their end
	q.getLootForTile = @() function( _killer, _loot )
	{
		if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

			local chanceToRoll = ::MSU.isKindOf(this, "direwolf_high") ? 30 : 20;	// This line new compared to vanilla

			for( local i = 0; i < n; i = ++i )
			{
				if (this.Math.rand(1, 100) <= 50)
				{
					if (this.Const.DLC.Unhold)
					{
						local r = this.Math.rand(1, 100);

						if (r <= 70)
						{
							_loot.push(this.new("scripts/items/misc/werewolf_pelt_item"));
						}
						else
						{
							_loot.push(this.new("scripts/items/misc/adrenaline_gland_item"));
						}
					}
					else
					{
						_loot.push(this.new("scripts/items/misc/werewolf_pelt_item"));
					}
				}
				else if (this.Math.rand(1, 100) <= 33)
				{
					_loot.push(this.new("scripts/items/supplies/strange_meat_item"));
				}

				if (::Math.rand(1, 100) <= chanceToRoll)	// This line is different from vanilla
				{
					_loot.push(this.new("scripts/items/loot/sabertooth_item"));	// This line is different from vanilla, as we fixed their typo
				}
			}
		}

		return _loot;
	}
});
