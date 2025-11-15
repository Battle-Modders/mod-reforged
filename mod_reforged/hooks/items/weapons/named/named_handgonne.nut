::Reforged.HooksMod.hook("scripts/items/weapons/named/named_handgonne", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/oriental/handgonne";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
