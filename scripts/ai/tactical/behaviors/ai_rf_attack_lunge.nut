this.ai_rf_attack_lunge <- ::inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		TargetActor = null,
		PossibleSkills = [
			"actives.lunge"
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.RF_AttackLunge;
		this.m.Order = ::Const.AI.Behavior.Order.RF_AttackLunge;
		// this.m.IsThreaded = true;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.TargetTile = null;
		this.m.TargetActor = null;
		this.m.Skill = null;
		local time = ::Time.getExactTime();

		if (_entity.getActionPoints() < ::Const.Movement.AutoEndTurnBelowAP)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == ::Const.MoraleState.Fleeing)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasVisibleOpponent())
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		local targets = this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange(), this.m.Skill.getMaxLevelDifference());
		if (targets.len() == 0)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		local score = this.getProperties().BehaviorMult[this.m.ID];
		score *= this.getFatigueScoreMult(this.m.Skill);

		local myTile = _entity.getTile();
		local knownAllies = this.getAgent().getKnownAllies();
		local potentialDestinations = [];

		foreach (target in targets)
		{
			local targetTile = target.getTile();

			if (!this.m.Skill.isUsableOn(targetTile)) continue;

			local isTargetInEnemyZoneOfControl = targetTile.hasZoneOfControlOtherThan(target.getAlliedFactions());
			local isTargetArmedWithRangedWeapon = !isTargetInEnemyZoneOfControl && this.isRangedUnit(target);
			local isTargetFleeing = target.getMoraleState() == ::Const.MoraleState.Fleeing;
			local engagementsDeclared = (target.getAIAgent().getEngagementsDeclared(_entity) + target.getTile().getZoneOfControlCount(_entity.getFaction()) * 2) * ::Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult * this.getProperties().EngageTargetAlreadyBeingEngagedMult;
			local letOthersGoScore = 0.0;
			local isSkillUsable = true;
			local lockDownValue = 1.0;
			local tile = this.m.Skill.getDestinationTile(targetTile);
			local targetValue = this.getProperties().IgnoreTargetValueOnEngage ? 0.5 : this.queryTargetValue(_entity, target, this.m.Skill);

			if (targetTile.getZoneOfControlCount(_entity.getFaction()) == 0 && !isTargetArmedWithRangedWeapon && !isTargetFleeing && engagementsDeclared == 0)
			{
				foreach( ally in knownAllies )
				{
					if (ally.getCurrentProperties().TargetAttractionMult <= 1.0 && !this.isRangedUnit(ally))
					{
						continue;
					}

					local d = this.queryActorTurnsNearTarget(target, ally.getTile(), target);

					if (d.Turns <= 1.0)
					{
						lockDownValue = lockDownValue * (::Const.AI.Behavior.EngageMeleeProtectPriorityTargetMult * this.getProperties().EngageLockDownTargetMult);
					}
				}
			}

			if (this.getProperties().IgnoreTargetValueOnEngage)
			{
				letOthersGoScore = letOthersGoScore + ::Math.abs(myTile.SquareCoords.Y - targetTile.SquareCoords.Y) * 20.0;
				local myDistanceToTarget = myTile.getDistanceTo(targetTile);
				local targets = this.getAgent().getKnownAllies();

				foreach( ally in targets )
				{
					if (ally.getMoraleState() == ::Const.MoraleState.Fleeing || ally.getCurrentProperties().RangedSkill > ally.getCurrentProperties().MeleeSkill || ally.getTile().hasZoneOfControlOtherThan(ally.getAlliedFactions()))
					{
						continue;
					}

					if (ally.getTile().getDistanceTo(targetTile) < myDistanceToTarget)
					{
						letOthersGoScore = letOthersGoScore + 2.0;
					}
				}
			}
			else
			{
				local myDistanceToTarget = myTile.getDistanceTo(targetTile);
				local targets = this.getAgent().getKnownAllies();

				foreach( ally in targets )
				{
					if (ally.getMoraleState() == ::Const.MoraleState.Fleeing || ally.getCurrentProperties().RangedSkill > ally.getCurrentProperties().MeleeSkill || ally.getTile().hasZoneOfControlOtherThan(ally.getAlliedFactions()))
					{
						continue;
					}

					if (ally.getTile().getDistanceTo(targetTile) < myDistanceToTarget)
					{
						letOthersGoScore = letOthersGoScore + 0.5;
					}
				}
			}

			local levelDifference = tile.Level - targetTile.Level;
			local distanceFromTarget = tile.getDistanceTo(targetTile);
			local zocs = tile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions());
			local tileScore = -distanceFromTarget * ::Const.AI.Behavior.EngageDistancePenaltyMult * (1.0 + ::Math.maxf(0.0, 1.0 - _entity.getActionPointsMax() / 9.0)) * (1.0 / this.getProperties().EngageFlankingMult) - letOthersGoScore;
			local scoreMult = 1.0;

			tileScore = tileScore + targetValue * ::Const.AI.Behavior.EngageTargetValueMult;

			tileScore = tileScore + ::Const.AI.Behavior.EngageWithSkillBonus;

			if (engagementsDeclared != 0)
			{
				tileScore = tileScore - engagementsDeclared;
			}

			if (!isTargetInEnemyZoneOfControl)
			{
				scoreMult = scoreMult * (::Const.AI.Behavior.EngageLockdownMult * lockDownValue);
			}

			tileScore = tileScore + levelDifference * ::Const.AI.Behavior.EngageTerrainLevelBonus * this.getProperties().EngageOnGoodTerrainBonusMult;
			tileScore = tileScore + tile.TVTotal * ::Const.AI.Behavior.EngageTVValueMult * this.getProperties().EngageOnGoodTerrainBonusMult;

			if (zocs > 0)
			{
				tileScore = tileScore - zocs * ::Const.AI.Behavior.EngageMultipleOpponentsPenalty * this.getProperties().EngageTargetMultipleOpponentsMult;

				if (zocs > 1 && this.getProperties().EngageTargetMultipleOpponentsMult != 0.0)
				{
					scoreMult = scoreMult * ::Math.pow(1.0 / (::Const.AI.Behavior.EngageTargetMultipleOpponentsMult * this.getProperties().EngageTargetMultipleOpponentsMult), zocs);
				}
			}

			local spearwallMult = this.querySpearwallValueForTile(_entity, tile);

			if (isSkillUsable && this.m.Skill.isSpearwallRelevant())
			{
				tileScore = tileScore - ::Const.AI.Behavior.EngageSpearwallTargetPenalty * spearwallMult;
			}

			if (this.getProperties().EngageEnemiesInLinePreference > 1)
			{
				for( local d = 0; d < 6; d++ )
				{
					if (tile.hasNextTile(d))
					{
						local nextTile = tile.getNextTile(d);

						for( local k = 0; k < this.getProperties().EngageEnemiesInLinePreference - 1; k++ )
						{
							if (!nextTile.hasNextTile(d))
							{
								break;
							}

							nextTile = nextTile.getNextTile(d);

							if (nextTile.IsOccupiedByActor && nextTile.getEntity().isAttackable() && !nextTile.getEntity().isAlliedWith(_entity))
							{
								local v = this.queryTargetValue(_entity, nextTile.getEntity());
								tileScore = tileScore + v * ::Const.AI.Behavior.EngageLineTargetValueMult * this.getProperties().TargetPriorityAoEMult;
							}
						}
					}
				}
			}

			if (tile.IsBadTerrain)
			{
				local mult = isTargetArmedWithRangedWeapon ? 0.5 : 1.0;
				tileScore = tileScore - ::Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult * mult;
			}

			if (this.hasNegativeTileEffect(tile, _entity) || tile.Properties.IsMarkedForImpact)
			{
				tileScore = tileScore - ::Const.AI.Behavior.EngageBadTerrainEffectPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
			}

			if (this.getProperties().OverallFormationMult != 0)
			{
				local allies = this.queryAllyMagnitude(tile, ::Const.AI.Behavior.EngageAllyFormationMaxDistance);
				local formationValue = 0.0;

				if (allies.Allies != 0)
				{
					formationValue = ::Math.pow(allies.Allies * allies.AverageDistanceScore * (allies.Magnetism / allies.Allies) * this.getProperties().OverallFormationMult * 0.5, this.getProperties().OverallFormationMult * 0.5) * ::Const.AI.Behavior.EngageFormationBonus;
				}

				tileScore = tileScore + formationValue;
			}

			potentialDestinations.push({
				Tile = tile,
				Actor = target,
				TargetValue = targetValue,
				TileScore = tileScore,
				ScoreMult = scoreMult
			});
		}

		if (potentialDestinations.len() == 0)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		potentialDestinations.sort(this.onSortByScore);

		if (::Const.AI.VerboseMode)
		{
			foreach (dest in potentialDestinations)
			{
				this.logInfo("* Possible target : " + dest.Actor.getName() +
							 " at distance:" + dest.Actor.getTile().getDistanceTo(myTile) +
							 ". TargetValue is: " + dest.TargetValue +
							 ", TileScore is: " + dest.TileScore);
			}
		}

		local bestTarget = potentialDestinations[0].Actor.getTile();
		local bestScoreMult = potentialDestinations[0].ScoreMult;
		local actorTargeted = potentialDestinations[0].Actor;

		if (bestTarget != null && bestTarget.ID != myTile.ID)
		{
			if (this.m.Skill.isSpearwallRelevant() && this.getProperties().PreferCarefulEngage && this.getProperties().EngageAgainstSpearwallMult != 0.0 && _entity.isAbleToWait() && this.querySpearwallValueForTile(_entity, bestTarget) != 0.0)
			{
				local allies = this.getAgent().getKnownAllies();

				foreach( ally in allies )
				{
					if (ally.isTurnDone() || ally.getMoraleState() == ::Const.MoraleState.Fleeing || ally.getCurrentProperties().IsRooted || ally.getCurrentProperties().IsStunned || ally.getTile().hasZoneOfControlOtherThan(ally.getAlliedFactions()) || ally.getTile().getDistanceTo(bestTarget) > 5)
					{
						continue;
					}

					if (ally.isArmedWithShield())
					{
						return ::Const.AI.Behavior.Score.Zero;
					}
				}
			}

			this.m.TargetTile = bestTarget;
			this.m.TargetActor = actorTargeted;

			if (!this.getProperties().IgnoreTargetValueOnEngage && actorTargeted != null)
			{
				score = score * (1.0 + this.queryTargetValue(_entity, actorTargeted, this.m.Skill));
			}

			score = score * bestScoreMult;

			return ::Const.AI.Behavior.Score.RF_AttackLunge * score * this.getProperties().BehaviorMult[this.m.ID] * ::Math.minf(2.0, 1.0 / this.getProperties().OverallDefensivenessMult);
		}

		return ::Const.AI.Behavior.Score.Zero;
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.getAgent().adjustCameraToTarget(this.m.TargetTile);
			this.m.IsFirstExecuted = false;
			return false;
		}

		if (this.m.TargetTile != null && this.m.TargetTile.IsOccupiedByActor)
		{
			if (::Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Using " + this.m.Skill.getName() + " against " + this.m.TargetActor.getName() + "!");
			}

			this.m.Skill.use(this.m.TargetTile);

			if (_entity.isAlive() && (!_entity.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer))
			{
				this.getAgent().declareAction();
				this.getAgent().declareEvaluationDelay(this.m.Skill.getDelay());
			}

			this.m.TargetTile = null;
			this.m.TargetActor = null;
		}

		return true;
	}

	function onSortByScore( _a, _b )
	{
		if (_a.TileScore > _b.TileScore)
		{
			return -1;
		}
		else if (_a.TileScore < _b.TileScore)
		{
			return 1;
		}

		return 0;
	}

});

