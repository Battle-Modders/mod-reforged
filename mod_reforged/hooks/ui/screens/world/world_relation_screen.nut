::Reforged.HooksMod.hook("scripts/ui/screens/world/world_relations_screen", function(q) {
	q.convertFactionsToUIData = @(__original) function()
	{
		local ret = __original();

		foreach (factionContainer in ret.Factions)
		{
			local faction = ::World.FactionManager.getFaction(factionContainer.ID);
			// Feat: Civilian Factions (using the banner ID 11) now show their
			// settlement image instead of the generic banner on the relations screen.
			if (faction.getBanner() == 11)
			{
				factionContainer.ImagePath = faction.getSettlements()[0].getImagePath();
			}
		}

		return ret;
	}
});
