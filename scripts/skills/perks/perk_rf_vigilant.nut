this.perk_rf_vigilant <- ::inherit("scripts/skills/skill", {
	m = {
		CurrBonus = 0
	},
	function create()
	{
		this.m.ID = "perk.rf_vigilant";
		this.m.Name = ::Const.Strings.PerkName.RF_Vigilant;
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("This character\'s eye is keen, his movements keener. Gain a portion of unspent [Action Points|Concept.ActionPoints] from the previous [turn.|Concept.Turn]");
		this.m.Icon = "ui/perks/perk_rf_vigilant.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isHidden()
	{
		return this.m.CurrBonus == 0;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.CurrBonus) + " [Action Points|Concept.ActionPoints]")
		});

		return ret;
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
