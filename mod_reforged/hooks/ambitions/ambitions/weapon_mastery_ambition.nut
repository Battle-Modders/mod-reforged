::Reforged.HooksMod.hook("scripts/ambitions/ambitions/weapon_mastery_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/perks/rf_weapon_master.png";
	}
});
