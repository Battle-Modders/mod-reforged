::Reforged.HooksMod.hook("scripts/items/weapons/named/named_battle_whip", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/battle_whip";
		__original();
	}
});
