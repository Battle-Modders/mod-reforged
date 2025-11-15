::Reforged.HooksMod.hook("scripts/items/weapons/named/named_bladed_pike", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/ancient/bladed_pike";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
