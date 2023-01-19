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
		local allies = ::Tactical.Entities.getInstancesOfFaction(_entity.getFaction());
		local enemies = ::Tactical.Entities.getHostileActors(_entity.getFaction());
		local useScore = 0.0;
		local numTargets = 0;

		foreach( ally in allies )
		{
			if (ally.getTile().getDistanceTo(myTile) > 4 || !ally.hasZoneOfControl() || ally.getSkills().hasSkill("effects.rf_onslaught"))
			{
				continue;
			}
			
			local bestTarget = this.queryBestMeleeTarget(ally, null, enemies).Target;

			if (bestTarget == null)
			{
				continue;
			}

			local allyAttack = ally.getSkills().getAttackOfOpportunity();
			if (!allyAttack.verifyTargetAndRange(bestTarget.getTile(), ally.getTile()))
			{
				continue;
			}

			local hitChance = allyAttack.getHitchance(bestTarget);
			if (hitChance < 20 || hitChance > 85)
			{
				continue;
			}

			numTargets++;
			useScore = useScore + hitChance - 40;
		}

		if (numTargets < 5)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		score = score * (useScore * 0.01);
		return ::Const.AI.Behavior.Score.RF_PushForward * score;
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
