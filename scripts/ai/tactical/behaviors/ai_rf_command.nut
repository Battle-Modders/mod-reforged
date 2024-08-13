this.ai_rf_command <- ::inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		PossibleSkills = [
			"actives.rf_command"
		],
		Skill = null,
		IsTravelling = false
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.RF_Command;
		this.m.Order = ::Const.AI.Behavior.Order.RF_Command;
		this.m.IsThreaded = true;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		// Function is a generator.
		this.m.Skill = null;
		this.m.TargetTile = null;
		this.m.IsTravelling = false;
		local time = ::Time.getExactTime();

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

		local scoreMult = this.getProperties().BehaviorMult[this.m.ID] * this.getFatigueScoreMult(this.m.Skill);
		local myTile = _entity.getTile();
		local potentialDanger = this.getPotentialDanger(true);
		local currentDanger = 0.0;
		yield null;

		foreach (t in potentialDanger)
		{
			local d = this.queryActorTurnsNearTarget(t, myTile, _entity);

			if (d.Turns <= 1.0)
			{
				currentDanger = currentDanger + (1.0 - d.Turns);
			}
		}

		yield null;
		local allAllies = this.getAgent().getKnownAllies();
		local allEnemies = this.getAgent().getKnownAllies();
		local potentialTargets = [];
		local nextEnemyTurn = 0;
		foreach (i, entity in ::Tactical.TurnSequenceBar.getCurrentEntities())
		{
			if (!entity.isAlliedWith(_entity))
			{
				nextEnemyTurn = i;
				break;
			}
		}

		foreach (a in allAllies)
		{
			// Skip allies who have already started their turn (and waited) or have ended their turn or are already in queue to act before all enemies
			if (a.isTurnStarted() || a.isTurnDone() || ::Tactical.TurnSequenceBar.getTurnsUntilActive(a.getID()) < nextEnemyTurn)
			{
				continue;
			}

			if (a.getCurrentProperties().IsStunned || a.getCurrentProperties().IsRooted || a.getMoraleState() == ::Const.MoraleState.Fleeing)
			{
				continue;
			}

			local score = 0.0;
			local tile = a.getTile();
			local distToMe = myTile.getDistanceTo(tile);
			local zoc = tile.getZoneOfControlCountOtherThan(a.getAlliedFactions()); // vanilla uses getZoneOfOccupationCountOtherThan but I think that's a mistake - Midas

			score = score + zoc * ::Const.AI.Behavior.PossessUndeadZOCMult;
			local mag = this.queryOpponentMagnitude(tile, 3); // Vanilla uses ::Const.AI.Behavior.PossessUndeadMagnitudeMaxRange here
			if (mag.Opponents == 0)
			{
				continue;
			}
			score = score + mag.Opponents * (1.0 - mag.AverageDistanceScore) * ::Math.maxf(0.5, 1.0 - mag.AverageEngaged) * ::Const.AI.Behavior.PossessUndeadOpponentValue;
			score = score * (0.25 + 0.75 * ::Math.maxf(0.33, a.getHitpointsPct()));
			score = score * (0.5 + 0.5 * a.getXPValue() * 0.01);

			if (currentDanger != 0 && distToMe <= 2)
			{
				score = score * ::Const.AI.Behavior.PossessUndeadHelpMeMult;
			}

			if (this.m.Skill.isInRange(tile))
			{
				score = score * ::Const.AI.Behavior.PossessUndeadInRangeMult;
			}

			if (!a.isTurnDone())
			{
				score = score * ::Const.AI.Behavior.PossessUndeadStillToActMult;
			}

			potentialTargets.push({
				Tile = tile,
				Distance = distToMe,
				Score = score
			});
		}

		if (potentialTargets.len() == 0)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		potentialTargets.sort(this.onSortByScore);
		local navigator = ::Tactical.getNavigator();
		local bestTarget;
		local bestIntermediateTile;
		local bestCost = -9000;
		local bestTiles = 0;
		local n = 0;
		local maxRange = this.m.Skill.getMaxRange();
		local entityActionPointCosts = _entity.getActionPointCosts();
		local entityFatigueCosts = _entity.getFatigueCosts();

		foreach (t in potentialTargets)
		{
			n++;

			if (n > ::Const.AI.Behavior.PossessUndeadMaxAttempts && bestTarget != null)
			{
				break;
			}

			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = ::Time.getExactTime();
			}

			local score = t.Score;
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
						score = score - ::Const.AI.Behavior.PossessUndeadMoveToBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
					}

					if (this.getProperties().EngageOnBadTerrainPenaltyMult != 0.0)
					{
						score = score - movementCosts.End.TVLevelDisadvantage;
					}

					score = score - movementCosts.ActionPointsRequired;
					score = score + movementCosts.End.Level;
					local danger = 0.0;
					local danger_intermediate = 0.0;

					foreach (opponent in potentialDanger)
					{
						if (this.isAllottedTimeReached(time))
						{
							yield null;
							time = ::Time.getExactTime();
						}

						local d = this.queryActorTurnsNearTarget(opponent, t.Tile, _entity);
						danger = danger + ::Math.maxf(0.0, 1.0 - d.Turns);

						if (!movementCosts.IsComplete)
						{
							local id = this.queryActorTurnsNearTarget(opponent, movementCosts.End, _entity);
							danger_intermediate = danger_intermediate + ::Math.maxf(0.0, 1.0 - id.Turns);
							d = d.Turns > id.Turns ? id : d;
						}

						if (d.Turns <= 1.0)
						{
							if (d.InZonesOfControl != 0 || opponent.getCurrentProperties().IsStunned || opponent.getCurrentProperties().IsRooted)
							{
								score = score - ::Const.AI.Behavior.PossessUndeadLowDangerPenalty;
							}
							else
							{
								score = score - ::Const.AI.Behavior.PossessUndeadHighDangerPenalty;
							}
						}

						if (danger >= ::Const.AI.Behavior.PossessUndeadMaxDanger || danger_intermediate >= ::Const.AI.Behavior.PossessUndeadMaxDanger)
						{
							break;
						}
					}

					if (danger >= ::Const.AI.Behavior.PossessUndeadMaxDanger || danger_intermediate >= ::Const.AI.Behavior.PossessUndeadMaxDanger)
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
				if (currentDanger >= ::Const.AI.Behavior.PossessUndeadMaxDanger || !this.m.Skill.onVerifyTarget(myTile, t.Tile))
				{
					continue;
				}

				score = score + myTile.Level;
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

		return ::Const.AI.Behavior.Score.RF_Command * scoreMult;
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
			}

			this.m.Skill = null;
			this.m.TargetTile = null;
			return true;
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
