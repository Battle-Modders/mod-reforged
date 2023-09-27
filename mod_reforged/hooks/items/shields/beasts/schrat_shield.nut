::Reforged.HooksMod.hook("scripts/items/shields/beasts/schrat_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.IconLarge = "shields/inventory_named_shield_08.png";
		this.m.Icon = "shields/icon_named_shield_08.png";
	}
});
