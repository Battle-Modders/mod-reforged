::Reforged.HooksMod.hook("scripts/items/weapons/named/named_crossbow", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/heavy_crossbow";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
