::Reforged.HooksMod.hook("scripts/items/weapons/named/named_goblin_falchion", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/greenskins/goblin_falchion";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
