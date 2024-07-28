this.ai_rf_kata_step <- ::inherit("scripts/ai/tactical/behavior", {
	m = {
		TargetTile = null,
		Reason = "", // Printed if VerboseMode is true
		MaxPathLength = 3,
		PossibleSkills = [
			"actives.rf_kata_step",
			"actives.rf_move_under_cover",
			"actives.footwork",
			"actives.rf_gain_ground"
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.RF_KataStep;
		this.m.Order = ::Const.AI.Behavior.Order.RF_KataStep;
		this.m.IsThreaded = true;
		this.behavior.create();
	}

	// Pick the cheapest skill as opposed to vanilla weighted random choice
	function selectSkill( _possibleSkills )
	{
		local ret;
		local apCost = 999;
		local fatCost = 999;
		local skills = this.getAgent().getActor().getSkills();
		foreach (id in _possibleSkills)
		{
			local skill = skills.getSkillByID(id);
			if (skill == null || !skill.isUsable() || !skill.isAffordable())
				continue;

			local ap = skill.getActionPointCost() * 3; // * 3 is similar to how vanilla weighs AP cost
			local fat = skill.getFatigueCost();
			if (ap < apCost && fat < fatCost)
			{
				ret = skill;
				apCost = ap;
				fatCost = fat;
			}
		}

		return ret;
	}

	// Overwrite base behavior function to avoid spamming high fatigue cost skills (e.g. Footwork)
	// as this behavior has a rather high score so we reduce score further based skill fatigue cost
	function getFatigueScoreMult( _skill )
	{
		local fatCost = _skill.getFatigueCost();
		if (fatCost == 0)
			return this.behavior.getFatigueScoreMult(_skill);

		return this.behavior.getFatigueScoreMult(_skill) / fatCost;
	}

	function onEvaluate( _entity )
	{
		this.m.TargetTile = null;
		this.m.Skill = null;
		this.m.Reason = "";
		local time = ::Time.getExactTime();

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

		// Don't use a disengagement skill if not in ZoC. In that case the entity can just use a regular movement action
		if (this.m.Skill.isDisengagement() && _entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		local targets = this.queryTargetsInMeleeRange(this.m.Skill.getMinRange(), this.m.Skill.getMaxRange() + 1, this.m.Skill.getMaxLevelDifference());
		if (targets.len() == 0)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		local score = this.getProperties().BehaviorMult[this.m.ID];
		score *= this.getFatigueScoreMult(this.m.Skill);

		local myTile = _entity.getTile();
		local paths = [
			{
				Tiles = [myTile],
				AlliesEvaluated = [],
				BasePath = null,
				Score = 1.0,
				ScoreMult = 1.25 + (this.m.Skill.getFatigueCost() * 0.01), // Prefer staying in my tile unless there is a good reason to move
				Reason = ""
			}
		];

		local pathLength = 2;
		local aoo = _entity.getSkills().getAttackOfOpportunity();
		if (aoo != null)
		{
			local entityAP = _entity.getActionPoints();
			local entityFat = _entity.getFatigueMax() - _entity.getFatigue();
			local APCostPerStep = this.m.Skill.getActionPointCost() + aoo.getActionPointCost();
			local fatCostPerStep = this.m.Skill.getFatigueCost() + aoo.getFatigueCost();
			while (pathLength < this.m.MaxPathLength && APCostPerStep * pathLength < entityAP && fatCostPerStep * pathLength < entityFat)
			{
				pathLength++;
			}
		}

		paths.extend(this.getPaths(_entity, myTile, null, pathLength));

		if (paths.len() == 1)
		{
			if (::Const.AI.VerboseMode)
				::logInfo("* Nowhere to go with " this.m.Skill.getName());
			return ::Const.AI.Behavior.Score.Zero;
		}

		local engarde = _entity.getSkills().getSkillByID("actives.rf_en_garde_toggle");
		if (engarde != null && engarde.pickSkill() != null)
		{
			paths[0].ScoreMult *= 1.5; // Prefer staying in my tile if I have En Garde available
		}

		local bodyguardSkill = _entity.getSkills().getSkillByID("special.rf_bodyguard");
		local isBodyguard = bodyguardSkill != null && !::MSU.isNull(bodyguardSkill.getVIP()) && bodyguardSkill.getVIP().isAlive() && bodyguardSkill.getVIP().isPlacedOnMap();

		local activeSkills = _entity.getSkills().getAllSkillsOfType(::Const.SkillType.Active);
		local vision = _entity.getCurrentProperties().getVision();
		local enemies = this.getAgent().getKnownOpponents();
		local knownAllies  = this.getAgent().getKnownAllies();

		foreach (pathIdx, path in paths)
		{
			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = ::Time.getExactTime();
			}

			if (::Reforged.Mod.Debug.isEnabled("ai"))
				::logWarning(format("* Evaluating path: %i", pathIdx))

			if (path.BasePath != null)
			{
				path.Score = path.BasePath.Score;
				path.ScoreMult = path.BasePath.ScoreMult;
				path.AlliesEvaluated = clone path.BasePath.AlliesEvaluated;
				path.Reason = path.BasePath.Reason;
				if (::Reforged.Mod.Debug.isEnabled("ai"))
					::logInfo(format("* Copying path score from path %i", paths.find(path.BasePath)));
			}

			local tile = path.Tiles.top();
			if (::Reforged.Mod.Debug.isEnabled("ai"))
			{
				if (tile.isSameTileAs(myTile))
					::logWarning(format("* - Evaluating my own tile"));
				else
					::logWarning(format("* - Evaluating tile: with ID %i in direction: %s from previous tile", tile.ID, path.BasePath == null ? ::Const.Strings.Direction[myTile.getDirectionTo(tile)] : ::Const.Strings.Direction[path.BasePath.Tiles.top().getDirectionTo(tile)]));
			}

			foreach (ally in knownAllies)
			{
				if (path.AlliesEvaluated.find(ally.getID()) != null)
					continue;

				local allyTile = ally.getTile();

				if (isBodyguard && ::MSU.isEqual(bodyguardSkill.getVIP(), ally) && allyTile.getDistanceTo(tile) == 1)
				{
					path.ScoreMult *= 1000; // Prefer a path that keeps you next to the VIP.
					path.AlliesEvaluated.push(ally.getID());
					break;
				}

				if (allyTile.getDistanceTo(tile) > 1 || (ally.getCurrentProperties().TargetAttractionMult <= 1.0 && !this.isRangedUnit(ally)))
					continue;

				path.AlliesEvaluated.push(ally.getID());

				foreach (enemy in enemies)
				{
					if (enemy.Actor.getMoraleState() != ::Const.MoraleState.Fleeing && !enemy.Actor.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0 && !this.isRangedUnit(enemy.Actor) && this.queryActorTurnsNearTarget(enemy.Actor, allyTile, enemy.Actor) <= 1.0)
					{
						// These two operations calculate the average of the old and new ScoreMult
						path.ScoreMult += ::Const.AI.Behavior.EngageMeleeProtectPriorityTargetMult * this.getProperties().EngageLockDownTargetMult;
						path.ScoreMult *= 0.5;
					}
				}
			}

			foreach (skill in activeSkills)
			{
				if (!skill.isAttack() || skill.isRanged())
					continue;

				if (::Reforged.Mod.Debug.isEnabled("ai"))
					::logInfo(format("* Evaluating skill: %s", skill.getName()))

				foreach (target in this.queryTargetsInMeleeRange(skill.getMinRange(), skill.getMaxRange(), skill.getMaxLevelDifference(), tile))
				{
					local targetTile = target.getTile();

					if (::Reforged.Mod.Debug.isEnabled("ai"))
						::logInfo(format("* --- Evaluating target: %s with ID %i in direction %s from that tile", target.getName(), target.getID(), ::Const.Strings.Direction[tile.getDirectionTo(targetTile)]));

					if (!skill.verifyTargetAndRange(targetTile, tile) || !tile.hasLineOfSightTo(targetTile, vision))
					{
						if (::Reforged.Mod.Debug.isEnabled("ai"))
							::logInfo(format("* %s won\'t be usable on target from this tile - Skipping!", skill.getName()));
						continue;
					}

					if (::Reforged.Mod.Debug.isEnabled("ai"))
						::logInfo(format("* Current path score: %f", path.Score))

					local levelDifference = tile.Level - targetTile.Level;
					local zocs = tile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions());
					local targetScore = this.getProperties().IgnoreTargetValueOnEngage ? 0.5 : this.queryTargetValue(_entity, target, skill) * ::Const.AI.Behavior.EngageTargetValueMult;
					local targetScoreMult = 1.0;

					targetScore += levelDifference * ::Const.AI.Behavior.EngageTerrainLevelBonus * this.getProperties().EngageOnGoodTerrainBonusMult;
					targetScore += tile.TVTotal * ::Const.AI.Behavior.EngageTVValueMult * this.getProperties().EngageOnGoodTerrainBonusMult;

					if (zocs > 0)
					{
						targetScore -= zocs * ::Const.AI.Behavior.EngageMultipleOpponentsPenalty * this.getProperties().EngageTargetMultipleOpponentsMult;

						if (zocs > 1 && skill.isAOE() && this.getProperties().EngageTargetMultipleOpponentsMult != 0.0)
						{
							targetScoreMult = ::Math.pow(1.0 / (::Const.AI.Behavior.EngageTargetMultipleOpponentsMult * this.getProperties().EngageTargetMultipleOpponentsMult), zocs);
						}
					}

					local spearwallMult = this.querySpearwallValueForTile(_entity, tile);
					if (!tile.isSameTileAs(myTile) && this.m.Skill.isSpearwallRelevant())
					{
						targetScore -= ::Const.AI.Behavior.EngageSpearwallTargetPenalty * spearwallMult;
					}

					if (skill.isAOE() && this.getProperties().EngageEnemiesInLinePreference > 1)
					{
						for (local d = 0; d < 6; d++)
						{
							if (!tile.hasNextTile(d))
								continue;

							local nextTile = tile.getNextTile(d);

							for (local k = 0; k < this.getProperties().EngageEnemiesInLinePreference - 1; k++)
							{
								if (!nextTile.hasNextTile(d))
									break;

								nextTile = nextTile.getNextTile(d);
								if (!nextTile.IsOccupiedByActor)
									continue;

								local lineEntity = nextTile.getEntity();
								if (lineEntity.isAttackable() && !lineEntity.isAlliedWith(_entity))
									targetScore += this.queryTargetValue(_entity, lineEntity, skill) * ::Const.AI.Behavior.EngageLineTargetValueMult * this.getProperties().TargetPriorityAoEMult;
							}
						}
					}

					if (tile.IsBadTerrain)
					{
						targetScore -= ::Const.AI.Behavior.EngageBadTerrainPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
					}

					if (this.hasNegativeTileEffect(tile, _entity) || tile.Properties.IsMarkedForImpact)
					{
						targetScore -= ::Const.AI.Behavior.EngageBadTerrainEffectPenalty * this.getProperties().EngageOnBadTerrainPenaltyMult;
					}

					if (this.getProperties().OverallFormationMult != 0)
					{
						local allies = this.queryAllyMagnitude(tile, ::Const.AI.Behavior.EngageAllyFormationMaxDistance);
						local formationValue = 0.0;

						if (allies.Allies != 0)
						{
							formationValue = ::Math.pow(allies.Allies * allies.AverageDistanceScore * (allies.Magnetism / allies.Allies) * this.getProperties().OverallFormationMult * 0.5, this.getProperties().OverallFormationMult * 0.5) * ::Const.AI.Behavior.EngageFormationBonus;
						}

						targetScore += formationValue;
					}

					targetScore *= targetScoreMult;

					if (::Const.AI.VerboseMode)
					{
						if (::Reforged.Mod.Debug.isEnabled("ai"))
							::logInfo("* targetScore: " + targetScore);
						if (targetScore > path.Score)
						{
							path.Reason <- skill.getName() + " against " + target.getName() + " in " + tile.getDistanceTo(myTile) + " steps";
						}
					}

					path.Score = ::Math.maxf(path.Score, targetScore);
				}
			}

			if (::Reforged.Mod.Debug.isEnabled("ai"))
				::logInfo(format("* Score: %f, ScoreMult: %f, Total Path Score: %f", path.Score, path.ScoreMult, path.Score * path.ScoreMult))

			path.Score *= path.ScoreMult;
		}

		if (::Reforged.Mod.Debug.isEnabled("ai"))
		{
			::logInfo("SelectedSkill: " + this.m.Skill.getName());
			foreach (i, path in paths)
			{
				local str = "Path " + i + ": ";
				if (path.BasePath != null)
				{
					str += "BasePath : " + paths.find(path.BasePath) + " | ";
				}
				foreach (i, tile in path.Tiles)
				{
					if (tile.isSameTileAs(myTile))
						str += "myTile, ";
					else
						str += ::Const.Strings.Direction[(i == 0 ? myTile : path.Tiles[i - 1]).getDirectionTo(tile)] + ", ";
				}
				::logInfo(str + "Score: " + path.Score);
			}
		}

		paths.sort(@(a, b) a.Score <=> b.Score);
		local bestPath = paths.top();

		if (bestPath.Tiles[0].isSameTileAs(myTile))
		{
			if (::Const.AI.VerboseMode)
				::logInfo("* KataStep: It is best to stay on my tile.");
			return ::Const.AI.Behavior.Score.Zero;
		}

		this.m.Reason = bestPath.Reason;
		this.m.TargetTile = bestPath.Tiles[0];

		return ::Const.AI.Behavior.Score.RF_KataStep * score * bestPath.Score * ::Math.minf(2.0, 1.0 / this.getProperties().OverallDefensivenessMult);
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.getAgent().adjustCameraToTarget(this.m.TargetTile);
			this.m.IsFirstExecuted = false;
			return false;
		}

		if (this.m.TargetTile != null)
		{
			if (::Const.AI.VerboseMode)
			{
				::logInfo("* " + _entity.getName() + ": Using " + this.m.Skill.getName() + " for " + this.m.Reason + "!");
			}

			this.m.Skill.use(this.m.TargetTile);

			if (_entity.isAlive() && (!_entity.isHiddenToPlayer() || this.m.TargetTile.IsVisibleForPlayer))
			{
				this.getAgent().declareEvaluationDelay(750);
				this.getAgent().declareAction();
			}

			this.m.TargetTile = null;
			this.m.Reason = "";
		}

		return true;
	}

	function getPaths( _entity, _originTile, _basePath, _maxLength = 2 )
	{
		local ret = [];

		for (local i = 0; i < 6; i++)
		{
			if (!_originTile.hasNextTile(i))
				continue;

			local nextTile = _originTile.getNextTile(i);

			// Ignore paths whose first step would be cheaper to travel in terms of ActionPoints via regular movement
			if (_basePath == null)
			{
				if (_entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0 && nextTile.IsEmpty && nextTile.Type != ::Const.Tactical.TerrainType.Impassable)
				{
					local navigator = ::Tactical.getNavigator();
					local settings = navigator.createSettings();
					settings.ActionPointCosts = _entity.getActionPointCosts();
					settings.FatigueCosts = _entity.getFatigueCosts();
					settings.FatigueCostFactor = ::Const.Movement.FatigueCostFactor;
					settings.ActionPointCostPerLevel = _entity.getLevelActionPointCost();
					settings.FatigueCostPerLevel = _entity.getLevelFatigueCost();
					settings.Faction = _entity.getFaction();
					settings.HiddenCost = this.getProperties().OverallHideMult >= 1 ? -1 : 0;
					if (navigator.findPath(_originTile, nextTile, settings, 0))
					{
						local costs = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
						if (!costs.IsMissingActionPoints && this.m.Skill.getActionPointCost() >= costs.ActionPointsRequired)
							continue;
					}
				}
			}
			// If we have already evaluated the nextTile as part of this path's base path, don't put it again in the path
			// This ensures that paths are always going forward and never return to a tile
			else if (_basePath.Tiles.find(nextTile) != null)
			{
				continue;
			}

			// If the skill won't be usable on nextTile then ignore it
			if (!this.m.Skill.verifyTargetAndRange(nextTile, _originTile))
				continue;

			local tiles = _basePath == null ? [] : clone _basePath.Tiles;
			tiles.push(nextTile);

			local path = {
				Tiles = tiles,
				AlliesEvaluated = [],
				BasePath = _basePath,
				Score = 1.0,
				ScoreMult = 1.0,
				Reason = ""
			};
			ret.push(path);

			// If you put 0 here then the total path length ends up being _maxLength + 1
			if (_maxLength > 1)
				ret.extend(this.getPaths(_entity, nextTile, path, _maxLength - 1));
		}

		return ret;
	}
});
