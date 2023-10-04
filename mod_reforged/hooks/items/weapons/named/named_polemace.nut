::Reforged.HooksMod.hook("scripts/items/weapons/named/named_polemace", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/oriental/polemace";
		__original();
	}
});
