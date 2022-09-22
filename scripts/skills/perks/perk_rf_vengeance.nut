this.perk_rf_vengeance <- ::inherit("scripts/skills/skill", {
	m = {
		Stacks = 0,
		BonusPerStack = 25
	},
	function create()
	{
		this.m.ID = "perk.rf_vengeance";
		this.m.Name = ::Const.Strings.PerkName.RF_Vengeance;
		this.m.Description = "This character hits significantly harder after taking a hit.";
		this.m.Icon = "ui/perks/rf_vengeance.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.Stacks == 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = ::MSU.Text.colorGreen(this.m.Stacks * this.m.BonusPerStack) + "% increased damage dealt"
		});

		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= 1.0 + this.m.Stacks * this.m.BonusPerStack * 0.01;
	}
});
