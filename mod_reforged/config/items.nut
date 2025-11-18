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
		local data = ::MSU.Class.SerializationData();
		_item.onSerialize(data.getSerializationEmulator());

		local cloneItem = ::new(::IO.scriptFilenameByHash(_item.ClassNameHash));
		cloneItem.onDeserialize(data.getDeserializationEmulator());

		local container = ::MSU.getDummyPlayer().getItems();
		local existingItem = container.getItemAtSlot(cloneItem.getSlotType());
		if (existingItem != null)
		{
			container.unequip(existingItem);
		}

		container.equip(cloneItem);
		local ret = cloneItem.getSkills();
		container.unequip(cloneItem);

		if (existingItem != null)
		{
			container.equip(existingItem);
		}

		// Set the item of the skills to the original _item
		// because cloneItem will become null at the end of this function
		// and skill.m.Item is kept as a WeakTableRef.
		foreach (s in ret)
		{
			s.setItem(_item);
		}

		return ret;
	}
};
