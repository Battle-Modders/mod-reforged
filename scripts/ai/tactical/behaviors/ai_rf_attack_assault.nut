this.ai_rf_attack_assault <- ::inherit("scripts/ai/tactical/behaviors/ai_attack_default", {
	m = {},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.RF_AttackAssault;
		this.m.Order = ::Const.AI.Behavior.Order.RF_AttackAssault;
		this.m.PossibleSkills = ["actives.assault"];
		this.behavior.create();
	}

	function queryTargetValue( _entity, _target, _skill = null )
	{
		local ret = this.ai_attack_default.queryTargetValue(_entity, _target, _skill);
		if (_skill == null || _skill.getID() != "actives.assault" || !_target.getSkills().hasSkill("effects.staggered")) 
			return ret;

		local hew = _entity.getSkills().getSkillByID("actives.rf_assault_hew");
		if (hew == null) 
			return ret;

		local damage = hew.getExpectedDamage(_target).TotalDamage * hew.getHitchance(_target) / 100.0;
		local p = _entity.getCurrentProperties();
		return ret + damage / ::Math.maxf(1.0, p.getRegularDamageAverage() + p.getArmorDamageAverage())
			* this.getProperties().TargetPriorityDamageMult;
	}
});
