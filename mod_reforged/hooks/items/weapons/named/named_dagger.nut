::Reforged.HooksMod.hook("scripts/items/weapons/named/named_dagger", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/rondel_dagger";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
