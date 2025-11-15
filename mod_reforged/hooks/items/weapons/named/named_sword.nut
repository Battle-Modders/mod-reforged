::Reforged.HooksMod.hook("scripts/items/weapons/named/named_sword", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/noble_sword";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
