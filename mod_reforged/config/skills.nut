::Reforged.Skills <- {
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

	function addPerkGroupOfEquippedWeapon( _entity, _maxTier = 7 )
	{
		local weapon = _entity.getMainhandItem();
		if (weapon == null) return;

		local trees = [];

		if (weapon.isWeaponType(this.Const.Items.WeaponType.Axe))
		{
			trees.push("pg.rf_axe");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Bow))
		{
			trees.push("pg.rf_bow");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Cleaver))
		{
			trees.push("pg.rf_cleaver");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow) || weapon.isWeaponType(::Const.Items.WeaponType.Firearm))
		{
			trees.push("pg.rf_crossbow");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Dagger))
		{
			trees.push("pg.rf_dagger");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Flail))
		{
			trees.push("pg.rf_flail");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Hammer))
		{
			trees.push("pg.rf_hammer");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Mace))
		{
			trees.push("pg.rf_mace");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Polearm))
		{
			trees.push("pg.rf_polearm");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Spear))
		{
			trees.push("pg.rf_spear");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Sword))
		{
			trees.push("pg.rf_sword");
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Throwing))
		{
			trees.push("pg.rf_throwing");
		}

		if (trees.len() == 0)
			return;

		this.addPerkGroup(_entity, ::MSU.Array.rand(trees), _maxTier);
	}

	function addMasteryOfEquippedWeapon( _entity )
	{
		local weapon = _entity.getMainhandItem();
		if (weapon == null) return;

		if (weapon.isWeaponType(this.Const.Items.WeaponType.Axe))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_axe"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Bow))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_bow"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Cleaver))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_cleaver"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow) || weapon.isWeaponType(::Const.Items.WeaponType.Firearm))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_crossbow"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Dagger))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_dagger"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Flail))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_flail"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Hammer))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_hammer"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Mace))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_mace"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Polearm))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_polearm"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Spear))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_spear"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Sword))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_sword"));
		}
		if (weapon.isWeaponType(this.Const.Items.WeaponType.Throwing))
		{
			_entity.getSkills().add(::new("scripts/skills/perks/perk_mastery_throwing"));
		}
	}
};
