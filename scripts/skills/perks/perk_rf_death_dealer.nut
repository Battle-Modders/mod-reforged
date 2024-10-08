this.perk_rf_death_dealer <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_death_dealer";
		this.m.Name = ::Const.Strings.PerkName.RF_DeathDealer;
		this.m.Description = ::Const.Strings.PerkDescription.RF_DeathDealer;
		this.m.Icon = "ui/perks/perk_rf_death_dealer.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && _skill.isAOE() && !_skill.isRanged())
		{
			_properties.DamageTotalMult *= 1.1;
			_properties.MeleeSkill += 10;
		}
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (_skill.isAttack() && _skill.isAOE() && !_skill.isRanged())
		{
			_tooltip.push({
				id = 100,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = ::Reforged.Mod.Tooltips.parseString("Has " + ::MSU.Text.colorizeValue(10, {AddSign = true, AddPercent = true}) + " chance to hit due to " + ::Reforged.NestedTooltips.getNestedPerkName(this))
			});
		}
	}
});
