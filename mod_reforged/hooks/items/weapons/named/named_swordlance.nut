::Reforged.HooksMod.hook("scripts/items/weapons/named/named_swordlance", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/oriental/swordlance";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
