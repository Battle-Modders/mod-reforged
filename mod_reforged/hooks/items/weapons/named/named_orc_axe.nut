::Reforged.HooksMod.hook("scripts/items/weapons/named/named_orc_axe", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/greenskins/orc_axe";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
