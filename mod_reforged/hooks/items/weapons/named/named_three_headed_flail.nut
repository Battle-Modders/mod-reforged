::Reforged.HooksMod.hook("scripts/items/weapons/named/named_three_headed_flail", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/three_headed_flail";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
