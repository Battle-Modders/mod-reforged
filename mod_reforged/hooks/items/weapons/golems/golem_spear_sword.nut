::Reforged.HooksMod.hook("scripts/items/weapons/golems/golem_spear_sword", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 5;
		// VanillaFix: Vanilla did not assign icons for these, but we need to display something for the tooltips, so we add the icon of one of those weapons
		this.m.IconLarge = "weapons/melee/spear_02.png";
		this.m.Icon = "weapons/melee/spear_02_70x70.png";

		this.addWeaponType(::Const.Items.WeaponType.Spear | ::Const.Items.WeaponType.Sword, true);	// VanillaFix: this weapon has no weapon type assigned in vanilla
	}
});
