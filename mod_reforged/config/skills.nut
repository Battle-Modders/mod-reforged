::Reforged.Skills <- {
	function getPerkGroupMultiplier_MeleeOnly( _groupID, _perkTree )
	{
		switch (_groupID)
		{
			case "pg.rf_bow":
			case "pg.rf_crossbow":
			case "pg.rf_throwing":
			case "pg.rf_ranged":
				return 0;
		}
	}

	function addPerkGroup( _entity, _perkGroupID, _maxTier = 7 )
	{
		foreach (i, row in ::DynamicPerks.PerkGroups.findById(_perkGroupID).getTree())
		{
			if (i >= _maxTier) return;

			foreach (perkID in row)
			{
				_entity.getSkills().add(::new(::Const.Perks.findById(perkID).Script));
			}
		}
	}

	function addPerkGroupOfWeapon( _entity, _weapon, _maxTier = 7 )
	{
		local trees = [];

		if (_weapon.isWeaponType(::Const.Items.WeaponType.Axe))
		{
			trees.push("pg.rf_axe");
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Bow))
		{
			trees.push("pg.rf_bow");
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Cleaver))
		{
			trees.push("pg.rf_cleaver_enemy");
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Crossbow) || _weapon.isWeaponType(::Const.Items.WeaponType.Firearm))
		{
			trees.push("pg.rf_crossbow");
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Dagger))
		{
			trees.push("pg.rf_dagger");
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Flail))
		{
			trees.push("pg.rf_flail");
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Hammer))
		{
			trees.push("pg.rf_hammer");
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Mace))
		{
			trees.push("pg.rf_mace");
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Polearm))
		{
			trees.push("pg.rf_polearm");
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Spear))
		{
			trees.push("pg.rf_spear");
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Sword))
		{
			trees.push("pg.rf_sword");
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Throwing))
		{
			trees.push("pg.rf_throwing");
		}

		if (trees.len() == 0)
			return;

		this.addPerkGroup(_entity, ::MSU.Array.rand(trees), _maxTier);
	}

	function addPerkGroupOfEquippedWeapon( _entity, _maxTier = 7 )
	{
		local weapon = _entity.getMainhandItem();
		if (weapon != null) this.addPerkGroupOfWeapon(_entity, weapon, _maxTier);
	}

	function addMasteryOfWeapon( _entity, _weapon )
	{
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Axe))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_axe"));
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Bow))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_bow"));
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Cleaver))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_cleaver"));
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Crossbow) || _weapon.isWeaponType(::Const.Items.WeaponType.Firearm))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_crossbow"));
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Dagger))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_dagger"));
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Flail))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_flail"));
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Hammer))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_hammer"));
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Mace))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_mace"));
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Polearm))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_polearm"));
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Spear))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_spear"));
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Sword))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_sword"));
		}
		if (_weapon.isWeaponType(::Const.Items.WeaponType.Throwing))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_throwing"));
		}
	}

	function addMasteryOfEquippedWeapon( _entity )
	{
		local weapon = _entity.getMainhandItem();
		if (weapon != null) this.addMasteryOfWeapon(_entity, weapon);

	}
};
