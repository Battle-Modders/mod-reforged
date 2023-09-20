this.ai_rf_onslaught <- ::inherit("scripts/ai/tactical/behavior", {
	m = {
		PossibleSkills = [
			"actives.rf_onslaught"
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.RF_Onslaught;
		this.m.Order = ::Const.AI.Behavior.Order.RF_Onslaught;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.Skill = null;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < ::Const.Movement.AutoEndTurnBelowAP)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == ::Const.MoraleState.Fleeing)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		score = score * this.getFatigueScoreMult(this.m.Skill);
		local myTile = _entity.getTile();
		local useScore = 0.0;
		local numTargets = 0;

		foreach (ally in ::Tactical.Entities.getInstancesOfFaction(_entity.getFaction()))
		{
			local allyTile = ally.getTile();
			if (allyTile.getDistanceTo(myTile) > 4 || !ally.hasZoneOfControl() || ally.getSkills().hasSkill("effects.rf_onslaught"))
			{
				continue;
			}

			local zocCount = allyTile.getZoneOfControlCountOtherThan(ally.getAlliedFactions());
			if (zocCount < 2)
			{
				continue;
			}

			local allyAttack = ally.getSkills().getAttackOfOpportunity();
			for (local i = 0; i < 6; i++)
			{
				if (!allyTile.hasNextTile(i)) continue;

				local nextTile = allyTile.getNextTile(i);
				if (!nextTile.IsOccupiedByActor) continue;

				local adjacentEntity = nextTile.getEntity();
				if (adjacentEntity.isAlliedWith(ally) || !adjacentEntity.hasZoneOfControl()) continue;

				local allyHitChance = allyAttack.getHitchance(adjacentEntity);
				if (allyHitChance < 20) continue;

				if (allyHitChance > adjacentEntity.getSkills().getAttackOfOpportunity().getHitchance(ally) * 0.7)
				{
					numTargets++;
					useScore += 40 * zocCount;
					break;
				}
			}
		}

		if (numTargets < 3)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		return ::Const.AI.Behavior.Score.RF_Onslaught * score * useScore * 0.01;
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.getAgent().adjustCameraToTarget(_entity.getTile());
			this.m.IsFirstExecuted = false;
			return false;
		}

		this.m.Skill.use(_entity.getTile());

		if (!_entity.isHiddenToPlayer())
		{
			this.getAgent().declareAction();
			this.getAgent().declareEvaluationDelay(1500);
		}

		this.m.Skill = null;
		return true;
	}
});
