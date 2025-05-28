::Reforged.HooksMod.hook("scripts/ambitions/ambitions/weapon_mastery_ambition", function (q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ButtonIcon = "ui/perks/perk_rf_weapon_master.png";
	}}.create;
});
