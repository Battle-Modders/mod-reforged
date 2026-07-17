// Implements Damage Resistences on a damage type basis
this.rf_damage_type_mitigation <- ::inherit("scripts/skills/skill", {
	m = {
	},
	function create()
	{
		this.m.ID = "special.rf_damage_type_mitigation";
		this.m.Type = ::Const.SkillType.Special;
		this.m.Order = ::Const.SkillOrder.VeryLast + 10;
		this.m.IsHidden = true;
		this.m.IsSerialized = false;
	}

	q.onBeforeDamageReceived = @() { function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_hitInfo.DamageType != null)
		{
			_properties.DamageReceivedRegularMult *= _properties.RF_DamageReceivedRegularMultByType[_hitInfo.DamageType];
			_properties.DamageReceivedArmorMult *= _properties.RF_DamageReceivedArmorMultByType[_hitInfo.DamageType];
			_properties.DamageReceivedTotalMult *= _properties.RF_DamageReceivedTotalMultByType[_hitInfo.DamageType];
		}
	}}.onBeforeDamageReceived;
});
