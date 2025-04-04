::Reforged.HooksMod.hook("scripts/items/weapons/golems/golem_mace_flail", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// VanillaFix: Vanilla did not assign icons for these, but we need to display something for the tooltips, so we add the icon of one of those weapons
		this.m.IconLarge = "weapons/melee/flail_03.png";
		this.m.Icon = "weapons/melee/flail_03_70x70.png";

		this.m.Reach = 3;
		this.addWeaponType(::Const.Items.WeaponType.Mace | ::Const.Items.WeaponType.Flail, true);	// VanillaFix: this weapon has no weapon type assigned in vanilla
	}
});
