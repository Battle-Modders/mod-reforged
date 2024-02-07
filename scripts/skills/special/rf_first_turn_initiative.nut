this.rf_first_turn_initiative <- ::inherit("scripts/skills/skill", {
	m = {
		// Public
		InitiativePerAP = 40.0,	// For every this much Initiative an entity gains 1 AP. The bonus can be negative
		FlatAPBonus = -2,	// This is to balance out this new bonus for most entities

		// Private
		APBonus = 0

		// Const
		IconNegative = "ui/traits/trait_icon_25.png"	// Hesitant Trait
		TotalMinimum = -3,
		TotalMaximum = 7,	// Maximum is just incase so that enemies that accidentally have extreme initiative don't one-shot you Turn one
	},
	function create()
	{
		this.m.ID = "special.rf_first_turn_initiative";
		this.m.Name = "First Turn Initiative";
		this.m.Description = "During the first turn of every combat, this characters [Action Points|Concept.ActionPoints] are modified depending on their [Initiative|Concept.Initiative] at that point.";
		this.m.Icon = "ui/traits/trait_icon_46.png";	// Impatient Trait icon by default
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last + 100;		// Some effects may set the Action Points to a flat value instead of increasing them, like 'possessed_undead_effect'
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsSerialized = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		local description = this.m.Description;
		description += "\nThis character gains 1 [Action Point|Concept.ActionPoints] for every " + ::MSU.Text.colorGreen(this.m.InitiativePerAP) + " [Initiative|Concept.Initiative] which is then modified by a flat " + ::MSU.Text.colorizeValue(this.m.FlatAPBonus) + " [Action Points|Concept.ActionPoints].";
		return ::Reforged.Mod.Tooltips.parseString(description);
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = ::MSU.Text.colorizeValue(this.m.APBonus) + " Action Points for this turn"
		});
		return tooltip;
	}

	function isHidden()
	{
		return (this.m.APBonus == 0);
	}

	function onUpdate( _properties )
	{
		_properties.ActionPoints += this.m.APBonus;
	}

	function onNewRound()
	{
		// Small switcheroo so that we can cheat a quick update in to get correct Initiative for calculation
		this.getContainer().m.IsUpdating = false;
		this.getContainer().update();
		this.getContainer().m.IsUpdating = true;

		this.m.APBonus = this.m.FlatAPBonus;
		this.m.APBonus += ::Math.floor(this.getContainer().getActor().getInitiative() / this.m.InitiativePerAP);
		this.m.APBonus = ::Math.min(this.m.TotalMaximum, ::Math.max(this.m.TotalMinimum, this.m.APBonus));

		if (this.m.APBonus < 0) this.m.Icon = this.m.IconNegative;
	}

	// This effect only affects the very first round of each combat
	function onRoundEnd()
	{
		this.removeSelf();
	}
});
