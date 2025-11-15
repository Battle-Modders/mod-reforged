::Reforged.HooksMod.hook("scripts/items/weapons/named/named_crypt_cleaver", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/ancient/crypt_cleaver";

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
