::Reforged.HooksMod.hook("scripts/skills/perks/perk_duelist", function(q) {
	q.onUpdate = @() { function onUpdate( _properties )
	{
		local shield = this.getContainer().getActor().getOffhandItem();
		if (shield != null && shield.isItemType(::Const.Items.ItemType.Shield))
		{
			_properties.OffensiveReachIgnore += shield.getReachIgnore();
		}
	}}.onUpdate;

	q.isEnabled <- { function isEnabled()
	{
		local aoo = this.getContainer().getAttackOfOpportunity();
		return aoo != null && aoo.isDuelistValid();
	}}.isEnabled;

	q.onAnySkillUsed = @() { function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!_skill.isDuelistValid())
			return;

		local weapon = _skill.getItem();
		if (weapon == null || !weapon.isItemType(::Const.Items.ItemType.Weapon) || !::Reforged.Items.isDuelistValid(weapon))
			return;

		if (weapon.isItemType(::Const.Items.ItemType.OneHanded))
		{
			_properties.DamageDirectAdd += 0.25;
			if (this.getContainer().getActor().isArmedWithShield())
			{
				_properties.DamageDirectAdd += 0.1;
			}
		}
		else
		{
			_properties.DamageDirectAdd += 0.15;
		}
	}}.onAnySkillUsed;
});
