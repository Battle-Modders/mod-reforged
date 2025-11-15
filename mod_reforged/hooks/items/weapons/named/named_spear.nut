::Reforged.HooksMod.hook("scripts/items/weapons/named/named_spear", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/fighting_spear";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
