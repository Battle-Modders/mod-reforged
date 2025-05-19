this.rf_flaming_arrows_skill <- ::inherit("scripts/skills/actives/aimed_shot", {
	m = {
		TargetTile = null,
		RangeModifier = -1
	},
	function create()
	{
		this.aimed_shot.create();
		this.m.ID = "actives.rf_flaming_arrows";
		this.m.Name = "Flaming Arrow";
		this.m.Description = "An arrow with a flammable load which does additional fire damage and lights the target tile on fire, but is unwieldy to shoot.";
		this.m.Icon = "skills/rf_flaming_arrows_skill.png";
		this.m.IconDisabled = "skills/rf_flaming_arrows_skill_sw.png";
		this.m.Overlay = "rf_flaming_arrows_skill";
		this.m.ProjectileType = ::Const.ProjectileType.FlamingArrow;
		this.m.InjuriesOnBody = ::Const.Injury.BurningAndPiercingBody;
		this.m.InjuriesOnHead = ::Const.Injury.BurningAndPiercingHead;
		this.m.AdditionalAccuracy = 0;
		this.m.AdditionalHitChance = -4;
	}

	function getTooltip()
	{
		local ret = this.getRangedTooltip(this.getDefaultTooltip());

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will trigger a negative [morale check|Concept.MoraleCheck] for the character hit and all adjacent enemies")
		});

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("If a target is hit, will light the tile on fire for " + ::MSU.Text.colorNegative(2) + " [rounds|Concept.Round]")
		});

		local ammo = this.getAmmo();

		if (ammo > 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/ammo.png",
				text = "Has " + ::MSU.Text.colorPositive(ammo) + " arrows left"
			});
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("Needs a non-empty quiver of arrows equipped")
			});
		}

		if (this.getContainer().getActor().isEngagedInMelee())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Cannot be used because this character is [engaged|Concept.ZoneOfControl] in melee"))
			});
		}

		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.aimed_shot.onAfterUpdate(_properties);
		this.m.MaxRange += this.m.RangeModifier;
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		this.aimed_shot.onBeforeTargetHit(_skill, _targetEntity, _hitInfo);

		if (_skill == this)
			this.m.TargetTile = _targetEntity.getTile();
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.aimed_shot.onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);

		if (this.m.TargetTile == null || _skill != this)
		{
			return;
		}

		if (_targetEntity.isAlive() && !_targetEntity.isDying() && _targetEntity.getMoraleState() != ::Const.MoraleState.Ignore)
		{
			_targetEntity.checkMorale(-1, ::Const.Morale.OnHitBaseDifficulty * (1.0 - _targetEntity.getHitpoints() / _targetEntity.getHitpointsMax()));
		}

		for (local i = 0; i < 6; i++)
		{
			if (this.m.TargetTile.hasNextTile(i))
			{
				local nextTile = this.m.TargetTile.getNextTile(i);
				if (nextTile.IsOccupiedByActor)
				{
					local enemy = nextTile.getEntity();
					if (!enemy.isAlliedWith(this.getContainer().getActor()) && enemy.getMoraleState() != ::Const.MoraleState.Ignore)
					{
						enemy.checkMorale(-1, ::Const.Morale.OnHitBaseDifficulty * (1.0 - enemy.getHitpoints() / enemy.getHitpointsMax()));
					}
				}
			}
		}

		::Time.scheduleEvent(::TimeUnit.Real, 50, this.onApply.bindenv(this), {
			Skill = this,
			User = this.getContainer().getActor(),
			TargetTile = this.m.TargetTile
		});
	}

	function onApply( _data )
	{
		local targets = [];
		targets.push(_data.TargetTile);

		local p = {
			Type = "fire",
			Tooltip = "Fire rages here, melting armor and flesh alike",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = false,
			IsByPlayer = _data.User.isPlayerControlled(),
			Timeout = ::Time.getRound() + 2,
			Callback = ::Const.Tactical.Common.onApplyFire,
			function Applicable( _a )
			{
				return true;
			}
		};

		foreach (tile in targets)
		{
			if (tile.Subtype != ::Const.Tactical.TerrainSubtype.Snow && tile.Subtype != ::Const.Tactical.TerrainSubtype.LightSnow && tile.Type != ::Const.Tactical.TerrainType.ShallowWater && tile.Type != ::Const.Tactical.TerrainType.DeepWater)
			{
				if (tile.Properties.Effect != null && tile.Properties.Effect.Type == "fire")
				{
					tile.Properties.Effect.Timeout = ::Time.getRound() + 2;
				}
				else
				{
					if (tile.Properties.Effect != null)
					{
						::Tactical.Entities.removeTileEffect(tile);
					}

					tile.Properties.Effect = clone p;
					local particles = [];

					for (local i = 0; i < ::Const.Tactical.FireParticles.len(); i++)
					{
						particles.push(::Tactical.spawnParticleEffect(true, ::Const.Tactical.FireParticles[i].Brushes, tile, ::Const.Tactical.FireParticles[i].Delay, ::Const.Tactical.FireParticles[i].Quantity, ::Const.Tactical.FireParticles[i].LifeTimeQuantity, ::Const.Tactical.FireParticles[i].SpawnRate, ::Const.Tactical.FireParticles[i].Stages));
					}

					::Tactical.Entities.addTileEffect(tile, tile.Properties.Effect, particles);
					tile.clear(::Const.Tactical.DetailFlag.Scorchmark);
					tile.spawnDetail("impact_decal", ::Const.Tactical.DetailFlag.Scorchmark, false, true);
				}
			}

			if (tile.IsOccupiedByActor)
			{
				::Const.Tactical.Common.onApplyFire(tile, tile.getEntity());
			}
		}

		this.m.TargetTile = null;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.TargetTile = null;
	}
});
