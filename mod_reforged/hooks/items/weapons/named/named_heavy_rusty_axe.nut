::Reforged.HooksMod.hook("scripts/items/weapons/named/named_heavy_rusty_axe", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/barbarians/heavy_rusty_axe";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
