::Reforged.HooksMod.hook("scripts/items/weapons/named/named_poleaxe", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/poleaxe";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
