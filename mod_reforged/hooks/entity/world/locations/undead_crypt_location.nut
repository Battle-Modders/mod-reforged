::Reforged.HooksMod.hook("scripts/entity/world/locations/undead_crypt_location", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// We increase the resources to improve zombie faction progression into the lategame.
		this.m.Resources = 230; // vanilla 180
	}}.create;

	q.dropMoney = @(__original) { function dropMoney( _num, _lootTable )
	{
		__original(::Math.floor(_num * 1.5), _lootTable);
	}}.dropMoney;

	q.dropTreasure = @(__original) { function dropTreasure( _num, _items, _lootTable )
	{
		__original(_num + 1, _items, _lootTable);
	}}.dropTreasure;
});
