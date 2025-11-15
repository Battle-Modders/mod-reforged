::Reforged.HooksMod.hook("scripts/items/weapons/named/named_warhammer", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/warhammer";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
