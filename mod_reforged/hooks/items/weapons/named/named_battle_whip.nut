::Reforged.HooksMod.hook("scripts/items/weapons/named/named_battle_whip", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/battle_whip";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
