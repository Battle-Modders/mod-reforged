// This is primarily a copy of the vanilla ai_raise_undead with some slight modifications
// here and there to adapt it to the use of the ancestral summons skill
this.ai_rf_ancestral_summons <- ::inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		PossibleSkills = [
			"actives.rf_ancestral_summons"
		],
		Skill = null,
		IsTravelling = false
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.RF_AncestralSummons;
		this.m.Order = ::Const.AI.Behavior.Order.RF_AncestralSummons;
		this.m.IsThreaded = true;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		// Function is a generator.
		this.m.Skill = null;
		this.m.TargetTile = null;
		this.m.IsTravelling = false;
		local time = this.Time.getExactTime();
		local scoreMult = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < ::Const.Movement.AutoEndTurnBelowAP)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == ::Const.MoraleState.Fleeing)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getTile().hasZoneOfControlOtherThan(_entity.getAlliedFactions()))
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		scoreMult = scoreMult * this.getFatigueScoreMult(this.m.Skill);
		local myTile = _entity.getTile();
		local potentialDanger = this.getPotentialDanger(true);
		local currentDanger = 0.0;
		yield null;

		foreach( t in potentialDanger )
		{
			local d = this.queryActorTurnsNearTarget(t, myTile, _entity);

			if (d.Turns <= 1.0)
			{
				currentDanger = currentDanger + (1.0 - d.Turns);
			}
		}

		local corpses = this.m.Skill.getBarrows();

		if (corpses.len() == 0)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		local potentialCorpses = [];
		local alliedFactions = _entity.getAlliedFactions();

		foreach (c in corpses)
		{
			if (c.isSpent())
				continue;

			c = c.getTile();

			if (this.getAgent().getIntentions().IsDefendingPosition && !this.m.Skill.isInRange(c))
			{
				continue;
			}

			local score = 1.0;
			local dist = c.getDistanceTo(myTile);

			if (dist > ::Const.AI.Behavior.RaiseUndeadMaxDistance)
			{
				continue;
			}

			if (this.m.Skill.isInRange(c) && !this.m.Skill.onVerifyTarget(myTile, c))
			{
				continue;
			}

			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			// local isWeaponOnGround = false;

			// if (c.IsContainingItems)
			// {
			// 	foreach( item in c.Items )
			// 	{
			// 		if (item.isItemType(::Const.Items.ItemType.MeleeWeapon))
			// 		{
			// 			isWeaponOnGround = true;
			// 			break;
			// 		}
			// 	}
			// }

			// score += c.Properties.get("Corpse").Value * ::Const.AI.Behavior.RaiseUndeadStrengthMult * (isWeaponOnGround ? 1.0 : ::Const.AI.Behavior.RaiseUndeadNoWeaponMult);

			local mag = this.queryOpponentMagnitude(c, ::Const.AI.Behavior.RaiseUndeadMagnitudeMaxRange);
			score += mag.Opponents * (1.0 - mag.AverageDistanceScore) * ::Math.maxf(0.5, 1.0 - mag.AverageEngaged) * ::Const.AI.Behavior.RaiseUndeadOpponentValue;

			if (c.hasZoneOfOccupationOtherThan(alliedFactions))
			{
				if (dist <= 2)
				{
					score += ::Const.AI.Behavior.RaiseUndeadNearEnemyNearMeValue;
				}
				else
				{
					score += ::Const.AI.Behavior.RaiseUndeadNearEnemyValue;
				}

				foreach (tile in ::MSU.Tile.getNeighbors(c))
				{
					if (tile.IsOccupiedByActor && !tile.hasZoneOfOccupationOtherThan(tile.getEntity().getAlliedFactions()))
					{
						if (dist <= 2)
						{
							score += ::Const.AI.Behavior.RaiseUndeadNearFreeEnemyNearMeValue;
						}
						else
						{
							score += ::Const.AI.Behavior.RaiseUndeadNearFreeEnemyValue;
						}

						if (tile.Properties.IsMarkedForImpact || this.hasNegativeTileEffect(tile, tile.getEntity()))
						{
							score += ::Const.AI.Behavior.RaiseUndeadLockIntoNegativeEffect;
						}
					}
				}
			}

			if (currentDanger != 0)
			{
				score -= dist * ::Const.AI.Behavior.RaiseUndeadDistToMeValue;
			}

			potentialCorpses.push({
				Tile = c,
				Distance = dist,
				Score = score
			});
		}

		if (potentialCorpses.len() == 0)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		potentialCorpses.sort(this.onSortByScore);
		local navigator = ::Tactical.getNavigator();
		local bestTarget;
		local bestIntermediateTile;
		local bestCost = -9999;
		local bestTiles = 0;
		local n = 0;
		local maxRange = this.m.Skill.getMaxRange();
		local entityActionPointCosts = _entity.getActionPointCosts();
		local entityFatigueCosts = _entity.getFatigueCosts();

		foreach (t in potentialCorpses)
		{
			n++;

			if (n > ::Const.AI.Behavior.RaiseUndeadMaxAttempts && bestTarget != null)
			{
				break;
			}

			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			local score = 0 + t.Score;
			local tiles = 0;
			local intermediateTile;

			if (!this.m.Skill.isInRange(t.Tile))
			{
				local settings = navigator.createSettings();
				settings.ActionPointCosts = entityActionPointCosts;
				settings.FatigueCosts = entityFatigueCosts;
				settings.FatigueCostFactor = 0.0;
				settings.ActionPointCostPerLevel = _entity.getLevelActionPointCost();
				settings.FatigueCostPerLevel = _entity.getLevelFatigueCost();
				settings.AllowZoneOfControlPassing = false;
				settings.ZoneOfControlCost = ::Const.AI.Behavior.ZoneOfControlAPPenalty;
				settings.AlliedFactions = _entity.getAlliedFactions();
				settings.Faction = _entity.getFaction();

				if (!_entity.getCurrentProperties().IsRooted && navigator.findPath(myTile, t.Tile, settings, maxRange))
				{
					local movementCosts = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());

					if (movementCosts.IsComplete && !this.m.Skill.onVerifyTarget(movementCosts.End, t.Tile))
					{
						continue;
					}

					if (!movementCosts.IsComplete)
					{
						intermediateTile = movementCosts.End;
					}

					if (movementCosts.End.IsBadTerrain)
					{
						score -= ::Const.AI.Behavior.RaiseUndeadMoveToBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
					}

					if (this.getProperties().EngageOnBadTerrainPenaltyMult != 0.0)
					{
						score -= movementCosts.End.TVLevelDisadvantage;
					}

					score -= movementCosts.ActionPointsRequired;
					score += movementCosts.End.Level;
					local inAllyZOC = _entity.getTile().getZoneOfControlCount(_entity.getFaction());
					local danger = 0.0;
					local danger_intermediate = 0.0;
					score += inAllyZOC * ::Const.AI.Behavior.RaiseUndeadAllyZocBonus;

					foreach (opponent in potentialDanger)
					{
						if (this.isAllottedTimeReached(time))
						{
							yield null;
							time = this.Time.getExactTime();
						}

						if (!this.isRangedUnit(opponent))
						{
							local d = this.queryActorTurnsNearTarget(opponent, t.Tile, _entity);
							danger += ::Math.maxf(0.0, 1.0 - d.Turns);

							if (!movementCosts.IsComplete)
							{
								local id = this.queryActorTurnsNearTarget(opponent, movementCosts.End, _entity);
								danger_intermediate = danger_intermediate + ::Math.maxf(0.0, 1.0 - id.Turns);
								d = d.Turns > id.Turns ? id : d;
							}

							if (d.Turns <= 1.0)
							{
								if (d.InZonesOfControl != 0 || opponent.getCurrentProperties().IsRooted)
								{
									score -= ::Const.AI.Behavior.RaiseUndeadLowDangerPenalty;
								}
								else
								{
									score -= ::Const.AI.Behavior.RaiseUndeadHighDangerPenalty;
								}
							}
						}
						else if (!opponent.getTile().hasZoneOfControlOtherThan(opponent.getAlliedFactions()) && opponent.getTile().getDistanceTo(movementCosts.End) <= opponent.getIdealRange())
						{
							local d = movementCosts.End.getZoneOfControlCount(_entity.getFaction()) == 0 ? 0.5 : 1.0;
							danger += d;

							if (movementCosts.End.getZoneOfControlCount(_entity.getFaction()) == 0)
							{
								score -= ::Const.AI.Behavior.RaiseUndeadHighDangerPenalty;
							}
							else
							{
								score -= ::Const.AI.Behavior.RaiseUndeadLowDangerPenalty;
							}
						}

						if (danger >= ::Const.AI.Behavior.RaiseUndeadMaxDanger || danger_intermediate >= ::Const.AI.Behavior.RaiseUndeadMaxDanger)
						{
							break;
						}
					}

					if (danger >= ::Const.AI.Behavior.RaiseUndeadMaxDanger || danger_intermediate >= ::Const.AI.Behavior.RaiseUndeadMaxDanger)
					{
						continue;
					}

					tiles = movementCosts.Tiles;
				}
				else
				{
					continue;
				}
			}
			else
			{
				if (currentDanger >= ::Const.AI.Behavior.RaiseUndeadMaxDanger)
				{
					continue;
				}

				if (!this.m.Skill.onVerifyTarget(myTile, t.Tile))
				{
					continue;
				}

				score += myTile.Level;
			}

			if (score > bestCost)
			{
				bestTarget = t.Tile;
				bestCost = score;
				bestTiles = tiles;
				bestIntermediateTile = intermediateTile;
			}
		}

		if (bestTarget == null)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = bestTarget;
		this.m.IsTravelling = !this.m.Skill.isInRange(this.m.TargetTile);

		if (this.m.IsTravelling && bestIntermediateTile != null && bestIntermediateTile.ID == myTile.ID)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		// scoreMult = scoreMult * (1.0 + bestTarget.Properties.get("Corpse").Value / 25.0);
		scoreMult = scoreMult * ::Math.maxf(0.0, 1.0 - currentDanger / ::Const.AI.Behavior.RaiseUndeadMaxDanger);
		return ::Const.AI.Behavior.Score.RF_AncestralSummons * scoreMult;
	}

	function onBeforeExecute( _entity )
	{
		if (this.m.IsTravelling)
		{
			this.getAgent().getOrders().IsEngaging = true;
			this.getAgent().getOrders().IsDefending = false;
			this.getAgent().getIntentions().IsDefendingPosition = false;
			this.getAgent().getIntentions().IsEngaging = true;
		}
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			if (this.m.IsTravelling)
			{
				local navigator = ::Tactical.getNavigator();
				local settings = navigator.createSettings();
				settings.ActionPointCosts = _entity.getActionPointCosts();
				settings.FatigueCosts = _entity.getFatigueCosts();
				settings.FatigueCostFactor = 0.0;
				settings.ActionPointCostPerLevel = _entity.getLevelActionPointCost();
				settings.FatigueCostPerLevel = _entity.getLevelFatigueCost();
				settings.AllowZoneOfControlPassing = false;
				settings.ZoneOfControlCost = ::Const.AI.Behavior.ZoneOfControlAPPenalty;
				settings.AlliedFactions = _entity.getAlliedFactions();
				settings.Faction = _entity.getFaction();
				navigator.findPath(_entity.getTile(), this.m.TargetTile, settings, this.m.Skill.getMaxRange());

				if (::Const.AI.PathfindingDebugMode)
				{
					navigator.buildVisualisation(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
				}

				local movement = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
				this.getAgent().adjustCameraToDestination(movement.End);

				if (::Const.AI.VerboseMode)
				{
					this.logInfo("* " + _entity.getName() + ": Moving into range to use " + this.m.Skill.getName());
				}

				this.m.IsFirstExecuted = false;
				return false;
			}
			else
			{
				if (this.m.TargetTile.IsVisibleForPlayer && _entity.isHiddenToPlayer())
				{
					_entity.setDiscovered(true);
					_entity.getTile().addVisibilityForFaction(::Const.Faction.Player);
				}

				this.getAgent().adjustCameraToTarget(this.m.TargetTile);
				this.m.IsFirstExecuted = false;
				return false;
			}
		}

		if (this.m.IsTravelling)
		{
			if (!::Tactical.getNavigator().travel(_entity, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue()))
			{
				this.m.TargetTile = null;
				return true;
			}
		}
		else
		{
			if (::Const.AI.VerboseMode)
			{
				this.logInfo("* " + _entity.getName() + ": Using " + this.m.Skill.getName() + "!");
			}

			if (this.m.Skill.use(this.m.TargetTile))
			{
				if (!_entity.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer)
				{
					this.getAgent().declareAction();
					this.getAgent().declareEvaluationDelay();
				}

				this.commandRecentlyRaised(_entity, this.m.TargetTile);
			}

			this.m.Skill = null;
			this.m.TargetTile = null;
			return true;
		}
	}

	function commandRecentlyRaised( _entity, _tile )
	{
		if (!_tile.IsOccupiedByActor)
		{
			return;
		}

		local myTile = _entity.getTile();
		local agent = _tile.getEntity().getAIAgent();

		if (myTile.getDistanceTo(_tile) > 3)
		{
			return;
		}

		if (agent.getBehavior(::Const.AI.Behavior.ID.Protect) != null)
		{
			return;
		}

		local allies = this.getAgent().getKnownAllies();
		local protectors = 0;
		local priorityTargets = 0;

		foreach( a in allies )
		{
			if (a.getAIAgent().getBehavior(::Const.AI.Behavior.ID.Protect) != null)
			{
				protectors++;
			}
			else if (a.getCurrentProperties().TargetAttractionMult > 1.0)
			{
				priorityTargets++;
			}
		}

		if (priorityTargets == 0)
		{
			return;
		}

		if (protectors < ::Math.max(1, allies.len() * 0.1) || priorityTargets == 1 && allies.len() <= 2)
		{
			agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_protect"));
		}
	}

	function onSortByScore( _a, _b )
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

