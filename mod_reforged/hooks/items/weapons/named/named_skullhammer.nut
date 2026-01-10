::Reforged.HooksMod.hook("scripts/items/weapons/named/named_skullhammer", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/barbarians/skull_hammer";

	q.setValuesBeforeRandomize = @(__original) { function setValuesBeforeRandomize( _baseItem )
	{
		__original(_baseItem);

		// Buff damage of named barbarian 2h hammer so that it is a meaningful item for the player.
		// The new values bring the damage output to be comparable to named 2h mace against
		// armored opponents, and but being lower against unarmored opponents.
		this.m.RegularDamage += 10; // Brings it to 55 from vanilla 45
 		this.m.RegularDamageMax += 10; // Brings it to 75 from vanilla 65
	}}.setValuesBeforeRandomize;

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
