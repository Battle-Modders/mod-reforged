::mods_hookNewObject("ui/global/data_helper", function(o)
{
	local convertEntityHireInformationToUIData = o.convertEntityHireInformationToUIData;
	o.convertEntityHireInformationToUIData <- function( _entity )
	{
		local ret = convertEntityHireInformationToUIData(_entity);
		if (ret == null || _entity.getBackground() == null)
			return ret

		_entity.getBackground().getPerkTree().getTree();
		ret.perkTree <- _entity.getBackground().getPerkTree().toUIData();
		ret.perkTier <- _entity.getPerkTier();
		ret.lockedPerks <- [];
		foreach (row in ret.perkTree)
		{
			foreach (perk in row)
			{
				if (!_entity.isPerkUnlockable(perk.ID)) ret.lockedPerks.push(perk.ID);
			}
		}
		return ret;
	}
})
