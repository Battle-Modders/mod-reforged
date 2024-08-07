::Reforged.Items <- {
	function isDuelistValid( _weapon )
	{
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

	function getSkills( _item )
	{
		local copy = ::new(::IO.scriptFilenameByHash(_item.ClassNameHash));
		local player = ::MSU.getDummyPlayer();
		player.getItems().equip(copy);
		local ret = copy.getSkills();
		player.getItems().unequip(copy);
		return ret;
	}
};
