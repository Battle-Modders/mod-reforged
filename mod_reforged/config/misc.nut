::Reforged.Misc <- {};
::Reforged.Misc.getPerkGroupsForTrainingHall <- function(_settlement)
{
	// Generate a unique set of perk groups for a training hall building based on already distributed perk groups in other buildings, if any
	// Doing this separately allows us to call it from other mods, like stronghold
	// there's like three per map so I don't think the perf hit matters
    // Returns: Array of perk group IDs to offer in this settlement's training hall

	local groupsToDistribute = {
		"pgc.rf_weapon" : [],
		"pgc.rf_armor" : [],
		"pgc.rf_fighting_style" : []
	}
	local picksPerGroup = {
		"pgc.rf_weapon" : 2,
		"pgc.rf_armor" : 1,
		"pgc.rf_fighting_style" : 1
	}

	// as perk groups dont keep a ref to their parent collection, keep a reverse map of perkGroup -> perkCollection for easy access
	local reverseMap = {};

	// create the map of the perk groups in the relevant collections
	foreach (perkGroupCategoryId, perkGroupCategory in ::DynamicPerks.PerkGroupCategories.getAll())
	{
		if (!(perkGroupCategoryId in groupsToDistribute)) continue;
		foreach (perkGroup in perkGroupCategory.getGroups())
		{
			groupsToDistribute[perkGroupCategoryId].append(perkGroup);
			reverseMap[perkGroup] <- perkGroupCategoryId;
		}
	}

	// collect the already distributed groups
	foreach (settlement in ::World.EntityManager.getSettlements())
	{
		if (settlement == _settlement) continue;
		if (!(settlement.hasBuilding("building.training_hall"))) continue;
		local perkGroupOffer = settlement.getFlags().get("rf_perkGroupOffer");
		if (!perkGroupOffer){
			::logWarning("Reforged: Settlement with Name " + settlement.getName() + " does not have perkGroupOffers!");
			continue;
		}
		perkGroupOffer = split(perkGroupOffer, ",");
		foreach (perkGroupId in perkGroupOffer)
		{
			if (!(perkGroupId in reverseMap))
			{
				::logError("Reforged: Perk Group ID in Training Hall list that no longer exists in game: " + perkGroupId);
				continue;
			}
			::MSU.Array.removeByValue(groupsToDistribute[reverseMap[perkGroupId]], perkGroupId);
		}
	}

	// choose which ones to add to this building
	local picks = [];
	foreach (categoryId, groupList in groupsToDistribute)
	{
		for (local i = 0; i < picksPerGroup[categoryId]; i++)
		{
			// If len() == 0, we have exhausted all available perks of this category, so we just re-fill the list
			// alternatively, we could pull more from the other category
			if (groupList.len() == 0) {
				groupList = clone ::DynamicPerks.PerkGroupCategories.findById(categoryId).getGroups().map(@(g) g.getID());
			}
			if (groupList.len() > 0) {
				picks.append(groupList.remove(::Math.rand(0, groupList.len() - 1)));
			}
		}
	}
	return picks;
}

::Reforged.Misc.assignPerkGroupsToTrainingHalls <- function()
{
	local allGroupsAssigned = [];
	foreach (settlement in ::World.EntityManager.getSettlements())
	{
		if (!settlement.hasBuilding("building.training_hall"))
			continue;
		local groups = this.getPerkGroupsForTrainingHall(settlement);
		settlement.getFlags().set("rf_perkGroupOffer", groups.reduce(@(a, b) a + "," + b));
		allGroupsAssigned.extend(groups);
	}
	return allGroupsAssigned;
}
