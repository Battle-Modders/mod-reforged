this.rf_great_cleave_skill <- ::inherit("scripts/skills/actives/rf_heavy_cleave_skill", {
	m = {},
	function create()
	{
		this.rf_heavy_cleave_skill.create();
		this.m.ID = "actives.rf_great_cleave";
		this.m.Name = "Great Cleave";
		this.m.Icon = "skills/rf_great_cleave_skill.png";
		this.m.IconDisabled = "skills/rf_great_cleave_skill_sw.png";
		this.m.Overlay = "rf_great_cleave_skill";
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 20;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		// Apply 1 more stack of bleeding. The first one is applied by vanilla cleave.onUse.
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.getCurrentProperties().IsImmuneToBleeding && _damageInflictedHitpoints >= ::Const.Combat.MinDamageToApplyBleeding)
		{
			local effect = ::new("scripts/skills/effects/bleeding_effect");
			effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5);
			_targetEntity.getSkills().add(effect);
		}
	}
});
