this.perk_rf_swordlike <- ::inherit("scripts/skills/skill", {
	m = {
		Bonus = 10
	},
	function create()
	{
		this.m.ID = "perk.rf_swordlike";
		this.m.Name = ::Const.Strings.PerkName.RF_Swordlike;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Swordlike;
		this.m.Icon = "ui/perks/perk_rf_swordlike.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isEnabled()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Cleaver) || weapon.getRangeMax() != 1)
		{
			return false;
		}

		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.m.IsWeaponSkill && !_skill.isRanged() && this.isEnabled())
		{
			_properties.MeleeSkill += this.m.Bonus;
			_skill.m.HitChanceBonus += this.m.Bonus;
		}
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (_skill.m.IsWeaponSkill && !_skill.isRanged() && this.isEnabled())
		{
			_tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has " + ::MSU.Text.colorizePercentage(this.m.Bonus) + " chance to hit because of " + ::MSU.Text.colorPositive(this.getName())
			});
		}
	}
});
