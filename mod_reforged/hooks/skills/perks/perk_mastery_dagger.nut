::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_dagger", function(q) {
	q.onAnySkillUsed = @(__original) { function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);

		if (_targetEntity == null || _targetEntity.isTurnStarted() || _targetEntity.isTurnDone() || _skill.isRanged() || !_skill.isAttack() || !::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
			return;

		local weapon = _skill.getItem();
		if (!::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(::Const.Items.WeaponType.Dagger))
		{
			_properties.OffensiveReachIgnore += 999; // Basically ignore all reach disadvantage when attacking
		}
	}}.onAnySkillUsed;
});
