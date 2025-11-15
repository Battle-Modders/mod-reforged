::Reforged.HooksMod.hook("scripts/items/weapons/named/named_cleaver", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/military_cleaver";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
