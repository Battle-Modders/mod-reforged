// TODO: Needs to be improved
this.ai_rf_cover_ally <- ::inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		TargetEnemy = null,
		TargetAlly = null,
		PossibleSkills = [
			"actives.rf_cover_ally"
		],
		Skill = null,
		Target = null
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.RF_CoverAlly;
		this.m.Order = ::Const.AI.Behavior.Order.RF_CoverAlly;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.TargetTile = null;
		this.m.TargetEnemy = null;
		this.m.TargetAlly = null;		
		this.m.Skill = null;

		if (_entity.getActionPoints() < ::Const.Movement.AutoEndTurnBelowAP)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == ::Const.MoraleState.Fleeing)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (!_entity.isEngagedInMelee())
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

		local score = this.getProperties().BehaviorMult[this.m.ID];

		score = score * this.getFatigueScoreMult(this.m.Skill);
		local myTile = _entity.getTile();
		
		local allies = this.getAgent().getKnownAllies();

		local potentialTargets = [];

		foreach (ally in allies)
		{
			if (ally.getID() == _entity.getID())
			{
				continue;
			}
			
			local scoreInfo = this.getAllyScore(ally);
			if (scoreInfo.Score > 0)
			{
				potentialTargets.push(scoreInfo);
			}			
		}

		if (potentialTargets.len() == 0)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		potentialTargets.sort(this.onSortAlliesByScore);

		this.m.TargetAlly = potentialTargets[0].Ally;

		if (this.m.TargetAlly == null)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = potentialTargets[0].Ally.getTile();		
		this.m.TargetEnemy = potentialTargets[0].Enemy;

		if (this.m.TargetTile == null)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		return ::Const.AI.Behavior.Score.RF_CoverAlly * potentialTargets[0].Score;
	}

	function getAllyScore( _entity )
	{
		local ret = {
			Score = 0,
			Ally = null,
			Enemy = null
		};

		if (!_entity.isEngagedInMelee() || !this.m.Skill.isUsableOn(_entity.getTile()))
		{
			return ret;
		}

		if (_entity.getMoraleState() == ::Const.MoraleState.Fleeing || _entity.getSkills().hasSkill("perk.rf_en_garde") || _entity.getSkills().hasSkill("actives.lunge") || _entity.getSkills().hasSkill("actives.footwork"))
		{
			return ret;
		}

		local myTile = _entity.getTile();

		local weapon = _entity.getMainhandItem();
		if (weapon != null && (weapon.isItemType(::Const.Items.ItemType.RangedWeapon) || weapon.getRangeMax() > 1))
		{
			foreach (skill in _entity.getSkills().getAllSkillsOfType(::Const.SkillType.Active))
			{
				if (!skill.isRanged() && skill.getMaxRange() == 1)
				{
					return ret;
				}
			}

			for (local i = 0; i < 6; i++)
			{
				if (myTile.hasNextTile(i))
				{
					local nextTile = myTile.getNextTile(i);
					if (nextTile.IsEmpty && nextTile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0)
					{
						ret.Score = 100;
						ret.Ally = _entity;

						return ret;
					}
				}
			}
		}

		local attackSkill = _entity.getSkills().getAttackOfOpportunity();
		if (attackSkill == null)
		{
			return ret;
		}

		local entityAgent = _entity.getAIAgent();
		local entityEngageBehavior = entityAgent.getBehavior(::Const.AI.Behavior.ID.EngageMelee);
		if (entityEngageBehavior == null)
		{
			return ret;
		}		
		
		local result = {
			Actor = _entity,
			Targets = [],
			LevelDifference = attackSkill.getMaxLevelDifference()
		};
		local query = ::Tactical.queryActorsInRange(
							myTile,
							entityAgent.getProperties().EngageRangeMin,
							::Math.max(_entity.getIdealRange(), entityAgent.getProperties().EngageRangeMax),
							entityEngageBehavior.onQueryTargetInMeleeRange,
							result
						);

		local targets = result.Targets;

		if (targets.len() == 0)
		{
			return ret;
		}

		local myTile = _entity.getTile();
		local inZonesOfControl = myTile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions());
		local knownAllies = this.getAgent().getKnownAllies();		

		local potentialDestinations = [];

		foreach (target in targets)
		{
			local targetTile = target.getTile();
			local isTargetInEnemyZoneOfControl = targetTile.hasZoneOfControlOtherThan(target.getAlliedFactions());
			local isTargetArmedWithRangedWeapon = !isTargetInEnemyZoneOfControl && this.isRangedUnit(target);
			local isTargetFleeing = target.getMoraleState() == ::Const.MoraleState.Fleeing;
			local engagementsDeclared = (target.getAIAgent().getEngagementsDeclared(_entity) + target.getTile().getZoneOfControlCount(_entity.getFaction()) * 2) * ::Const.AI.Behavior.EngageAlreadyEngagedPenaltyMult * entityAgent.getProperties().EngageTargetAlreadyBeingEngagedMult;
			local letOthersGoScore = 0.0;
			local isSkillUsable = false;
			local lockDownValue = 1.0;
			local tile = null;

			local targetValue = entityAgent.getProperties().IgnoreTargetValueOnEngage ? 0.5 : this.queryTargetValue(_entity, target);

			local potentialTiles = [];

			potentialTiles.push(myTile);

			for (local i = 0; i < 6; i++)
			{
				local isReachable = false;

				if (targetTile.hasNextTile(i))
				{
					local nextTile = targetTile.getNextTile(i);

					if (!nextTile.IsEmpty)
					{
						continue;
					}

					for (local j = 0; j < 6; j++)
					{
						if (nextTile.hasNextTile(j))
						{
							local nextNextTile = nextTile.getNextTile(j);
							if (nextNextTile.isSameTileAs(myTile))							
							{
								isReachable = true;
								break;
							}
						}
					}

					if (isReachable)
					{
						potentialTiles.push(nextTile);
					}
				}
			}

			foreach (tile in potentialTiles)
			{
				if (!tile.isSameTileAs(myTile))
				{
					isSkillUsable = true;
				}

				if (attackSkill == null || !attackSkill.onVerifyTarget(tile, targetTile) || !attackSkill.isInRange(targetTile, tile))
				{
					continue;
				}

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
							lockDownValue = lockDownValue * (::Const.AI.Behavior.EngageMeleeProtectPriorityTargetMult * entityAgent.getProperties().EngageLockDownTargetMult);
						}
					}
				}

				if (entityAgent.getProperties().IgnoreTargetValueOnEngage)
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
				local distance = tile.getDistanceTo(myTile);
				local distanceFromTarget = tile.getDistanceTo(targetTile);
				local zocs = tile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions());
				local tileScore = -distance * ::Const.AI.Behavior.EngageDistancePenaltyMult * (1.0 + ::Math.maxf(0.0, 1.0 - _entity.getActionPointsMax() / 9.0)) * (1.0 / entityAgent.getProperties().EngageFlankingMult) - letOthersGoScore;
				local scoreBonus = 0 - letOthersGoScore;
				local scoreMult = 1.0;

				tileScore = tileScore + targetValue * ::Const.AI.Behavior.EngageTargetValueMult;
				scoreBonus = scoreBonus + targetValue * ::Const.AI.Behavior.EngageTargetValueMult;

				tileScore = tileScore + ::Const.AI.Behavior.EngageWithSkillBonus;

				if (engagementsDeclared != 0)
				{
					tileScore = tileScore - engagementsDeclared;
					scoreBonus = scoreBonus - engagementsDeclared;
				}

				if (!isTargetInEnemyZoneOfControl)
				{
					scoreMult = scoreMult * (::Const.AI.Behavior.EngageLockdownMult * lockDownValue);
					scoreBonus = scoreBonus + ::Const.AI.Behavior.EngageLockOpponentBonus * lockDownValue;
				}

				tileScore = tileScore + levelDifference * ::Const.AI.Behavior.EngageTerrainLevelBonus * entityAgent.getProperties().EngageOnGoodTerrainBonusMult;
				tileScore = tileScore + tile.TVTotal * ::Const.AI.Behavior.EngageTVValueMult * entityAgent.getProperties().EngageOnGoodTerrainBonusMult;
				scoreBonus = scoreBonus + (levelDifference * ::Const.AI.Behavior.EngageTerrainLevelBonus + tile.TVTotal * ::Const.AI.Behavior.EngageTVValueMult) * entityAgent.getProperties().EngageOnGoodTerrainBonusMult;

				if (zocs > 0)
				{
					tileScore = tileScore - zocs * ::Const.AI.Behavior.EngageMultipleOpponentsPenalty * entityAgent.getProperties().EngageTargetMultipleOpponentsMult;
					scoreBonus = scoreBonus - zocs * ::Const.AI.Behavior.EngageMultipleOpponentsPenalty * entityAgent.getProperties().EngageTargetMultipleOpponentsMult;

					if (zocs > 1 && entityAgent.getProperties().EngageTargetMultipleOpponentsMult != 0.0)
					{
						scoreMult = scoreMult * ::Math.pow(1.0 / (::Const.AI.Behavior.EngageTargetMultipleOpponentsMult * entityAgent.getProperties().EngageTargetMultipleOpponentsMult), zocs);
					}
				}

				local spearwallMult = this.querySpearwallValueForTile(_entity, tile);

				if (isSkillUsable && this.m.Skill.isSpearwallRelevant())
				{
					tileScore = tileScore - ::Const.AI.Behavior.EngageSpearwallTargetPenalty * spearwallMult;
					scoreBonus = scoreBonus - ::Const.AI.Behavior.EngageSpearwallTargetPenalty * spearwallMult;
				}

				if (entityAgent.getProperties().EngageEnemiesInLinePreference > 1)
				{
					for( local d = 0; d < 6; d++ )
					{
						if (tile.hasNextTile(d))
						{
							local nextTile = tile.getNextTile(d);

							for( local k = 0; k < entityAgent.getProperties().EngageEnemiesInLinePreference - 1; k++ )
							{
								if (!nextTile.hasNextTile(d))
								{
									break;
								}

								nextTile = nextTile.getNextTile(d);

								if (nextTile.IsOccupiedByActor && nextTile.getEntity().isAttackable() && !nextTile.getEntity().isAlliedWith(_entity))
								{
									local v = this.queryTargetValue(_entity, nextTile.getEntity());
									tileScore = tileScore + v * ::Const.AI.Behavior.EngageLineTargetValueMult * entityAgent.getProperties().TargetPriorityAoEMult;
									scoreBonus = scoreBonus + v * ::Const.AI.Behavior.EngageLineTargetValueMult * entityAgent.getProperties().TargetPriorityAoEMult;
								}
							}
						}
					}
				}

				if (tile.IsBadTerrain)
				{
					local mult = isTargetArmedWithRangedWeapon ? 0.5 : 1.0;
					tileScore = tileScore - ::Const.AI.Behavior.EngageBadTerrainPenalty * entityAgent.getProperties().EngageOnBadTerrainPenaltyMult * mult;
					scoreBonus = scoreBonus - ::Const.AI.Behavior.EngageBadTerrainPenalty * entityAgent.getProperties().EngageOnBadTerrainPenaltyMult * mult;
				}

				if (this.hasNegativeTileEffect(tile, _entity) || tile.Properties.IsMarkedForImpact)
				{
					tileScore = tileScore - ::Const.AI.Behavior.EngageBadTerrainEffectPenalty * entityAgent.getProperties().EngageOnBadTerrainPenaltyMult;
					scoreBonus = scoreBonus - ::Const.AI.Behavior.EngageBadTerrainEffectPenalty * entityAgent.getProperties().EngageOnBadTerrainPenaltyMult;
				}

				if (this.getProperties().OverallFormationMult != 0)
				{
					local allies = this.queryAllyMagnitude(tile, ::Const.AI.Behavior.EngageAllyFormationMaxDistance);
					local formationValue = 0.0;

					if (allies.Allies != 0)
					{
						formationValue = ::Math.pow(allies.Allies * allies.AverageDistanceScore * (allies.Magnetism / allies.Allies) * entityAgent.getProperties().OverallFormationMult * 0.5, entityAgent.getProperties().OverallFormationMult * 0.5) * ::Const.AI.Behavior.EngageFormationBonus;
					}

					tileScore = tileScore + formationValue;
					scoreBonus = scoreBonus + formationValue;
				}

				potentialDestinations.push({
					Tile = tile,
					Actor = target,
					TargetValue = targetValue,
					IsSkillUsable = isSkillUsable,
					IsTargetLocked = isTargetInEnemyZoneOfControl,
					IsTargetLockable = distanceFromTarget == 1,
					TileScore = tileScore,
					ScoreMult = scoreMult,
					Distance = distance
				});
			}
		}

		if (potentialDestinations.len() == 0)
		{
			return ret;
		}

		potentialDestinations.sort(this.onSortByScore);

		local bestTarget;
		local bestTargetDistance = 0;
		local bestIntermediateTile;
		local bestLocked = false;
		local bestLockable = false;
		local bestScoreMult = 1.0;
		local bestComplete = false;
		local actorTargeted;

		if (potentialDestinations[0].IsSkillUsable)
		{
			bestTarget = potentialDestinations[0].Tile;
			bestIntermediateTile = null;
			bestLocked = potentialDestinations[0].IsTargetLocked;
			bestLockable = potentialDestinations[0].IsTargetLockable;
			bestScoreMult = potentialDestinations[0].ScoreMult;
			bestComplete = true;
			actorTargeted = potentialDestinations[0].Actor;
		}
		else
		{
			return ret;
		}

		if (bestTarget != null && bestTarget.ID != myTile.ID)
		{
			if (entityAgent.getProperties().PreferCarefulEngage && entityAgent.getProperties().EngageAgainstSpearwallMult != 0.0 && _entity.isAbleToWait() && this.querySpearwallValueForTile(_entity, bestTarget) != 0.0)
			{
				local allies = this.getAgent().getKnownAllies();

				foreach( ally in allies )
				{
					if (ally.isTurnDone())
					{
						continue;
					}

					if (ally.getMoraleState() == ::Const.MoraleState.Fleeing || ally.getCurrentProperties().IsRooted || ally.getCurrentProperties().IsStunned)
					{
						continue;
					}

					if (ally.getTile().hasZoneOfControlOtherThan(ally.getAlliedFactions()))
					{
						continue;
					}

					if (ally.getTile().getDistanceTo(bestTarget) > 5)
					{
						continue;
					}

					if (ally.isArmedWithShield())
					{
						return ret;
					}
				}
			}

			local score = 1;

			if (!entityAgent.getProperties().IgnoreTargetValueOnEngage && bestComplete && actorTargeted != null)
			{
				score = 1.0 + this.queryTargetValue(_entity, actorTargeted);
			}

			score = score * bestScoreMult * entityAgent.getProperties().BehaviorMult[this.m.ID] * ::Math.minf(2.0, 1.0 / entityAgent.getProperties().OverallDefensivenessMult);

			if (_entity.isArmedWithTwoHandedWeapon() || _entity.getSkills().hasSkill("perk.duelist"))
			{
				score *= 2;
			}

			if (_entity.getHitpointsPct() < 0.5)
			{
				score /= 2;
			}

			if (_entity.getHitpointsPct() < 0.33)
			{
				score /= 2;
			}

			ret.Score = score;
			ret.Ally = _entity;
			ret.Enemy = actorTargeted;
			
			return ret;
		}

		return ret;
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.getAgent().adjustCameraToTarget(this.m.TargetTile);
			this.m.IsFirstExecuted = false;
			return false;
		}

		if (this.m.TargetTile != null && this.m.TargetAlly != null)
		{
			if (::Const.AI.VerboseMode)
			{
				local logString = "* " + _entity.getName() + ": Using " + this.m.Skill.getName() + " to help " + this.m.TargetAlly.getName();
				if (this.m.TargetEnemy != null)
				{
					logString += " to go against " + this.m.TargetEnemy.getName() +  "!";
				}
				else
				{
					logString += " get out of trouble!";
				}

				this.logInfo(logString);
			}

			local dist = _entity.getTile().getDistanceTo(this.m.TargetTile);
			this.m.Skill.use(this.m.TargetTile);

			if (_entity.isAlive() && (!_entity.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer))
			{
				this.getAgent().declareAction();

				if (dist > 1 && this.m.Skill.isShowingProjectile())
				{
					this.getAgent().declareEvaluationDelay(750);
				}
				else if (this.m.Skill.getDelay() != 0)
				{
					this.getAgent().declareEvaluationDelay(this.m.Skill.getDelay());
				}
			}

			this.m.TargetTile = null;
			this.m.TargetEnemy = null;
			this.m.TargetAlly = null;
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

	function onSortAlliesByScore( _a, _b )
	{
		if (_a.Score > _b.Score)
		{
			return -1;
		}
		else if (_a.Score < _b.Score)
		{
			return 1;
		}

		return 0;
	}

});
