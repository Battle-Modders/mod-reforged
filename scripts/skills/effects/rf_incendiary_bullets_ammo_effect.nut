this.rf_incendiary_bullets_ammo_effect <- this.inherit("scripts/skills/skill", {
	m = {
		// Public
        DamageMultiplier = 0.8,
		ChanceToSpawnFireOnHit = 100,	// Chance to spawn fire on hit
		ChanceToSpawnFireOnMiss = 0,		// Chance to spawn fire on miss
		Turns = 1,		// Amount of turns that the fire rages or is extended by
	},

	function create()
	{
		this.m.ID = "effects.rf_incendiary_bullets_ammo";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.First;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;		// In its first iteration this effect is very simple and doesn't need its own visible effect for the player to understand where this is coming from
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.isEffectApplied(_skill))
		{
			_properties.RangedDamageMult *= this.m.DamageMultiplier;
		}
	}

	// Currently this function will never apply its effect because by this time the weapon is already unloaded so 'isEffectApplied' returns false and THIS effet is no longer attached to the entity
	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (this.isEffectApplied(_skill))
		{
			// Damage type is changed completely to burning as part of the incendiary bullet effect
			_hitInfo.DamageType = ::Const.Damage.DamageType.Burning;
		}
	}

	// Currently this function will never apply its effect because by this time the weapon is already unloaded so 'isEffectApplied' returns false and THIS effet is no longer attached to the entity
	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.isEffectApplied(_skill))
		{
			if (::Math.rand(1, 100) <= this.m.ChanceToSpawnFireOnHit)
			{
				this.setAflame (_targetEntity.getTile());
			}
		}
	}

	// Currently this function will never apply its effect because by this time the weapon is already unloaded so 'isEffectApplied' returns false and THIS effet is no longer attached to the entity
	function onTargetMissed( _skill, _targetEntity )
	{
		if (this.isEffectApplied(_skill))
		{
			if (::Math.rand(1, 100) <= this.m.ChanceToSpawnFireOnMiss)
			{
				this.setAflame (_targetEntity.getTile());
			}
		}
	}

	function setAflame( _tile )
	{
		// The following code is mostly copy&pasted from how Vanilla does it. We should eventually rework the tile effects
		::Sound.play(this.m.SoundOnHit[::Math.rand(0, this.m.SoundOnHit.len() - 1)], 1.0, _tile.Pos);
		local p = {
			Type = "fire",
			Tooltip = "Fire rages here, melting armor and flesh alike",
			IsPositive = false,
			IsAppliedAtRoundStart = false,
			IsAppliedAtTurnEnd = true,
			IsAppliedOnMovement = false,
			IsAppliedOnEnter = false,
			IsByPlayer = this.getActor().isPlayerControlled(),
			Timeout = ::Time.getRound() + this.m.Turns,
			Callback = ::Const.Tactical.Common.onApplyFire,
			function Applicable( _a )
			{
				return true;
			}
		};

		if (_tile.Subtype != ::Const.Tactical.TerrainSubtype.Snow && _tile.Subtype != ::Const.Tactical.TerrainSubtype.LightSnow && _tile.Type != ::Const.Tactical.TerrainType.ShallowWater && _tile.Type != ::Const.Tactical.TerrainType.DeepWater)
		{
			if (_tile.Properties.Effect != null && _tile.Properties.Effect.Type == "fire")
			{
				_tile.Properties.Effect.Timeout = ::Time.getRound() + this.m.Turns;
			}
			else
			{
				if (_tile.Properties.Effect != null)
				{
					::Tactical.Entities.removeTileEffect(_tile);
				}

				_tile.Properties.Effect = clone p;
				local particles = [];

				for( local i = 0; i < ::Const.Tactical.FireParticles.len(); i = ++i )
				{
					particles.push(::Tactical.spawnParticleEffect(true, ::Const.Tactical.FireParticles[i].Brushes, _tile, ::Const.Tactical.FireParticles[i].Delay, ::Const.Tactical.FireParticles[i].Quantity, ::Const.Tactical.FireParticles[i].LifeTimeQuantity, ::Const.Tactical.FireParticles[i].SpawnRate, ::Const.Tactical.FireParticles[i].Stages));
				}

				::Tactical.Entities.addTileEffect(_tile, _tile.Properties.Effect, particles);
				_tile.clear(::Const.Tactical.DetailFlag.Scorchmark);
				_tile.spawnDetail("impact_decal", ::Const.Tactical.DetailFlag.Scorchmark, false, true);
			}
		}

		if (_tile.IsOccupiedByActor)
		{
			::Const.Tactical.Common.onApplyFire(_tile, _tile.getEntity());
		}
	}

// New Functions
	function isEffectApplied( _skill )
	{
		if (_skill.isAttack() == false) return false;
		if (_skill.isRanged() == false) return false;
		if (_skill.getItem() != this.getItem()) return false;		// The skill used belongs to a different weapon than our ammunition is currently loaded in

		// By design we don't need to check whether the right ammo is loaded. Because otherwise this effect would not exist on this character

		return true;
	}
});
