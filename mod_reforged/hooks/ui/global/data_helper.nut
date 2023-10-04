::Reforged.HooksMod.hook("scripts/ui/global/data_helper", function(q)
{
	q.convertEntityHireInformationToUIData = @(__original) function( _entity )
	{
		local ret = __original(_entity);
		if (ret == null || _entity.getBackground() == null)
			return ret;

		local perkTree = _entity.getPerkTree();
		ret.perkTree <- perkTree.toUIData();
		ret.perkTier <- _entity.getPerkTier();
		ret.perkGroups <- [];
		ret.perkGroupsOrdered <- [];
		local perkGroupIDs = perkTree.getPerkGroups();
		foreach (idx, category in ::DynamicPerks.PerkGroupCategories.getOrdered())
		{
			local row = [];
			foreach (perkGroupID in category.getGroups())
			{
				if (perkGroupIDs.find(perkGroupID) == null)
					continue;
				local perkGroup = ::DynamicPerks.PerkGroups.findById(perkGroupID);
				local uiData = perkGroup.toUIData();
				ret.perkGroups.push(uiData);
				row.push(uiData);
			}
			if (row.len() > 0)
				ret.perkGroupsOrdered.push(row);
		}

		local specialRow = [];
		foreach (perkGroup in ::DynamicPerks.PerkGroups.getByType(::DynamicPerks.Class.SpecialPerkGroup))
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
