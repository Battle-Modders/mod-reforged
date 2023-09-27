this.perk_rf_vigilant <- ::inherit("scripts/skills/skill", {
	m = {
		CurrAPBonus = 0,
		CurrPoiseBonus = 0,
	},
	function create()
	{
		this.m.ID = "perk.rf_vigilant";
		this.m.Name = ::Const.Strings.PerkName.RF_Vigilant;
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("This character\'s eye is keen, his movements keener. Gain a portion of unspent Action Points from the previous turn and additional [Poise|Concept.Poise] for every available Action Point whenever you end your turn.");
		this.m.Icon = "ui/perks/rf_vigilant.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return (this.m.CurrAPBonus == 0 && this.m.CurrPoiseBonus == 0);
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		if (this.m.CurrAPBonus != 0)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = ::MSU.Text.colorizeValue(this.m.CurrAPBonus) + " Action Points"
			});
		}

		if (this.m.CurrPoiseBonus != 0)
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/sturdiness.png",
				text = ::MSU.Text.colorizeValue(this.m.CurrPoiseBonus) + ::Reforged.Mod.Tooltips.parseString(" [Poise|Concept.Poise]")
			});
		}

		return tooltip;
	}

	function onTurnStart()
	{
		this.m.CurrPoiseBonus = 0;
	}

	function onTurnEnd()
	{
		this.m.CurrAPBonus = this.getContainer().getActor().getActionPoints() / 2;
		this.m.CurrPoiseBonus = 10 * this.getContainer().getActor().getActionPoints();
	}

	function onUpdate( _properties )
	{
		_properties.ActionPoints += this.m.CurrAPBonus;
		_properties.PoiseMax += this.m.CurrPoiseBonus;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.CurrAPBonus = 0;
		this.m.CurrPoiseBonus = 0;
	}
});
