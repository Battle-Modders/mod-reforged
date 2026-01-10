::Reforged.HooksMod.hook("scripts/items/weapons/named/named_warbrand", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/warbrand";

	q.setValuesBeforeRandomize = @(__original) { function setValuesBeforeRandomize( _baseItem )
	{
		__original(_baseItem);

		// Buff the damage of named warbrand to make it more relevant as a named item for players.
		// This should make it somewhat comparable to named Longsword or Kriegsmesser with slightly
		// less damage but higher reach than them and having AOE capabilities.
		this.m.RegularDamage += 15; // Brings it to 65 from vanilla 50
		this.m.RegularDamageMax += 5; // Brings it to 80 from vanilla 75
	}}.setValuesBeforeRandomize;

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
