this.ai_rf_sanguine_curse <- ::inherit("scripts/ai/tactical/behavior", {
	m = {
		PossibleSkills = [
			"actives.rf_sanguine_curse"
		],
		Skill = null,
		TargetTile = null
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.RF_SanguineCurse;
		this.m.Order = ::Const.AI.Behavior.Order.RF_SanguineCurse;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.Skill = null;
		this.m.TargetTile = null;

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

		local score = this.getProperties().BehaviorMult[this.m.ID] * this.getFatigueScoreMult(this.m.Skill);
		local highestHP = 0;
		local target = null;
		foreach (enemy in this.getAgent().getKnownOpponents())
		{
			if (!this.m.Skill.isUsableOn(enemy.Actor.getTile()))
				continue;

			local hp = enemy.Actor.getHitpoints();
			if (hp > highestHP)
			{
				highestHP = hp;
				target = enemy;
			}
		}

		if (target == null || highestHP <= 10)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		this.m.TargetTile = target.Actor.getTile();

		return ::Const.AI.Behavior.Score.RF_SanguineCurse * score;
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.getAgent().adjustCameraToTarget(this.m.TargetTile);
			this.m.IsFirstExecuted = false;

			if (this.m.TargetTile.IsVisibleForPlayer && _entity.isHiddenToPlayer())
			{
				_entity.setDiscovered(true);
				_entity.getTile().addVisibilityForFaction(::Const.Faction.Player);
			}

			return false;
		}

		this.m.Skill.use(this.m.TargetTile);
		this.getAgent().declareEvaluationDelay(500);

		if (!_entity.isHiddenToPlayer())
		{
			this.getAgent().declareAction();
		}

		this.m.Skill = null;
		this.m.TargetTile = null;
		return true;
	}
});
