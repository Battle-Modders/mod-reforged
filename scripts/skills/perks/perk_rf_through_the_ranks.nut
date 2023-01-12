this.perk_rf_through_the_ranks <- ::inherit("scripts/skills/skill", {
	m = {
		Bonus = 50
	},
	function create()
	{
		this.m.ID = "perk.rf_through_the_ranks";
		this.m.Name = ::Const.Strings.PerkName.RF_ThroughTheRanks;
		this.m.Description = ::Const.Strings.PerkDescription.RF_ThroughTheRanks;
		this.m.Icon = "ui/perks/rf_through_the_ranks.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && _skill.isRanged() && _targetEntity != null && _targetEntity.getID() != this.getContainer().getActor().getID() && _targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			_properties.RangedSkillMult *= this.m.Bonus * 0.01;
		}
	}
});
