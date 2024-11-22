this.perk_rf_flaming_arrows <- ::inherit("scripts/skills/skill", {
	m = {
		TargetTile = null
	},
	function create()
	{
		this.m.ID = "perk.rf_flaming_arrows";
		this.m.Name = ::Const.Strings.PerkName.RF_FlamingArrows;
		this.m.Description = ::Const.Strings.PerkDescription.RF_FlamingArrows;
		this.m.Icon = "ui/perks/perk_rf_flaming_arrows.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onUpdate( _properties )
	{
		local aimedShot = this.getContainer().getSkillByID("actives.aimed_shot");
		if (aimedShot != null)
		{
			aimedShot.m.ProjectileType = ::Const.ProjectileType.FlamingArrow;
			aimedShot.m.Icon = "skills/rf_flaming_arrows_skill.png";
			aimedShot.m.IconDisabled = "skills/rf_flaming_arrows_skill_sw.png";
		}
	}

	function onRemoved()
	{
		local aimedShot = this.getContainer().getSkillByID("actives.aimed_shot");
		if (aimedShot != null)
		{
			aimedShot.resetField("ProjectileType");
			aimedShot.resetField("Icon");
			aimedShot.resetField("IconDisabled");
		}
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (_skill.getID() == "actives.aimed_shot")
		{
			_tooltip.push({
				id = 100,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Will trigger a negative [morale check|Concept.MoraleCheck] for the character hit and all adjacent enemies")
			});

			_tooltip.push({
				id = 101,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Will light the landing tile on fire for " + ::MSU.Text.colorNegative(2) + " [rounds|Concept.Round]")
			});
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.TargetTile = null;
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.TargetTile = null;
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (_skill.getID() == "actives.aimed_shot") this.m.TargetTile = _targetEntity.getTile();
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.m.TargetTile == null)
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

					for( local i = 0; i < ::Const.Tactical.FireParticles.len(); i = ++i )
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
				::Const.Tactical.Common.onApplyFire(tile, tile.getEntity(), _data.User);
			}
		}

		this.m.TargetTile = null;
	}
});
