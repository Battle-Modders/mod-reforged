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
				text = "Immune to being disarmed"
			},
			{
				id = 27,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Immune to being [stunned|Skill+stunned_effect]")
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
		baseProperties.IsImmuneToFire = true;
		baseProperties.IsImmuneToPoison = true;
		baseProperties.IsImmuneToStun = true;
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
