::Reforged.HooksMod.hook("scripts/items/weapons/named/named_polemace", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/oriental/polemace";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
