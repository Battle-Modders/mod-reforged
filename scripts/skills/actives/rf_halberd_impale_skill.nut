this.rf_halberd_impale_skill <- ::inherit("scripts/skills/actives/impale", {
	m = {
		DamageArmorMultAdd = -0.2
	},
	function create()
	{
		this.impale.create();
		this.m.Icon = "skills/rf_halberd_impale_skill.png";
		this.m.IconDisabled = "skills/rf_halberd_impale_skill_sw.png";
		this.m.Overlay = "rf_halberd_impale_skill";
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
	}

	function getTooltip()
	{
		local ret = this.impale.getTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/armor_damage.png",
			text = ::Reforged.Mod.Tooltips.parseString("Has " + ::MSU.Text.colorizeValue(this.m.DamageArmorMultAdd * 100, {AddPercent = true}) + " [armor effectiveness|Concept.CrushingDamage]")
		});
		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.impale.onAnySkillUsed(_skill, _targetEntity, _properties);
		if (_skill == this)
		{
			_properties.DamageArmorMult += this.m.DamageArmorMultAdd;
		}
	}
});
