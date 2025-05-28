::Reforged.HooksMod.hook("scripts/scenarios/world/lone_wolf_scenario", function(q) {
	q.onSpawnAssets = @(__original) { function onSpawnAssets()
	{
		__original();

		// In vanilla the Lone Wolf bro spawns with a Longsword, but we have reworked that weapon
		// in Reforged so we give him a weapon that is more representative of his intended start
		local items = ::World.getPlayerRoster().getAll()[0].getItems();
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Offhand));
		items.equip(::new("scripts/items/weapons/rf_greatsword"));
	}}.onSpawnAssets;
});
