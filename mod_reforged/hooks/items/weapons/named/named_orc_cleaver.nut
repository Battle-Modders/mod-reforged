::Reforged.HooksMod.hook("scripts/items/weapons/named/named_orc_cleaver", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/greenskins/orc_cleaver";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
