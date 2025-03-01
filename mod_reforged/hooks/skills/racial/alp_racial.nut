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
				text = ::MSU.Text.colorNegative("50%") + " less melee piercing damage received"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::MSU.Text.colorNegative("66%") + " less ranged piercing and ranged blunt damage received"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::MSU.Text.colorNegative("66%") + " less cutting damage received from dogs and wolves"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/health.png",
				text = ::Reforged.Mod.Tooltips.parseString("Whenever this character receives damage to [Hitpoints|Concept.Hitpoints], teleport all Alps to new random locations close to enemies")
			},
			{
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Not affected by [Nighttime|Skill+night_effect]")
			},
			{
				id = 21,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Not affected by, and cannot receive, [temporary injuries|Concept.InjuryTemporary]")
			},
			{
				id = 22,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Immune to [Bleeding|Skill+bleeding_effect]")
			},
			{
				id = 23,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to Poison"
			},
			{
				id = 24,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to being knocked back or grabbed"
			},
			{
				id = 25,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Immune to being [disarmed|Skill+disarmed_effect]")
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

	q.onBeingAttacked = @() function( _attacker, _skill, _properties )
	{
		local d = _skill.getDamageType();
		if (d.contains(::Const.Damage.DamageType.Blunt))
		{
			if (_skill.isRanged())
				_properties.DamageReceivedRegularMult *= 0.33;
		}
		else if (d.contains(::Const.Damage.DamageType.Piercing))
		{
			_properties.DamageReceivedRegularMult *= _skill.isRanged() ? 0.33 : 0.5;
		}
		else if (d.contains(::Const.Damage.DamageType.Cutting))
		{
			if (_skill.getID() == "actives.wardog_bite" || _skill.getID() == "actives.wolf_bite" || _skill.getID() == "actives.warhound_bite")
			{
				_properties.DamageReceivedRegularMult *= 0.33;
			}
		}
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
