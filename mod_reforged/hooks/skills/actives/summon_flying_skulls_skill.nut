::Reforged.HooksMod.hook("scripts/skills/actives/summon_flying_skulls_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Name = "Summon Screaming Skulls";
		this.m.Description = "Summon several exploding flying skulls to swarm the battlefield.";
	}

	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		// Const
		local maxSkullsPerUse = 12;

		local currentPhylacteries = 0;
		local currentSkulls = 0;
		foreach (e in ::Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction()))
		{
			if (e.getType() == ::Const.EntityType.SkeletonPhylactery)
			{
				currentPhylacteries++;
			}
			if (e.getType() == ::Const.EntityType.FlyingSkull)
			{
				currentSkulls++;
			}
		}
		local phylacteryReference = ::Math.max(0, currentPhylacteries - ::Time.getRound() / 9);
		local phylacteriesDestroyed = ::Math.max(0, 9 - phylacteryReference);
		local maximumSkulls = 12 + phylacteriesDestroyed * 2;
		local skullsToSpawn = ::Math.min(maxSkullsPerUse, ::Math.min(4 + phylacteriesDestroyed, maximumSkulls - currentSkulls));

		if (skullsToSpawn != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will summon " + ::MSU.Text.colorPositive(skullsToSpawn) + " Flying Skulls up to a maximum of " + ::MSU.Text.colorPositive(maximumSkulls)
			});
		}
		else
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "Cannot be used while there are " + ::MSU.Text.colorPositive(maximumSkulls) + " or more Flying Skulls on the battlefield"
			});
		}

		return ret;
	}
});
