::mods_hookExactClass("skills/racial/alp_racial", function(o) {
	o.onBeforeDamageReceived = function( _attacker, _skill, _hitInfo, _properties )
	{
		switch (_hitInfo.DamageType)
		{
			case null:
				break;

			case ::Const.Damage.DamageType.Blunt:
				if (_skill != null)
				{
					if (_skill.isRanged())	// In Vanilla this reduction only exists for slinging of stones. Here it expands to bolas and potential future blunt ranged attacks
					{
						_properties.DamageReceivedRegularMult *= 0.33;
					}
				}
				break;

			case ::Const.Damage.DamageType.Piercing:
				if (_skill == null)
				{
					_properties.DamageReceivedRegularMult *= 0.5;
				}
				else
				{
					if (_skill.isRanged())
					{
						_properties.DamageReceivedRegularMult *= 0.33;
						/* This streamlines the following differences in vanilla:
							Arrows dealing only 10% damage
							javelins dealing only 25% damage
							handgonne & one-use throwing spear dealing 50% damage
						*/
					}
					else
					{
						_properties.DamageReceivedRegularMult *= 0.5;
					}
				}
				break;

			case ::Const.Damage.DamageType.Cutting:
				// Maybe replace this with some sort of isAnimal or isBeast check on the attacker?
				if (_skill != null && (_skill.getID() == "actives.wardog_bite" || _skill.getID() == "actives.wolf_bite" || _skill.getID() == "actives.warhound_bite"))
				{
					_properties.DamageReceivedRegularMult *= 0.33;
				}
				break;
		}
	}
});
