::mods_hookExactClass("skills/racial/golem_racial", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Name = "Golem";
		this.m.Icon = "ui/orientation/sand_golem_orientation.png";
		this.m.IsHidden = false;
		this.addType(::Const.SkillType.StatusEffect);	// We now want this effect to show up on the enemies
	}

	o.getTooltip <- function()
	{
		local ret = this.skill.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
                icon = "ui/icons/melee_defense.png",
				text = ::MSU.Text.colorRed("50%") + " reduced melee piercing damage received"
			},
			{
				id = 11,
				type = "text",
                icon = "ui/icons/ranged_defense.png",
				text = ::MSU.Text.colorRed("66%") + " reduced ranged piercing and ranged blunt damage received"
			},
			{
				id = 12,
				type = "text",
                icon = "ui/icons/campfire.png",
				text = ::MSU.Text.colorRed("90%") + " reduced fire damage received"
			}
		]);
		return ret;
	}

	o.onAdded <- function()
	{
		local baseProperties = this.getContainer().getActor().getBaseProperties();

		baseProperties.IsAffectedByInjuries = false;
		baseProperties.IsAffectedByNight = false;
		baseProperties.IsImmuneToBleeding = true;
		baseProperties.IsImmuneToDisarm = true;
		baseProperties.IsImmuneToFire = true;
		baseProperties.IsImmuneToPoison = true;
		baseProperties.IsImmuneToStun = true;
	}

	o.onBeforeDamageReceived = function( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill != null && _skill.getID() == "actives.throw_golem")
		{
			_properties.DamageReceivedTotalMult = 0.0;
			return;
		}

		switch (_hitInfo.DamageType)
		{
			case null:
				break;

			case ::Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 0.1;
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
							javelins and handgonne dealing only 25% damage
							one-use throwing spear dealing 100% damage
						*/
					}
					else
					{
						_properties.DamageReceivedRegularMult *= 0.5;
					}
				}
				break;
		}
	}
});
