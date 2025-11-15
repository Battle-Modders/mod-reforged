::Reforged.HooksMod.hook("scripts/items/weapons/named/named_skullhammer", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/barbarians/skull_hammer";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
