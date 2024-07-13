::Reforged.HooksMod.hook("scripts/skills/actives/raise_all_undead_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Name = "Raise all Undead";
		this.m.Description = "Animates all corpses on the battlefield, transforming them into undead minions under your control. Each newly risen undead is equipped with ancient weaponry if unarmed. Can only be used once per battle.";
	}

	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		if (::Tactical.Entities.getFlags().getAsInt("RaiseAllUndeadUsed") != 0)
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

		if (::Tactical.Entities.getCorpses().len() < 6)
		{
			ret.push({
				id = 22,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "Cannot be used while there are less than " + ::MSU.Text.colorPositive("7") + " corpses on the battlefield"
			});
		}

		return ret;
	}

});
