::Reforged.HooksMod.hook("scripts/items/weapons/named/named_throwing_axe", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/throwing_axe";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
