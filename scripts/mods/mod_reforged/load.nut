foreach (perkGroupScript in ::IO.enumerateFiles("scripts/mods/mod_reforged/perk_groups"))
{
	::DynamicPerks.PerkGroups.add(::new(perkGroupScript));
}

foreach (perkGroupCollectionScript in ::IO.enumerateFiles("scripts/mods/mod_reforged/perk_group_collections"))
{
	::DynamicPerks.PerkGroupCategories.add(::new(perkGroupCollectionScript));
}
