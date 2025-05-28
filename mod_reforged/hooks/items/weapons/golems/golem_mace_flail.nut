::Reforged.HooksMod.hook("scripts/items/weapons/golems/golem_mace_flail", function(q) {
	::Reforged.HooksHelper.dualWeapon(q);
});

::Reforged.HooksMod.hook("scripts/items/weapons/golems/golem_mace_flail", function(q) {
	q.m.Weapon1 = "scripts/items/weapons/bludgeon";
	q.m.Weapon2 = "scripts/items/weapons/reinforced_wooden_flail";

	q.create = @(__original) { function create()
	{
		__original();
		// VanillaFix: Vanilla did not assign icons for these, but we need to display something for the tooltips, so we add the icon of one of those weapons
		this.m.IconLarge = "weapons/melee/flail_03.png";
		this.m.Icon = "weapons/melee/flail_03_70x70.png";
	}}.create;

	q.RF_getWeaponForSkill = @() { function RF_getWeaponForSkill( _skill )
	{
		switch (_skill.ClassName)
		{
			case "golem_bash_skill":
			case "golem_knock_out_skill":
				return this.m.Weapon1;

			case "golem_lash_skill":
				return this.m.Weapon2;
		}
	}}.RF_getWeaponForSkill;
});
