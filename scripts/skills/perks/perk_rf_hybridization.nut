this.perk_rf_hybridization <- ::inherit("scripts/skills/skill", {
	m = {
		Bonus = 10
	},
	function create()
	{
		this.m.ID = "perk.rf_hybridization";
		this.m.Name = ::Const.Strings.PerkName.RF_Hybridization;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Hybridization;
		this.m.Icon = "ui/perks/rf_hybridization.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isEnabled()
	{
		if (this.getContainer().getActor().isDisarmed())
			return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Throwing);
	}

	function onUpdate( _properties )
	{
		local bonus = ::Math.floor(this.getContainer().getActor().getBaseProperties().getRangedSkill() * this.m.Bonus * 0.01);

		_properties.MeleeSkill += bonus;
		_properties.MeleeDefense += bonus;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity != null && _skill.m.IsWeaponSkill && this.isEnabled())
		{
			_properties.RangedSkill += ::Math.floor(this.getContainer().getActor().getCurrentProperties().getMeleeSkill() * 0.2);
		}
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (_skill.isRanged() && _skill.m.IsWeaponSkill && this.isEnabled())
		{
			_tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has " + ::MSU.Text.colorizePercentage(this.getHitchanceBonus()) + " chance to hit due to " + this.getName()
			});
		}
	}
});

