::Reforged.HooksMod.hook("scripts/skills/traits/impatient_trait", function(q) {
	q.m.InitiativeForTurnOrderAdditional <- 20;

	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		if (this.m.InitiativeForTurnOrderAdditional != 0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.InitiativeForTurnOrderAdditional, {AddSign = true}) + " [Initiative|Concept.Initiative] for [turn|Concept.Turn] order")
			});
		}
		return ret;
	}}.getTooltip;

	q.onUpdate = @(__original) { function onUpdate( _properties )
	{
		__original(_properties);
		_properties.InitiativeForTurnOrderAdditional += this.m.InitiativeForTurnOrderAdditional;
	}}.onUpdate;
});
