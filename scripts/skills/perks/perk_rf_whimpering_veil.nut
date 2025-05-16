this.perk_rf_whimpering_veil <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_whimpering_veil";
		this.m.Name = ::Const.Strings.PerkName.RF_WhimperingVeil;
		this.m.Description = ::Const.Strings.PerkDescription.RF_WhimperingVeil;
		this.m.Icon = "ui/perks/perk_rf_whimpering_veil.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getMoraleState() < ::Const.MoraleState.Steady || _attacker.getSkills().hasSkill("effects.rf_grieving_malaise"))
		{
			_properties.DamageTotalMult = 0.0;
		}
	}
});
