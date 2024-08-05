::Reforged.HooksMod.hook("scripts/skills/actives/geomancy_once_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Name = "Geomantic Ascension";
		this.m.Description = "Raise the tiles below every Phylactery to a level of 3 until any Phylactery is destroyed. Can only be used once per battle.";
	}

	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		if (::Tactical.Entities.getFlags().getAsInt("GeomancyOnceUsed") != 0)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "Can only be used once per battle"
			});
		}

		local phylacteries = 0;
		foreach (e in ::Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction()))
		{
			if (e.getType() == ::Const.EntityType.SkeletonPhylactery)
			{
				phylacteries++;
			}
		}
		local phylacteryTarget = 6 - ::Math.floor(::Time.getRound() / 9);	// This vanilla condition is hard to explain so it's currently not mentioned in the tooltip
		if (phylacteries > phylacteryTarget)
		{
			ret.push({
				id = 21,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "Cannot be used until " + ::MSU.Text.colorPositive(phylacteries - phylacteryTarget) + " more Phylacteries are destroyed"
			});
		}

		return ret;
	}
});
