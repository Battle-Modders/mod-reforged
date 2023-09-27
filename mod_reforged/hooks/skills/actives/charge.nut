::Reforged.HooksMod.hook("scripts/skills/actives/charge", function(q) {
	q.m.BasePoiseDamage <- 100;
	q.m.MaxHeightDifference <- 1;

	q.create = @(__original) function()
	{
		__original();
		this.m.IsDamagingPoise = true;		// Just for the tooltip
		this.m.IsStunningFromPoise = true;	// Just for the tooltip
	}

	// This is just so that the tooltip will display the correct poise damage
	q.onAnySkillUsed = @() function( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);
		if (_skill == this)
		{
			_properties.PoiseDamage = this.m.BasePoiseDamage;
		}
	}

	// Full rewrite as too many things of the original changed
	q.onTeleportDone = @() function( _user, _tag )
	{
		local myTile = _user.getTile();
		local potentialVictims = [];
		local dirToTarget = _tag.OldTile.getDirectionTo(myTile);

		// Look for potential targets
		for (local i = 0; i != 6; i++)
		{
			if (!myTile.hasNextTile(i)) continue;

			local tile = myTile.getNextTile(i);
			if (!tile.IsOccupiedByActor) continue;
			if (::Math.abs(tile.Level - myTile.Level) < this.m.MaxHeightDifference) continue;	// This is new. Charges will now ignore enemies that are too high/low

			local actor = myTile.getNextTile(i).getEntity();
			if (actor.isAlliedWith(_user) || actor.getCurrentProperties().IsStunned) continue;

			potentialVictims.push(actor);
		}

		// Potentially repel this attack? Currently only by spearwall
		foreach (actor in potentialVictims)
		{
			if (this.handlePotentialRepel(_tag, _user, actor) == true) return;	// If any of the victims repel this attack it is ended early
		}

		if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
		{
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " charges");
		}

		if (potentialVictims.len() != 0)
		{
			this.applyEffectToTarget(_user, ::MSU.Array.rand(potentialVictims));
		}
	}

// New Functions
	// Returns true if the charge was repelled or failed otherwise; returns false otherwise
	q.handlePotentialRepel <- function( _tag, _myself, _targetEntity )
	{
		if (_targetEntity.onMovementInZoneOfControl(_myself, true) && _targetEntity.onAttackOfOpportunity(_myself, true))
		{
			if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_myself) + " charges and is repelled");
			}

			if (!_myself.isAlive() || _myself.isDying()) return true;

			local dir = myTile.getDirectionTo(_tag.OldTile);
			if (myTile.hasNextTile(dir))
			{
				local tile = myTile.getNextTile(dir);

				if (tile.IsEmpty && ::Math.abs(tile.Level - myTile.Level) <= 1 && tile.getDistanceTo(_targetEntity.getTile()) > 1)
				{
					_tag.TargetTile = tile;
					::Time.scheduleEvent(::TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
					return true;
				}
			}

			for (local i = 0; i != 6; i++)
			{
				if (!myTile.hasNextTile(i)) continue;

				local tile = myTile.getNextTile(i);
				if (tile.IsEmpty && ::Math.abs(tile.Level - myTile.Level) <= 1)
				{
					if (tile.getZoneOfControlCountOtherThan(_myself.getAlliedFactions()) != 0) continue;

					_tag.TargetTile = tile;
					::Time.scheduleEvent(::TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
					return true;
				}
			}

			_tag.TargetTile = _tag.OldTile;
			::Time.scheduleEvent(::TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
			return true;
		}

		return false;
	}

	// Applies the appropriate effect to the target that was chosen. This is similar to the unstoppable_charge_skill function
	q.applyEffectToTarget <- function( _user, _target )
	{
		if (!_target.isHiddenToPlayer())
		{
			// Sound is no longer played if the target is hidden to the player
			if (_tag.Skill.m.SoundOnHit.len() != 0)
			{
				::Sound.play(::MSU.Array.rand(_tag.Skill.m.SoundOnHit), ::Const.Sound.Volume.Skill, _target.getPos());
			}

			local layers = ::Const.ShakeCharacterLayers[::Const.BodyPart.Body];
			::Tactical.getShaker().shake(_target, _user.getTile(), 2);
		}

		// Apply effect to _target
		local targetPoiseSkill = _target.getSkills().getSkillByID("effects.poise");
		local inflictedPoiseDamage = this.m.BasePoiseDamage * _user.getCurrentProperties().PoiseDamageMult;
		local turnsStunned = targetPoiseSkill.onPoiseDamageReceived(_user, _tag.Skill, inflictedPoiseDamage);

		// Apply dazed to the _target if it wasn't stunned - this is new
		if (turnsStunned == 0 && !_target.getCurrentProperties().IsImmuneToDaze)
		{
			_target.getSkills().add(::new("scripts/skills/effects/dazed_effect"));

			if (!_user.isHiddenToPlayer() && !_target.isHiddenToPlayer())
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " dazes " + ::Const.UI.getColorizedEntityName(_target) + " for 1 turn");
			}
		}
	}
});
