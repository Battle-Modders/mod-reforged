::Reforged.HooksMod.hook("scripts/ambitions/ambitions/allied_nobles_ambition", function (q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ButtonIcon = "ui/traits/trait_icon_58.png";		// Team Player / Handshake
	}}.create;
});
