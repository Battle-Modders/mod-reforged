::Reforged.HooksMod.hook("scripts/items/weapons/named/named_two_handed_spiked_mace", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/barbarians/two_handed_spiked_mace";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
