foreach (perkGroupScript in ::IO.enumerateFiles("scripts/mods/mod_reforged/perk_groups"))
{
	::DPF.Perks.PerkGroups.add(::new(perkGroupScript));
}

foreach (perkGroupCollectionScript in ::IO.enumerateFiles("scripts/mods/mod_reforged/perk_group_collections"))
{
	::DPF.Perks.PerkGroupCategories.add(::new(perkGroupCollectionScript));
}

::DPF.Perks.addPerkGroupToTooltips();
