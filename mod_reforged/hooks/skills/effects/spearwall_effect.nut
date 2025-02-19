::Reforged.HooksMod.hook("scripts/skills/effects/spearwall_effect", function(q) {
	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		local crowded = this.getContainer().getSkillByID("special.rf_polearm_adjacency");
		if (crowded != null)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("Attacks do not suffer from %s when it is not your [turn|Concept.Turn]", ::Reforged.NestedTooltips.getNestedSkillName(crowded)))
			});
		}

		return ret;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);
		if (::Tactical.isActive() && !::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
		{
			local crowded = this.getContainer().getSkillByID("special.rf_polearm_adjacency");
			if (crowded != null)
			{
				crowded.m.NumEnemiesToIgnore = 99;
				crowded.m.NumAlliesToIgnore = 99;
			}
		}
	}
});
