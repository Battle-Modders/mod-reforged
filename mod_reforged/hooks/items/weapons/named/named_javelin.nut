::Reforged.HooksMod.hook("scripts/items/weapons/named/named_javelin", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/javelin";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
