::Reforged.HooksMod.hook(::DynamicPerks.Class.PerkTree, function(q) {
	q.addItemMultipliers = @(__original) function( _multipliers )
	{
		__original(_multipliers);
		local weapon = this.getActor().getMainhandItem();
		if (weapon != null)
		{
			local ids = [];

			if (weapon.isWeaponType(::Const.Items.WeaponType.Axe))
			{
				ids.push("pg.rf_axe");
			}
			if (weapon.isWeaponType(::Const.Items.WeaponType.Bow))
			{
				ids.push("pg.rf_bow");
			}
			if (weapon.isWeaponType(::Const.Items.WeaponType.Cleaver))
			{
				ids.push("pg.rf_cleaver");
			}
			if (weapon.isWeaponType(::Const.Items.WeaponType.Crossbow) || weapon.isWeaponType(::Const.Items.WeaponType.Firearm))
			{
				ids.push("pg.rf_crossbow");
			}
			if (weapon.isWeaponType(::Const.Items.WeaponType.Dagger))
			{
				ids.push("pg.rf_dagger");
			}
			if (weapon.isWeaponType(::Const.Items.WeaponType.Flail))
			{
				ids.push("pg.rf_flail");
			}
			if (weapon.isWeaponType(::Const.Items.WeaponType.Hammer))
			{
				ids.push("pg.rf_hammer");
			}
			if (weapon.isWeaponType(::Const.Items.WeaponType.Mace))
			{
				ids.push("pg.rf_mace");
			}
			if (weapon.isWeaponType(::Const.Items.WeaponType.Polearm))
			{
				ids.push("pg.rf_polearm");
			}
			if (weapon.isWeaponType(::Const.Items.WeaponType.Spear))
			{
				ids.push("pg.rf_spear");
			}
			if (weapon.isWeaponType(::Const.Items.WeaponType.Sword))
			{
				ids.push("pg.rf_sword");
			}
			if (weapon.isWeaponType(::Const.Items.WeaponType.Throwing))
			{
				ids.push("pg.rf_throwing");
			}

			switch (ids.len())
			{
				case 0:
					break;

				case 1:
					_multipliers[ids[0]] <- -1;
					break;

				default:
					_multipliers[::MSU.Array.rand(ids)] <- -1;
			}
		}
	}
});
