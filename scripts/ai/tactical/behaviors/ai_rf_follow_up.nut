this.ai_rf_follow_up <- ::inherit("scripts/ai/tactical/behavior", {
	m = {
		Skill = null,
		PossibleSkills = [
			"actives.rf_follow_up"
		],
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.RF_FollowUp;
		this.m.Order = ::Const.AI.Behavior.Order.RF_FollowUp;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.Skill = null;

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

		local attackSkill = _entity.getSkills().getAttackOfOpportunity();
		if (attackSkill == null)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		local score = this.getProperties().BehaviorMult[this.m.ID];
		score = score * this.getFatigueScoreMult(this.m.Skill);

		local targets = this.queryTargetsInMeleeRange(attackSkill.getMinRange(), attackSkill.getMaxRange(), attackSkill.getMaxLevelDifference());

		local bestTarget = this.queryBestMeleeTarget(_entity, attackSkill, targets);

		if (bestTarget.Target == null)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		local meleeTarget = bestTarget.Target;

		local attackBehaviorScore = this.getProperties().BehaviorMult[::Const.AI.Behavior.ID.AttackDefault];
		attackBehaviorScore = attackBehaviorScore * this.getFatigueScoreMult(attackSkill);

		attackBehaviorScore = ::Math.max(0, ::Const.AI.Behavior.Score.Attack * bestTarget.Score * attackBehaviorScore);

		local damage = attackSkill.getExpectedDamage(meleeTarget);

		if (meleeTarget.getHitpoints() <= damage.HitpointDamage + damage.DirectDamage)
		{
			if (::Const.AI.VerboseMode)
			{
				this.logInfo("Can kill " + meleeTarget.getName() + " hence no Follow Up");
			}
			
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (damage.HitpointDamage >= ::Const.Combat.InjuryMinDamage)
		{
			local threshold = _entity.getCurrentProperties().ThresholdToInflictInjuryMult * ::Const.Combat.InjuryThresholdMult * meleeTarget.getCurrentProperties().ThresholdToReceiveInjuryMult;
			local dmg = damage.HitpointDamage / (meleeTarget.getHitpointsMax() * 1.0);

			if (threshold * 0.25 <= dmg)
			{
				score = score * ::Const.AI.Behavior.DistractPreferInjuryMult;
			}
		}

		local allies = this.getAgent().getKnownAllies();

		local surroundedTargets = 0;
		local surroundingAllies = 0;
		local myTile = _entity.getTile();
		foreach (target in targets)
		{
			local targetTile = target.getTile();
			if (targetTile.getZoneOfControlCount(_entity.getFaction()) == 0 || !attackSkill.isInRange(targetTile, myTile) || !attackSkill.onVerifyTarget(myTile, targetTile))
			{
				continue;
			}

			surroundedTargets++;

			foreach (ally in allies)
			{
				if (!ally.hasZoneOfControl())
				{
					continue;
				}

				local allyTile = ally.getTile();				
				local allyAttack = ally.getSkills().getAttackOfOpportunity();
				
				if (allyAttack.isInRange(targetTile, allyTile) && allyAttack.onVerifyTarget(allyTile, targetTile))
				{
					surroundingAllies++;
				}
			}
		}

		if (surroundedTargets == 0 || surroundingAllies == 0)
		{
			if (::Const.AI.VerboseMode)
			{
				this.logInfo("No Surrounded Target or Surrounding Allies in sight");
			}
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (::Const.AI.VerboseMode)
		{
			this.logInfo("Surrounded Targets : " + surroundedTargets + ", and Surrounding Allies : " + surroundingAllies);
			this.logInfo("Attack Behavior Score: " + attackBehaviorScore);
		}

		score *= surroundingAllies * surroundedTargets * attackBehaviorScore;

		if (score < attackBehaviorScore)
		{
			if (::Const.AI.VerboseMode)
			{
				this.logInfo("Follow Up Score " + score + " was lower than melee attack score " + attackBehaviorScore + " hence no follow up");
			}
			return ::Const.AI.Behavior.Score.Zero;
		}

		return ::Const.AI.Behavior.Score.RF_FollowUp * score;
	}

	function onExecute( _entity )
	{
		this.m.Skill.use(_entity.getTile());
		if (!_entity.isHiddenToPlayer())
		{
			this.getAgent().declareAction();
		}

		this.m.Skill = null;
		return true;
	}
});
