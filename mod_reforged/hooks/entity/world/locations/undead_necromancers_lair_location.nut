::Reforged.HooksMod.hook("scripts/entity/world/locations/undead_necromancers_lair_location", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// We increase the resources to improve zombie faction progression into the lategame.
		this.m.Resources = 300; // vanilla 150
	}}.create;

	q.dropMoney = @(__original) { function dropMoney( _num, _lootTable )
	{
		__original(_num + 200, _lootTable);
	}}.dropMoney;

	q.dropTreasure = @(__original) { function dropTreasure( _num, _items, _lootTable )
	{
		_items.extend([
			"loot/golden_chalice_item",
			"loot/gemstones_item"
		]);
		__original(_num + 1, _items, _lootTable);
	}}.dropTreasure;
});
