::Reforged.HooksMod.hook("scripts/ambitions/ambitions/win_against_y_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/perks/rf_through_the_ranks.png";	// two heavy armored noble men
	}
});
