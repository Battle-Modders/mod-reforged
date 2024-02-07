::Reforged.HooksMod.hook("scripts/skills/actives/charge", function(q) {
	q.m.PoiseDamageOverwrite <- 100;

	q.create = @(__original) function()
	{
		__original();
		this.m.IsDamagingPoise = true;
		this.m.IsStunningFromPoise = true;
	}

	q.onAnySkillUsed <- @(__original) function( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);
		if (_skill == this)
		{
			_properties.PoiseDamage = this.m.PoiseDamageOverwrite;
		}
	}

	// Full rewrite as too many things of the original changed
	q.onTeleportDone = @() function( _entity, _tag )
	{
		local myTile = _entity.getTile();
		local potentialVictims = [];
		local dirToTarget = _tag.OldTile.getDirectionTo(myTile);

		for (local i = 0; i != 6; i = ++i)
		{
			if (!myTile.hasNextTile(i)) continue;

			local tile = myTile.getNextTile(i);
			if (!tile.IsOccupiedByActor) continue;

			local actor = tile.getEntity();
			if (actor.isAlliedWith(_entity) || actor.getCurrentProperties().IsStunned) continue;

			potentialVictims.push(actor);
		}

		foreach (actor in potentialVictims)
		{
			if (!actor.onMovementInZoneOfControl(_entity, true)) continue;

			if (actor.onAttackOfOpportunity(_entity, true))
			{
				if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_entity) + " charges and is repelled");
				}

				if (!_entity.isAlive() || _entity.isDying()) return;

				local dir = myTile.getDirectionTo(_tag.OldTile);
				if (myTile.hasNextTile(dir))
				{
					local tile = myTile.getNextTile(dir);

					if (tile.IsEmpty && ::Math.abs(tile.Level - myTile.Level) <= 1 && tile.getDistanceTo(actor.getTile()) > 1)
					{
						_tag.TargetTile = tile;
						::Time.scheduleEvent(::TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
						return;
					}
				}

				for( local i = 0; i != 6; i = ++i )
				{
					if (!myTile.hasNextTile(i)) continue;

					local tile = myTile.getNextTile(i);
					if (tile.IsEmpty && ::Math.abs(tile.Level - myTile.Level) <= 1)
					{
						if (tile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) != 0) continue;

						_tag.TargetTile = tile;
						::Time.scheduleEvent(::TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
						return;
					}
				}

				_tag.TargetTile = _tag.OldTile;
				::Time.scheduleEvent(::TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
				return;
			}
		}

		if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
		{
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_entity) + " charges");
		}

		if (potentialVictims.len() != 0)
		{
			local victim = potentialVictims[::Math.rand(0, potentialVictims.len() - 1)];
			local poiseDamage = 100;

			if (_tag.Skill.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(_tag.Skill.m.SoundOnHit[::Math.rand(0, _tag.Skill.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, victim.getPos());
			}

			if (!victim.isHiddenToPlayer())
			{
				local layers = ::Const.ShakeCharacterLayers[::Const.BodyPart.Body];
				::Tactical.getShaker().shake(victim, myTile, 2);
			}

			local targetPoiseSkill = targetEntity.getSkills().getSkillByID("effects.poise");
			local turnsStunned = targetPoiseSkill.onInstabilityDamageReceived(this.getContainer().getActor(), this, this.getContainer().getActor().getCurrentProperties().getPoiseDamage());
			if (turnsStunned == 0)
			{
				if (!target.getCurrentProperties().IsImmuneToDaze)
				{
					target.getSkills().add(::new("scripts/skills/effects/dazed_effect"));

					if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
					{
						::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " dazes " + ::Const.UI.getColorizedEntityName(_targetTile.getEntity()) + " for 1 turn");
					}
				}
			}
		}
	}
});
