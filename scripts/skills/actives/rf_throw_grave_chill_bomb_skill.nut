this.rf_throw_grave_chill_bomb_skill <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rf_throw_grave_chill_bomb";
		this.m.Name = "Throw Gravedust Pot";
		this.m.Description = "Throw a fragile pot filled with nefarious dust towards a target, where it will shatter and release its contents. The dust will affect any target who inhales it - friend and foe alike.";
		this.m.Icon = "skills/rf_throw_grave_chill_bomb_skill.png";
		this.m.IconDisabled = "skills/rf_throw_grave_chill_bomb_skill_sw.png";
		this.m.Overlay = "rf_throw_grave_chill_bomb_skill";
		this.m.SoundOnUse = [
			"sounds/combat/throw_ball_01.wav",
			"sounds/combat/throw_ball_02.wav",
			"sounds/combat/throw_ball_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/acid_flask_impact_01.wav",
			"sounds/combat/acid_flask_impact_02.wav",
			"sounds/combat/acid_flask_impact_03.wav",
			"sounds/combat/acid_flask_impact_04.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsAttack = true;
		this.m.IsOffensiveToolSkill = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsUsingHitchance = false;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 3;
		this.m.ProjectileType = ::Const.ProjectileType.Bomb2; // Vanilla Daze Bomb projectile
		this.m.ProjectileTimeScale = 1.5;
		this.m.IsProjectileRotated = false;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of " + ::MSU.Text.colorPositive(this.m.MaxRange) + " tiles"
		});
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Inflicts the target with [$ $|Skill+rf_grave_chill_effect]")
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a " + ::MSU.Text.colorDamage("33%") + " chance to hit bystanders at the same or lower height level as well"
		});
		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "Does not affect targets who are undead or immune to poison"
		});
		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return this.skill.onVerifyTarget(_originTile, _targetTile) && _targetTile.Level <= _originTile.Level && this.isActorValid(_targetTile.getEntity());
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInThrowing ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();

		if (this.m.IsShowingProjectile && this.m.ProjectileType != 0)
		{
			local flip = !this.m.IsProjectileRotated && targetEntity.getPos().X > _user.getPos().X;

			if (_user.getTile().getDistanceTo(targetEntity.getTile()) >= ::Const.Combat.SpawnProjectileMinDist)
			{
				::Tactical.spawnProjectileEffect(::Const.ProjectileSprite[this.m.ProjectileType], _user.getTile(), targetEntity.getTile(), 1.0, this.m.ProjectileTimeScale, this.m.IsProjectileRotated, flip);
			}
		}

		_user.getItems().unequip(_user.getItems().getItemAtSlot(::Const.ItemSlot.Offhand));
		::Time.scheduleEvent(::TimeUnit.Real, 200, this.onApply.bindenv(this), {
			Skill = this,
			TargetTile = _targetTile
		});
	}

	function onApply( _data )
	{
		local targetEntity = _data.TargetTile.getEntity();

		if (_data.Skill.m.SoundOnHit.len() != 0)
		{
			::Sound.play(_data.Skill.m.SoundOnHit[this.Math.rand(0, _data.Skill.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, targetEntity.getPos());
		}

		if (this.isActorValid(targetEntity))
			targetEntity.getSkills().add(::new("scripts/skills/effects/rf_grave_chill_effect"));

		this.spawnParticles(_data.TargetTile)

		for (local i = 0; i < 6; i++ )
		{
			if (!_data.TargetTile.hasNextTile(i) || ::Math.rand(1, 100) > 33)
				continue;

			local nextTile = _data.TargetTile.getNextTile(i);
			if (nextTile.Level > _data.TargetTile.Level)
				continue;

			this.spawnParticles(nextTile);

			if (nextTile.IsOccupiedByActor)
			{
				local entity = nextTile.getEntity();
				if (this.isActorValid(entity))
					entity.getSkills().add(::new("scripts/skills/effects/rf_grave_chill_effect"));
			}
		}
	}

	function isActorValid( _actor )
	{
		// For Undead we add check for FatigueEffectMult == 0.0 so we are sure the target is pure undead
		// and not something like a "ghoul" which also have the "undead" flag in vanilla.
		return !_actor.getCurrentProperties().IsImmuneToPoison && !_actor.getFlags().has("undead") && _actor.getCurrentProperties().FatigueEffectMult != 0.0;
	}

	function spawnParticles( _tile )
	{
		for (local i = 0; i < ::Const.Tactical.SmokeParticles.len(); i++ )
		{
			::Tactical.spawnParticleEffect(true, ::Const.Tactical.SmokeParticles[i].Brushes, _tile, ::Const.Tactical.SmokeParticles[i].Delay, 10, 10, 10, ::Const.Tactical.SmokeParticles[i].Stages);
		}
	}
});
