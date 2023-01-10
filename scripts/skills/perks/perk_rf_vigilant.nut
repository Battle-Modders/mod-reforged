this.perk_rf_vigilant <- ::inherit("scripts/skills/skill", {
	m = {
		CurrBonus = 0
	},
	function create()
	{
		this.m.ID = "perk.rf_vigilant";
		this.m.Name = ::Const.Strings.PerkName.RF_Vigilant;
		this.m.Description = "This character\'s eye is keen, his movements keener. Gain a portion of unspent Action Points from the previous turn.";
		this.m.Icon = "ui/perks/rf_vigilant.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.CurrBonus == 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = ::MSU.Text.colorizeValue(this.m.CurrBonus) + " Action Points"
		});

		return tooltip;
	}

	function onTurnEnd()
	{
		this.m.CurrBonus = this.getContainer().getActor().getActionPoints() / 2;
	}

	function onUpdate( _properties )
	{
		_properties.ActionPoints += this.m.CurrBonus;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.CurrBonus = 0;
	}
});
