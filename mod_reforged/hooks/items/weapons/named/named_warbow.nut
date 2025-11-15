::Reforged.HooksMod.hook("scripts/items/weapons/named/named_warbow", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/war_bow";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
