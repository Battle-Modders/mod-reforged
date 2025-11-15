::Reforged.HooksMod.hook("scripts/items/weapons/named/named_fencing_sword", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/fencing_sword";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
