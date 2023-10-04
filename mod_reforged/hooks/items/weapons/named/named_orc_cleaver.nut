::Reforged.HooksMod.hook("scripts/items/weapons/named/named_orc_cleaver", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/greenskins/orc_cleaver";
		__original();
	}
});
