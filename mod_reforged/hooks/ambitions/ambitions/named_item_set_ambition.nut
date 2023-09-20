::Reforged.HooksMod.hook("scripts/ambitions/ambitions/named_item_set_ambition", function (q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ButtonIcon = "ui/perks/rf_weapon_master.png";		// Crown + 3 Weapons
	}
});
