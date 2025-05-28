::Reforged.HooksMod.hook("scripts/ambitions/ambitions/defeat_orc_location_ambition", function (q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ButtonIcon = "ui/perks/perk_33.png";		// Anticipation / Orc face within Ironsights
	}}.create;
});
