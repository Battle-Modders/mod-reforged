::Reforged.HooksMod.hook("scripts/items/weapons/named/named_mace", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/winged_mace";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
