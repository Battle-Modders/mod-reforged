::Reforged.HooksMod.hook("scripts/entity/world/settlements/buildings/port_building", function(q) {
	q.getUITravelRoster = @(__original) { function getUITravelRoster()
	{
		local ret = __original();
		foreach (dest in ret.Roster)
		{
			// Add Owner's ID to the data so that on the JS side we can bind
			// tooltip to the banner image.
			dest.RF_OwnerID <- ::World.getEntityByID(dest.ID).getOwner().getID();
		}
		return ret;
	}}.getUITravelRoster;
});
