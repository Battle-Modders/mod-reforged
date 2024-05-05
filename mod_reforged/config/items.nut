::Reforged.Items <- {
	function isDuelistValid( _weapon )
	{
		if (_weapon.isEquipped())
			return _weapon.getContainer().getActor().getSkills().getAttackOfOpportunity().isDuelistValid();

		local copy = ::new(::IO.scriptFilenameByHash(_weapon.ClassNameHash));
		local player = ::MSU.getDummyPlayer();
		player.equip(copy);
		local ret = player.getSkills().getAttackOfOpportunity().isDuelistValid();
		player.unequip(copy);
		return ret;
	}

	function getSkills( _item )
	{
		if (_item.isEquipped())
			return _item.getSkills();

		local copy = ::new(::IO.scriptFilenameByHash(_item.ClassNameHash));
		local player = ::MSU.getDummyPlayer();
		player.equip(copy);
		local ret = copy.getSkills();
		player.unequip(copy);
		return ret;
	}
};
