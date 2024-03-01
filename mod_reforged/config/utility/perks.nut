::Reforged.Utility  <- {}

::Reforged.Utility.Perks <- {
	function getRefundablePerks( _actor )
	{
		return _actor.getSkills().getSkillsByFunction(@(skill) skill.isType(::Const.SkillType.Perk) && skill.isRefundable() && (skill.getItem() == null));
	}

	function refundPerk( _actor, _perk )
	{
		_perk.removeSelf();

		_actor.m.PerkPoints++;
		_actor.m.PerkPointsSpent--;
		_actor.setPerkTier(::Math.max(_actor.getPerkTier() - 1, ::DynamicPerks.Const.DefaultPerkTier));
	}
}
