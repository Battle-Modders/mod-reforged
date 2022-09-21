this.ai_rf_hold_the_line <- ::inherit("scripts/ai/tactical/behavior", {
	m = {
		PossibleSkills = [
			"actives.rf_hold_the_line"
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.RF_HoldTheLine;
		this.m.Order = ::Const.AI.Behavior.Order.RF_HoldTheLine;
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

		local relevantAllies = [];		

		foreach( enemy in enemies )
		{
			if (!enemy.hasZoneOfControl())
			{
				continue;
			}
			
			local bestTarget = this.queryBestMeleeTarget(enemy, null, allies).Target;			
			if (bestTarget == null || bestTarget.getMoraleState() == ::Const.MoraleState.Fleeing || bestTarget.getTile().getDistanceTo(myTile) > 4 || bestTarget.getSkills().hasSkill("effects.rf_hold_the_line"))
			{
				continue;
			}

			local enemyAttack = enemy.getSkills().getAttackOfOpportunity();
			if (!enemyAttack.verifyTargetAndRange(bestTarget.getTile(), enemy.getTile()))
			{
				continue;
			}

			local hitChance = enemyAttack.getHitchance(bestTarget);

			if (hitChance < 40 || hitChance > 90)
			{
				continue;
			}

			if (relevantAllies.find(bestTarget.getID()) == null) 
			{
				relevantAllies.push(bestTarget.getID());
			}
			
			useScore = useScore + hitChance - 40;
		}

		if (relevantAllies.len() < 5)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		score = score * (useScore * 0.01);
		return ::Const.AI.Behavior.Score.LegendHoldTheLine * score;
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
