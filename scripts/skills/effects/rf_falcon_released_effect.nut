this.rf_falcon_released_effect <- ::inherit("scripts/skills/skill", {
	m = {
		InitiativeModifier = 20
	},
	function create()
	{
		this.m.ID = "effects.rf_falcon_released";
		this.m.Name = "Falcon Released";
		this.m.Description = "This character has gained a heightened understanding of the battlefield thanks to a friendly falcon.";
		this.m.Icon = "skills/rf_falcon_released_effect.png";
		this.m.Overlay = "rf_falcon_released_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.InitiativeModifier, {AddSign = true}) + " [Initiative|Concept.Initiative] until the start of the next [round|Concept.Round]")
		});

		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.Initiative += this.m.InitiativeModifier;
	}

	function onNewRound()
	{
		this.removeSelf();
	}
});
