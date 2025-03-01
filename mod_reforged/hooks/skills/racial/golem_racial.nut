::Reforged.HooksMod.hook("scripts/skills/racial/golem_racial", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Name = "Golem";
		this.m.Icon = "ui/orientation/sand_golem_orientation.png";
		this.m.IsHidden = false;
		this.addType(::Const.SkillType.StatusEffect);	// We now want this effect to show up on the enemies
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
				icon = "ui/icons/campfire.png",
				text = ::MSU.Text.colorNegative("90%") + " less fire damage received"
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
				text = "Immune to fire"
			},
			{
				id = 26,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Immune to being [disarmed|Skill+disarmed_effect]")
			},
			{
				id = 27,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Immune to being [stunned|Skill+stunned_effect]")
			},
			{
				id = 28,
				type = "text",
				icon = "ui/icons/morale.png",
				text = ::Reforged.Mod.Tooltips.parseString("Not affected by [Morale|Concept.Morale]")
			}
		]);
		return ret;
	}

	q.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		actor.m.MoraleState = ::Const.MoraleState.Ignore;

		local baseProperties = actor.getBaseProperties();
		baseProperties.IsAffectedByInjuries = false;
		baseProperties.IsAffectedByNight = false;
		baseProperties.IsImmuneToBleeding = true;
		baseProperties.IsImmuneToDisarm = true;
		baseProperties.IsImmuneToFire = true;
		baseProperties.IsImmuneToPoison = true;
		baseProperties.IsImmuneToStun = true;
	}

	q.onBeingAttacked = @() function( _attacker, _skill, _properties )
	{
		if (_skill.getID() == "actives.throw_golem")
		{
			_properties.DamageReceivedTotalMult = 0.0;
			return;
		}

		local d = _skill.getDamageType();
		local mult = 0.0;
		if (d.contains(::Const.Damage.DamageType.Burning))
		{
			mult += d.getProbability(::Const.Damage.DamageType.Burning) * 0.9;
		}
		if (d.contains(::Const.Damage.DamageType.Piercing))
		{
			mult += d.getProbability(::Const.Damage.DamageType.Piercing) * (_skill.isRanged() ? 0.66 : 0.5);
		}
		if (_skill.isRanged() && d.contains(::Const.Damage.DamageType.Blunt))
		{
			mult += d.getProbability(::Const.Damage.DamageType.Blunt) * 0.66;
		}
		_properties.DamageReceivedRegularMult *= 1.0 - mult;
	}

	q.onBeforeDamageReceived = @() function( _attacker, _skill, _hitInfo, _properties )
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
