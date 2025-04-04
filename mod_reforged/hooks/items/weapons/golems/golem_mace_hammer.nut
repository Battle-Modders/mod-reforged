::Reforged.HooksMod.hook("scripts/items/weapons/golems/golem_mace_hammer", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 3;
		// VanillaFix: Vanilla did not assign icons for these, but we need to display something for the tooltips, so we add the icon of one of those weapons
		this.m.IconLarge = "weapons/melee/mace_02.png";
		this.m.Icon = "weapons/melee/mace_02_70x70.png";

		this.addWeaponType(::Const.Items.WeaponType.Mace | ::Const.Items.WeaponType.Hammer, true);	// VanillaFix: this weapon has no weapon type assigned in vanilla
	}
});
