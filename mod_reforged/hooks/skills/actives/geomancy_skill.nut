::Reforged.HooksMod.hook("scripts/skills/actives/geomancy_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Name = "Geomantic Rise";
		this.m.Description = "Randomly raise or lower the levels of up to two tiles below the Lorekeeper or Phylacteries. Can only be used once every " + ::MSU.Text.colorPositive(2) + " turns.";
	}

	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		if (this.m.Cooldown != 0)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "Can be used again in " + this.m.Cooldown + " turns"
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
		local phylacteryTarget = 3 - ::Math.floor(::Time.getRound() / 9);	// This vanilla condition is hard to explain so it's currently not mentioned in the tooltip
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
