::Reforged.HooksMod.hook("scripts/skills/racial/alp_racial", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Name = "Alp";
		this.m.Icon = "ui/orientation/alp_01_orientation.png";
		this.m.IsHidden = false;
	}

	q.getTooltip <- function()
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
                icon = "ui/icons/melee_defense.png",
				text = ::MSU.Text.colorRed("66%") + " reduced cutting damage received from dogs and wolfs"
			},
			{
				id = 13,
				type = "text",
                icon = "ui/icons/health.png",
				text = "Whenever this character receives damage to Hitpoints, teleport all Alps to new random locations close to enemies"
			}
		]);
		return ret;
	}

	q.onAdded <- function()
	{
		local baseProperties = this.getContainer().getActor().getBaseProperties();

		baseProperties.IsAffectedByInjuries = false;
		baseProperties.IsAffectedByNight = false;
		baseProperties.IsImmuneToBleeding = true;
		baseProperties.IsImmuneToDisarm = true;
		baseProperties.IsImmuneToKnockBackAndGrab = true;
		baseProperties.IsImmuneToPoison = true;
	}

	q.onBeforeDamageReceived = @() function( _attacker, _skill, _hitInfo, _properties )
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
