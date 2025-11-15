::Reforged.HooksMod.hook("scripts/items/weapons/named/named_goblin_spear", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/greenskins/goblin_spear";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
