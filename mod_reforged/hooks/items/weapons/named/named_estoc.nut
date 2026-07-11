::Reforged.HooksMod.hook("scripts/items/weapons/named/named_estoc", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/estoc";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
