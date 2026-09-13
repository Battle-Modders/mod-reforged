this.ai_rf_attack_perforate <- ::inherit("scripts/ai/tactical/behaviors/ai_attack_default", {
	m = {},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.RF_AttackPerforate;
		this.m.Order = ::Const.AI.Behavior.Order.RF_AttackPerforate;
		this.m.PossibleSkills = ["actives.perforate"];
		this.behavior.create();
	}

	function queryTargetValue( _entity, _target, _skill = null )
	{
		local ret = this.ai_attack_default.queryTargetValue(_entity, _target, _skill);
		if (_skill == null || _skill.getID() != "actives.perforate") 
			return ret;

		local followup = _entity.getSkills().getSkillByID("actives.rf_perforate_sword_thrust");
		if (followup == null) 
			return ret;

		local p = _entity.getCurrentProperties();
		// Start from the actor's effective initiative, then account for the cost paid before onUse.
		local initiative = _entity.getInitiative() - _skill.getFatigueCost() * p.FatigueToInitiativeRate;
		local extra = ::Math.max(0.01, (initiative - _target.getInitiative()) / 75);
		local attacks = 0;
		for (local i = 0; i < extra; ++i) ++attacks;
		
		local damage = followup.getExpectedDamage(_target).TotalDamage * followup.getHitchance(_target) / 100.0;
		local remaining = _target.getHitpoints() + _target.getArmor(::Const.BodyPart.Body) + _target.getArmor(::Const.BodyPart.Head);
		return ret + ::Math.minf(remaining, attacks * damage)
			/ ::Math.maxf(1.0, p.getRegularDamageAverage() + p.getArmorDamageAverage())
			* this.getProperties().TargetPriorityDamageMult;
	}
});
