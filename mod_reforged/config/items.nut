::Reforged.Items <- {
	function isDuelistValid( _weapon )
	{
		if (!_weapon.isItemType(::Const.Items.ItemType.MeleeWeapon))
			return false;

		local function isSkillValid( _skill )
		{
			return _skill.getBaseValue("ActionPointCost") <= 4 && _skill.isDuelistValid();
		}

		if (_weapon.isEquipped())
			return isSkillValid(_weapon.getContainer().getActor().getSkills().getAttackOfOpportunity());

		local copy = ::new(::IO.scriptFilenameByHash(_weapon.ClassNameHash));
		local player = ::MSU.getDummyPlayer();
		player.getItems().equip(copy);
		local ret = isSkillValid(player.getSkills().getAttackOfOpportunity());
		player.getItems().unequip(copy);
		return ret;
	}

	// This function is used to get the skills of an item that one gets from equipping the item.
	function getSkills( _item )
	{
		local ret = [];

		local player = ::MSU.getDummyPlayer();

		// Switcheroo addSkill to push the skill to our return array instead of adding it to the container
		local addSkill = _item.addSkill;
		_item.addSkill = @( _skill ) ret.push(_skill);

		// Switcheroo to prevent addition of the generic_item skill as we don't want that in the returned array
		local addGenericItemSkill = _item.addGenericItemSkill;
		_item.addGenericItemSkill = @() null;

		// Switcheroo player.onAppearanceChanged and item.updateAppearance to do nothing for performance reasons
		local onAppearanceChanged = player.onAppearanceChanged;
		player.onAppearanceChanged = @(...) null;

		local updateAppearance = _item.updateAppearance;
		_item.updateAppearance = @(...) null;

		// Switcheroo the container of the item to that of the dummy player
		local originalItemContainer = _item.m.Container;
		_item.m.Container = player.getItems();

		// Store the last equipped by faction field to revert it later
		local lastEquippedByFaction = _item.m.LastEquippedByFaction;

		_item.onEquip();

		// Revert all switcheroos
		_item.addSkill = addSkill;
		_item.addGenericItemSkill = addGenericItemSkill;
		player.onAppearanceChanged = onAppearanceChanged;
		_item.updateAppearance = updateAppearance;
		_item.m.Container = originalItemContainer;
		_item.m.LastEquippedByFaction = lastEquippedByFaction;

		return ret;
	}

	// Converts a weapon with Polearm WeaponType into a regular WeaponType e.g. Axe or Spear
	function convertPolearmWeapon( _weapon )
	{
		foreach (s in this.getSkills(_weapon))
		{
			if (!s.isIgnoredAsAOO())
			{
				local damageType = s.getDamageType();
				if (damageType.contains(::Const.Damage.DamageType.Cutting))
				{
					_weapon.setWeaponType(::Const.Items.WeaponType.Axe);
				}
				else if (damageType.contains(::Const.Damage.DamageType.Piercing))
				{
					_weapon.setWeaponType(::Const.Items.WeaponType.Spear);
				}
				else if (damageType.contains(::Const.Damage.DamageType.Blunt))
				{
					_weapon.setWeaponType(::Const.Items.WeaponType.Mace);
				}

				return;
			}
		}
	}
};
