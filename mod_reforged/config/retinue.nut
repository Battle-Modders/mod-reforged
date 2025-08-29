::Reforged.Retinue <- {
	MaxFollowersInUI = 5,
	MaxFollowersHired = 5,
	MaxFollowersInTown = 3,
	DaysFollowerStaysInTown = 30,
	BasePctForFollowerToSpawnPerDay = 50,
	DecayRateForFollowerToSpawnPerDay = 0.8,
	FollowerToolIcon = "ui/icons/rf_follower_tools.png",
	PerkDefs = {
		"perk.test" : {
			ID = "perk.test",
			Script = "scripts/skills/rf_follower/perk_test",
			Name = "Test",
			Tooltip = "TestTooltip",
			Icon = "ui/perks/perk_16.png",
			IconDisabled = "ui/perks/perk_16.png",
			ToolCost = 2,
			verifyPrerequisites = function(_follower)
			{
				local ret = [];
				ret.push({
					id = 3,
					type = "hint",
					text = format("Extra requirement 1 to unlock %s", _follower.getName()),
					icon = ::Reforged.Retinue.getIsValidIcon(true),
					isValid = true,
				})
				return ret;
			}
		},
		"perk.test_child" : {
			ID = "perk.test_child",
			Script = "scripts/skills/rf_follower/perk_test_child",
			Name = "Test Child",
			Tooltip = "TestTooltip Child",
			Icon = "ui/perks/perk_16.png",
			IconDisabled = "ui/perks/perk_16.png",
			ToolCost = 1,
			RequiredPerks = ["perk.test"],
		}
	},
	//TODO
	PerkIDByFilename = {
		"perk_test" : "perk.test",
		"perk_test_child" : "perk.test_child",
	}
	FollowerDefs = {
		"follower.scount" : {
			PerkTree = [],

		}
		"follower.debug" : {
			PerkTree = [["perk.test"], ["perk.test_nonexisting", "perk.test_child"]],
		}
	}

	function getPerk(_perkID)
	{
		return clone this.PerkDefs[_perkID];
	}

	function getIsValidIcon(_bool)
	{
		return _bool ? "ui/icons/unlocked_small.png" : "ui/icons/locked_small.png";
	}

	function getPerkRequirementsUIData(_perkDefClone, _follower = null)
	{
		local requirements = [];
		if (_follower != null && !_follower.isHired())
		{
			local isValid = _follower.isHired();
			requirements.push({
				id = 3,
				type = "hint",
				text = format("Hire the %s Follower", _follower.getName()),
				icon = this.getIsValidIcon(isValid),
				isValid = isValid,
			})
		}
		if ("ToolCost" in _perkDefClone)
		{
			local ownedToolAmount = ::World.Retinue.getFollowerToolAmount();
			local toolCost = _perkDefClone.ToolCost;
			local isValid = ::World.Retinue.getFollowerToolAmount() >= toolCost;
			requirements.push({
				id = 3,
				type = "hint",
				text = format("Have %i Follower Tools (%i/%i)", toolCost, ownedToolAmount, toolCost),
				icon = this.getIsValidIcon(isValid),
				isValid = isValid,
			})
		}
		if ("RequiredPerks" in _perkDefClone)
		{
			foreach (perk in _perkDefClone.RequiredPerks)
			{
				local otherPerkDef = this.getPerk(perk);
				local isValid = _follower == null ? false : _follower.hasPerk(otherPerkDef.ID);
				requirements.push({
					id = 3,
					type = "hint",
					text = ::Reforged.Mod.Tooltips.parseString(format("Unlock the [%s|Retinue.Perk+%s] perk", otherPerkDef.Name, otherPerkDef.ID)),
					icon = this.getIsValidIcon(isValid)
					isValid = isValid,
				})
			}
		}
		if ("verifyPrerequisites" in _perkDefClone)
		{
			requirements.extend(_perkDefClone.verifyPrerequisites(_follower))
			delete _perkDefClone.verifyPrerequisites;
		}
		return requirements;
	}

	function getPerkTooltip(_data)
	{
		::MSU.Log.printData(_data, 10, true, 10);
		return this.getPerkUIData(_data.ExtraData, _data.followerId);
		// local filename = _data.ExtraData;
		// if (filename in this.PerkIDByFilename)
		// {
		// 	return this.getPerkUIData(null, ::MSU.NestedTooltips.PerkIDByFilename[_data.ExtraData]);
		// }
		// else
		// {
		// 	::logError("Nested Tooltips Framework: follower perk filename not recognized. Make sure the perk def exists in ::Reforged.Retinue.PerkIDByFilename LookupMap: " + filename);
		// 	throw ::MSU.Exception.KeyNotFound(filename);
		// }
	}

	function getPerkUIData( _perkId, _followerId = null )
	{
		local perk = this.getPerk(_perkId);
		local follower = _followerId == null ? null : ::World.Retinue.getFollower(_followerId);

		if (perk != null)
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = perk.Name
				},
				{
					id = 2,
					type = "description",
					text = perk.Tooltip
				}
			];
			ret.extend(this.getPerkRequirementsUIData(perk, follower));
			return ret;
		}

		return null;
	}
}

// Validate followerDefs
foreach(followerID, followerDef in ::Reforged.Retinue.FollowerDefs)
{
	foreach(row in followerDef.PerkTree)
	{
		for(local x = row.len() - 1; x > -1; x--)
		{
			local perkID = row[x];
			if (!(perkID in ::Reforged.Retinue.PerkDefs))
			{
				::logError(format("Reforged: Perk %s of follower %s does not exist! Removing it from the list of possible perks.", perkID, followerID));
				row.remove(x);
			}
		}
	}
}
