::Reforged.HooksMod.hook("scripts/items/weapons/barbarians/drum_item", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 1;
		this.m.IconLarge = "weapons/melee/wildmen_10.png";
		this.m.Icon = "weapons/melee/wildmen_10_70x70.png";
	}
});
