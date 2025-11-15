::Reforged.HooksMod.hook("scripts/items/weapons/named/named_qatal_dagger", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/oriental/qatal_dagger";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
