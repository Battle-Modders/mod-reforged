::Reforged.HooksMod.hook("scripts/ambitions/ambitions/defeat_beasts_ambition", function (q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ButtonIcon = "ui/traits/trait_icon_51.png";		// Hate against Beasts
	}}.create;
});
