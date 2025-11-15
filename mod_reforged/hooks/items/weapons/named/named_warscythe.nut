::Reforged.HooksMod.hook("scripts/items/weapons/named/named_warscythe", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/ancient/warscythe";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
