this.rf_first_turn_initiative <- ::inherit("scripts/skills/skill", {
	m = {
		// Config
		InitiativePerAP = 40.0,	// For every this much Initiative an entity gains 1 AP. The received bonus can be negative
		FlatAPBonus = -2,	// This is to balance out this new bonus for most entities
		TotalMinimum = -3,
		TotalMaximum = 7,	// Maximum is just in case so that enemies that accidentally have extreme initiative don't one-shot you Turn one

		// Const
		IconPositive = "ui/traits/trait_icon_46.png",	// Impatient Trait
		IconNegative = "ui/traits/trait_icon_25.png",	// Hesitant Trait

		// Private
		CurrentAPBonus = 0
	},
	function create()
	{
		this.m.ID = "special.rf_first_turn_initiative";
		this.m.Name = "First Turn Initiative";
		this.m.Description = "During the first turn of every combat, this character\'s [Action Points|Concept.ActionPoints] are modified depending on their [Initiative|Concept.Initiative] at that point.";
		this.m.Icon = "ui/traits/trait_icon_46.png";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;		// Some effects may set the Action Points to a flat value instead of increasing them, like 'possessed_undead_effect'
		this.m.IsSerialized = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		local ret = this.skill.getDescription();

		ret += "\nThis character gains 1 [Action Point|Concept.ActionPoints] for every " + ::MSU.Text.colorPositive(this.m.InitiativePerAP) + " [Initiative|Concept.Initiative] which is then modified by a flat " + ::MSU.Text.colorizeValue(this.m.FlatAPBonus) + " [Action Points.|Concept.ActionPoints]";

		return ::Reforged.Mod.Tooltips.parseString(ret);
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.CurrentAPBonus) + " [Action Point(s)|Concept.ActionPoints] for this [turn|Concept.Turn]")
		});

		return ret;
	}

	function isHidden()
	{
		return this.m.CurrentAPBonus == 0;
	}

	function onUpdate( _properties )
	{
		_properties.ActionPoints += this.m.CurrentAPBonus;
	}

	function onNewRound()
	{
		this.m.CurrentAPBonus = this.m.FlatAPBonus;
		this.m.CurrentAPBonus += ::Math.floor(this.getContainer().getActor().getInitiative() / this.m.InitiativePerAP);
		this.m.CurrentAPBonus = ::Math.min(this.m.TotalMaximum, ::Math.max(this.m.TotalMinimum, this.m.CurrentAPBonus));

		this.m.Icon = this.m.CurrentAPBonus > 0 ? this.m.IconPositive : this.m.IconNegative;
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}
});
