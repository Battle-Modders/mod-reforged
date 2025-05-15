::Reforged.HooksMod.hook("scripts/scenarios/world/militia_scenario", function(q) {
	q.create = @(__original) function()
	{
		__original();
		local additionalDesc = "\n[color=#bcad8c]Militia:[/color] All recruits have access to the Militia perk group.";
		if (this.m.Description.slice(-4) == "[/p]")
		{
			this.m.Description = this.m.Description.slice(0, -4) + additionalDesc + "[/p]";
		}
		else
		{
			this.m.Description += additionalDesc;
		}
	}

	q.onBuildPerkTree = @(__original) function( _perkTree )
	{
		__original(_perkTree);

		// Instead of directly adding militia perk group, we iterate over its rows and add
		// the perks to the perk tree because some perks may have come from other perk groups
		// at tiers different from the tiers that militia perk group has them at.
		foreach (i, row in ::DynamicPerks.PerkGroups.findById("pg.rf_militia").getTree())
		{
			foreach (perkID in row)
			{
				if (_perkTree.hasPerk(perkID))
				{
					if (_perkTree.getPerkTier(perkID) == i + 1)
						continue;
					else
						_perkTree.removePerk(perkID);
				}
				_perkTree.addPerk(perkID, i + 1);
			}
		}
	}
});
