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
		ret.perkGroups <- [];
		ret.perkGroupsOrdered <- [];
		local perkGroupIDs = perkTree.getPerkGroups();
		foreach (idx, category in ::DPF.Perks.PerkGroupCategories.getOrdered())
		{
			local row = [];
			foreach (perkGroupID in category.getGroups())
			{
				if (perkGroupIDs.find(perkGroupID) == null)
					continue;
				local perkGroup = ::DPF.Perks.PerkGroups.findById(perkGroupID);
				local uiData = perkGroup.toUIData();
				ret.perkGroups.push(uiData);
				row.push(uiData);
			}
			if (row.len() > 0)
				ret.perkGroupsOrdered.push(row);
		}

		local specialRow = [];
		foreach (perkGroup in ::DPF.Perks.PerkGroups.getByType(::DPF.Class.SpecialPerkGroup))
		{
		    if (perkTree.hasPerkGroup(perkGroup.getID()))
		    {
		        local uiData = perkGroup.toUIData();
		        ret.perkGroups.push(uiData);
		        specialRow.push(uiData);
		    }
		}
		if (specialRow.len() > 0)
		    ret.perkGroupsOrdered.push(specialRow);

		ret.lockedPerks <- [];
		foreach (id, perk in perkTree.getPerks())
		{
			if (!_entity.isPerkUnlockable(id)) ret.lockedPerks.push(id);
		}
		return ret;
	}
})
