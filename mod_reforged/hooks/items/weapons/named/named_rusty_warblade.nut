::Reforged.HooksMod.hook("scripts/items/weapons/named/named_rusty_warblade", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/barbarians/rusty_warblade";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
