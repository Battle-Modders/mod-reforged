::mods_hookNewObject("ui/global/data_helper", function(o)
{
	local convertEntityHireInformationToUIData = o.convertEntityHireInformationToUIData;
	o.convertEntityHireInformationToUIData <- function( _entity )
	{
		local ret = convertEntityHireInformationToUIData(_entity);
		if (ret == null || _entity.getBackground() == null)
			return ret;

		local perkTree = _entity.getBackground().getPerkTree();
		ret.perkTree <- perkTree.toUIData();
		ret.perkTier <- _entity.getPerkTier();
		ret.lockedPerks <- [];
		foreach (id, perk in perkTree.getPerks())
		{
			if (!_entity.isPerkUnlockable(id)) ret.lockedPerks.push(id);
		}
		return ret;
	}
})
