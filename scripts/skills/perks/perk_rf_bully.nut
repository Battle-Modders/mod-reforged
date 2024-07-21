this.perk_rf_bully <- ::inherit("scripts/skills/skill", {
	m = {
		DamageBonus = 10
	},
	function create()
	{
		this.m.ID = "perk.rf_bully";
		this.m.Name = ::Const.Strings.PerkName.RF_Bully;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Bully;
		this.m.Icon = "ui/perks/perk_rf_bully.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity != null && _targetEntity.getMoraleState() != ::Const.MoraleState.Ignore)
		{
			local difference = this.getContainer().getActor().getMoraleState() - _targetEntity.getMoraleState();
			if (difference > 0)
			{
				_properties.MeleeDamageMult *= 1.0 + this.m.DamageBonus * 0.01 * difference;
			}
		}
	}
});
