::Reforged.HooksMod.hook("scripts/ambitions/ambitions/defeat_kraken_ambition", function (q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ButtonIcon = "ui/orientation/kraken_01_orientation.png";		// Kraken Face
	}}.create;
});
