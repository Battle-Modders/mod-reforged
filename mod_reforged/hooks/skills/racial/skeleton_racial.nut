::mods_hookExactClass("skills/skill/skeleton_racial", function(o) {
	o.onBeforeDamageReceived = function( _attacker, _skill, _hitInfo, _properties )
	{
		switch (_hitInfo.DamageType)
		{
			case null:
				break;

			case ::Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 0.25;
				break;

			case ::Const.Damage.DamageType.Piercing:
				if (_skill != null)
				{
					if (_skill.isRanged())
					{
						if (::MSU.isNull(_skill.getItem()))
						{
							_properties.DamageReceivedRegularMult *= 0.33;
						}
						else if (!_skill.getItem().isItemType(::Const.Items.ItemType.Weapon))
						{
							_properties.DamageReceivedRegularMult *= 0.33;
						}
						else
						{
							if (_skill.getItem().isWeaponType(::Const.Items.WeaponType.Bow))
							{
								_properties.DamageReceivedRegularMult *= 0.1;
							}
							else if (_skill.getItem().isWeaponType(::Const.Items.WeaponType.Crossbow) || _skill.getItem().isWeaponType(::Const.Items.WeaponType.Firearm))
							{
								_properties.DamageReceivedRegularMult *= 0.33;
							}
							else if (_skill.getItem().isWeaponType(::Const.Items.WeaponType.Throwing))
							{
								if (_skill.getID() == "actives.throw_spear") _properties.DamageReceivedRegularMult *= 0.5;
								else _properties.DamageReceivedRegularMult *= 0.25;
							}
						}
					}
					else
					{
						if (::MSU.isNull(_skill.getItem()))
						{
							_properties.DamageReceivedRegularMult *= 0.33;
						}
						else if (!_skill.getItem().isItemType(::Const.Items.ItemType.Weapon))
						{
							_properties.DamageReceivedRegularMult *= 0.33;
						}
						else
						{
							_properties.DamageReceivedRegularMult *= 0.5;
						}
					}
				}
				break;
		}
	}
});
