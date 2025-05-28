::Reforged.HooksMod.hook("scripts/items/weapons/golems/golem_cleaver_hammer", function(q) {
	::Reforged.HooksHelper.dualWeapon(q);
});

::Reforged.HooksMod.hook("scripts/items/weapons/golems/golem_cleaver_hammer", function(q) {
	q.m.Weapon1 = "scripts/items/weapons/butchers_cleaver";
	q.m.Weapon2 = "scripts/items/weapons/pickaxe";

	q.create = @(__original) { function create()
	{
		__original();
		// VanillaFix: Vanilla did not assign icons for these, but we need to display something for the tooltips, so we add the icon of one of those weapons
		this.m.IconLarge = "weapons/melee/miners_pick_01.png";
		this.m.Icon = "weapons/melee/miners_pick_01_70x70.png";
	}}.create;

	q.RF_getWeaponForSkill = @() { function RF_getWeaponForSkill( _skill )
	{
		switch (_skill.ClassName)
		{
			case "golem_cleave_skill":
			case "golem_decapitate_skill":
				return this.m.Weapon1;

			case "golem_batter_skill":
				return this.m.Weapon2;
		}
	}}.RF_getWeaponForSkill;
});
