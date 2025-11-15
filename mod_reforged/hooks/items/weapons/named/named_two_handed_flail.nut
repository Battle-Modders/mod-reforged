::Reforged.HooksMod.hook("scripts/items/weapons/named/named_two_handed_flail", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/two_handed_flail";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
