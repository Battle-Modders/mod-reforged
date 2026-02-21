::Reforged.HooksMod.hook("scripts/items/weapons/named/named_two_handed_spiked_mace", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/barbarians/two_handed_spiked_mace";

	q.setValuesBeforeRandomize = @(__original) { function setValuesBeforeRandomize( _baseItem )
	{
		__original(_baseItem);

		// Buff damage of named barbarian 2h mace so that it is a meaningful item for the player.
		// The new values bring the damage output to be only slightly lower than named 2h mace against
		// armored opponents, and but still being noticeably lower against unarmored opponents.
		this.m.RegularDamage += 10; // Brings it to 70 from vanilla 60
 		this.m.RegularDamageMax += 15; // Brings it to 85 from vanilla 70
	}}.setValuesBeforeRandomize;

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
