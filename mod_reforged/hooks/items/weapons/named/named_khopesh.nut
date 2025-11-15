::Reforged.HooksMod.hook("scripts/items/weapons/named/named_khopesh", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/ancient/khopesh";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
