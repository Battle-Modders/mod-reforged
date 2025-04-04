::Reforged.HooksMod.hook("scripts/items/weapons/golems/golem_cleaver_hammer", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// VanillaFix: Vanilla did not assign icons for these, but we need to display something for the tooltips, so we add the icon of one of those weapons
		this.m.IconLarge = "weapons/melee/miners_pick_01.png";
		this.m.Icon = "weapons/melee/miners_pick_01_70x70.png";

		this.m.Reach = 3;
		this.addWeaponType(::Const.Items.WeaponType.Cleaver | ::Const.Items.WeaponType.Hammer, true);	// VanillaFix: this weapon has no weapon type assigned in vanilla
	}
});
