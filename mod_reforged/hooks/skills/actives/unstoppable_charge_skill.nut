::Reforged.HooksMod.hook("scripts/skills/actives/unstoppable_charge_skill", function(q) {
	q.m.BasePoiseDamage <- 150;

	q.create = @(__original) function()
	{
		__original();
		this.m.IsDamagingPoise = true;		// Just for the tooltip
		this.m.IsStunningFromPoise = true;	// Just for the tooltip
	}

	// This is just so that the tooltip will display the correct poise damage
	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);
		if (_skill == this)
		{
			_properties.PoiseDamage = this.m.PoiseDamageOverwrite;
		}
	}

	// Full rewrite as too many things of the original changed
	q.applyEffectToTarget = @() function( _user, _target, _targetTile )
	{
		if (_target.isNonCombatant())
		{
			return;
		}

		if (::Math.rand(1, 2) == 1)		// Maybe stun, stagger otherwise
		{
			local targetPoiseSkill = _target.getSkills().getSkillByID("effects.poise");
			local inflictedPoiseDamage = this.m.BasePoiseDamage * _user.getCurrentProperties().PoiseDamageMult;
			local turnsStunned = targetPoiseSkill.onPoiseDamageReceived(_user, this, inflictedPoiseDamage);
			if (turnsStunned == 0)
			{
				_target.getSkills().add(::new("scripts/skills/effects/staggered_effect"));

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " has staggered " + ::Const.UI.getColorizedEntityName(_target) + " for 1 turn");
				}
			}
		}
		else	// Always Stagger, maybe knock back
		{
			_target.getSkills().add(::new("scripts/skills/effects/staggered_effect"));
			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " has staggered " + ::Const.UI.getColorizedEntityName(_target) + " for 1 turn");
			}

			local knockToTile = this.findTileToKnockBackTo(_user.getTile(), _targetTile);
			if (knockToTile == null) return;

			this.m.TilesUsed.push(knockToTile.ID);
			if (!_user.isHiddenToPlayer() && (_targetTile.IsVisibleForPlayer || knockToTile.IsVisibleForPlayer))
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " has knocked back " + ::Const.UI.getColorizedEntityName(_target));
			}

			// Interrupt some target abilities
			local skills = _target.getSkills();
			skills.removeByID("effects.shieldwall");
			skills.removeByID("effects.spearwall");
			skills.removeByID("effects.riposte");
			_target.setCurrentMovementType(::Const.Tactical.MovementType.Involuntary);

			// Potential Falldamage
			local damage = ::Math.max(0, ::Math.abs(knockToTile.Level - _targetTile.Level) - 1) * ::Const.Combat.FallingDamage;
			if (damage == 0)
			{
				::Tactical.getNavigator().teleport(_target, knockToTile, null, null, true);
			}
			else
			{
				local p = this.getContainer().getActor().getCurrentProperties();
				local tag = {
					Attacker = _user,
					Skill = this,
					HitInfo = clone ::Const.Tactical.HitInfo
				};
				tag.HitInfo.DamageRegular = damage;
				tag.HitInfo.DamageDirect = 1.0;
				tag.HitInfo.BodyPart = ::Const.BodyPart.Body;
				tag.HitInfo.BodyDamageMult = 1.0;
				tag.HitInfo.FatalityChanceMult = 1.0;
				::Tactical.getNavigator().teleport(_target, knockToTile, this.onKnockedDown, tag, true);
			}
		}
	}
});
