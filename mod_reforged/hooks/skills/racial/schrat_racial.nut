::mods_hookExactClass("skills/racial/schrat_racial", function(o) {
	o.onBeforeDamageReceived = function( _attacker, _skill, _hitInfo, _properties )
	{
		switch (_hitInfo.DamageType)
		{
			case null:
				break;

			case ::Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 1.33;
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
							if (_skill.getItem().isWeaponType(::Const.Items.WeaponType.Throwing))
							{
								_properties.DamageReceivedRegularMult *= 0.5;
							}
							else
							{
								_properties.DamageReceivedRegularMult *= 0.25;
							}
						}
					}
				}
				break;
		}
	}

	// We exported everything this function does into its own effect (rf_sapling_harvest).
	// By overwriting this method we also nullify all other mods hooking into this before us but there is clean solution to this
	o.onDamageReceived = function( _attacker, _damageHitpoints, _damageArmor ) {};
});
