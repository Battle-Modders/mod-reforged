this.perk_rf_deep_impact <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false
	},
	function create()
	{
		this.m.ID = "perk.rf_deep_impact";
		this.m.Name = ::Const.Strings.PerkName.RF_DeepImpact;
		this.m.Description = ::Const.Strings.PerkDescription.RF_DeepImpact;
		this.m.Icon = "ui/perks/rf_deep_impact.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && (skill.getDamageType().contains(::Const.Damage.DamageType.Blunt) || this.m.IsForceEnabled))
		{
			_properties.DamageDirectAdd += 0.1;
		}
	}
});
