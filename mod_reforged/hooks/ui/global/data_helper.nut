::Reforged.HooksMod.hook("scripts/ui/global/data_helper", function(q)
{
	q.convertEntityHireInformationToUIData = @(__original) { function convertEntityHireInformationToUIData( _entity )
	{
		local ret = __original(_entity);
		if (ret == null || _entity.getBackground() == null)
			return ret;

		local perkTree = _entity.getPerkTree();
		ret.perkTree <- perkTree.toUIData();
		ret.perkTier <- _entity.getPerkTier();
		local perkGroups = this.dpf_convertEntityPerkGroupsToUIData(_entity);
		ret.perkGroups <- perkGroups.perkGroups;
		ret.perkGroupsOrdered <- perkGroups.perkGroupsOrdered;

		ret.lockedPerks <- [];
		foreach (id, perk in perkTree.getPerks())
		{
			if (!_entity.isPerkUnlockable(id)) ret.lockedPerks.push(id);
		}
		return ret;
	}}.convertEntityHireInformationToUIData;

	q.addStatsToUIData = @(__original) { function addStatsToUIData( _entity, _target )
	{
		__original(_entity, _target);
		local properties = _entity.getCurrentProperties();
		_target.rf_reach <- properties.getReach();
		_target.rf_reachMax <- 15; // arbitrary
	}}.addStatsToUIData;


	q.convertAssetsInformationToUIData = @(__original) function()
	{
		local ret = __original();
		local currentTown = ::World.State.getCurrentTown();
		ret["FollowerTools"] <- ::World.Retinue.getFollowerToolAmount();
		ret["CurrentFollowerAmount"] <- ::World.Retinue.getNumberOfCurrentFollowers();
		ret["MaxFollowerAmount"] <- ::Reforged.Retinue.MaxFollowersHired;
		return ret;
	};
})
