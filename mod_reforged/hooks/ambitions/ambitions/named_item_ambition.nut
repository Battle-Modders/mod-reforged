::Reforged.HooksMod.hook("scripts/ambitions/ambitions/named_item_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/backgrounds/background_06.png";		// Noble / Sword + Crown
	}
});
