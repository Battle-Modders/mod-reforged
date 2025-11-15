::Reforged.HooksMod.hook("scripts/items/weapons/named/named_two_handed_scimitar", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/oriental/two_handed_scimitar";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
