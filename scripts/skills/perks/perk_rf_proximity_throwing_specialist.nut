this.perk_rf_proximity_throwing_specialist <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_proximity_throwing_specialist";
		this.m.Name = ::Const.Strings.PerkName.RF_ProximityThrowingSpecialist;
		this.m.Description = ::Const.Strings.PerkDescription.RF_ProximityThrowingSpecialist;
		this.m.Icon = "ui/perks/rf_proximity_throwing_specialist.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!_skill.isRanged()) return;

		if (_targetEntity == null || _targetEntity.getTile().getDistanceTo(this.getContainer().getActor().getTile()) == 2)
		{
			_properties.DamageDirectAdd += 0.25;
		}
	}
});
