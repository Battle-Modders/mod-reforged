::Reforged.HooksMod.hook("scripts/items/weapons/golems/golem_spear_sword", function(q) {
	::Reforged.HooksHelper.dualWeapon(q);
});

::Reforged.HooksMod.hook("scripts/items/weapons/golems/golem_spear_sword", function(q) {
	q.m.Weapon1 = "scripts/items/weapons/militia_spear";
	q.m.Weapon2 = "scripts/items/weapons/shortsword";

	q.create = @(__original) function()
	{
		__original();
		// VanillaFix: Vanilla did not assign icons for these, but we need to display something for the tooltips, so we add the icon of one of those weapons
		this.m.IconLarge = "weapons/melee/spear_02.png";
		this.m.Icon = "weapons/melee/spear_02_70x70.png";
	}

	q.RF_getWeaponForSkill = @() function( _skill )
	{
		switch (_skill.ClassName)
		{
			case "golem_thrust_skill":
				return this.m.Weapon1;

			case "golem_slash_skill":
				return this.m.Weapon2;
		}
	}
});
