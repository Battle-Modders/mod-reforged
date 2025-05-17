::Reforged.HooksMod.hook("scripts/skills/racial/skeleton_racial", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Name = "Skeleton";
		this.m.Icon = "ui/orientation/skeleton_01_orientation.png";
		this.m.IsHidden = false;
		if (this.isType(::Const.SkillType.Perk))
			this.removeType(::Const.SkillType.Perk);	// This effect having the type 'Perk' serves no purpose and only causes issues in modding
	}

	q.getTooltip = @() function()
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
				text = ::MSU.Text.colorNegative("66%") + " less ranged piercing damage received"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/campfire.png",
				text = ::MSU.Text.colorNegative("75%") + " less burning damage received"
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
				text = ::Reforged.Mod.Tooltips.parseString("Cannot receive [temporary injuries|Concept.InjuryTemporary]")
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
				text = ::Reforged.Mod.Tooltips.parseString("Immune to Poison")
			},
			{
				id = 24,
				type = "text",
				icon = "ui/icons/morale.png",
				text = ::Reforged.Mod.Tooltips.parseString("Not affected by [Morale|Concept.Morale]")

			}
		]);
		return ret;
	}

	q.onAdded = @() function()
	{
		local actor = this.getContainer().getActor();
		actor.m.MoraleState = ::Const.MoraleState.Ignore;

		local baseProperties = actor.getBaseProperties();
		baseProperties.IsAffectedByInjuries = false;
		baseProperties.IsAffectedByNight = false;
		baseProperties.IsImmuneToBleeding = true;
		baseProperties.IsImmuneToPoison = true;
	}

	q.onBeingAttacked = @() function( _attacker, _skill, _properties )
	{
		this.RF_applyDamageResistance(_attacker, _skill, null, _properties);
	}

	q.onBeforeDamageReceived = @() function( _attacker, _skill, _hitInfo, _properties )
	{
		this.RF_applyDamageResistance(_attacker, _skill, _hitInfo, _properties);
	}

	// if _skill is null only then _hitInfo is checked
	q.RF_applyDamageResistance <- function( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill != null)
		{
			local d = _skill.getDamageType();
			local mult = 0.0;
			if (d.contains(::Const.Damage.DamageType.Burning))
			{
				mult += d.getProbability(::Const.Damage.DamageType.Burning) * 0.75;
			}
			if (d.contains(::Const.Damage.DamageType.Piercing))
			{
				// This streamlines the following differences in vanilla:
				// - javelins dealing 50% damage
				// - handgonne and one-use throwing spear dealing 100% damage
				mult += d.getProbability(::Const.Damage.DamageType.Piercing) * (_skill.isRanged() ? 0.66 : 0.5);
			}

			_properties.DamageReceivedRegularMult *= 1.0 - mult;
		}
		else if (_hitInfo != null)
		{
			switch (_hitInfo.DamageType)
			{
				case null:
					break;

				case ::Const.Damage.DamageType.Burning:
					_properties.DamageReceivedRegularMult *= 0.25;
					break;

				case ::Const.Damage.DamageType.Piercing:
					_properties.DamageReceivedRegularMult *= 0.5;
			}
		}
	}
});
