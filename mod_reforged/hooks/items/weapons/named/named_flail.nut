::Reforged.HooksMod.hook("scripts/items/weapons/named/named_flail", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/flail";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
