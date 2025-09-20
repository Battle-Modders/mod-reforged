::Reforged.HooksMod.hook("scripts/skills/racial/schrat_racial", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Name = "Schrat";
		this.m.Icon = "ui/orientation/schrat_01_orientation.png";
		this.m.IsHidden = false;
	}}.create;

	q.isHidden = @(__original) { function isHidden()	// In Vanilla this skill is only shown while the Schrat has a shield
	{
		return this.skill.isHidden();
	}}.isHidden;

	q.getName = @() { function getName()
	{
		if (this.getContainer().getActor().isArmedWithShield()) return (this.skill.getName() + " (Shielded)");
		return this.skill.getName();
	}}.getName;

	q.getTooltip = @() { function getTooltip()
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
				text = ::MSU.Text.colorNegative("75%") + " less ranged piercing damage received"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/campfire.png",
				text = ::MSU.Text.colorPositive("100%") + " more burning damage received"
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
			},
			{
				id = 26,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Immune to being [rooted|Concept.Rooted]")
			},
			{
				id = 27,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Immune to being [stunned|Skill+stunned_effect]")
			}
		]);
		if (this.getContainer().getActor().isArmedWithShield())
		{
			ret.push({
				id = 30,
				type = "text",
				icon = "skills/status_effect_86.png",
				text = ::MSU.Text.colorNegative("70%") + " reduced damage received while this character is shielded"
			})
		}
		return ret;
	}}.getTooltip;

	q.onAdded = @() { function onAdded()
	{
		local baseProperties = this.getContainer().getActor().getBaseProperties();

		baseProperties.IsAffectedByInjuries = false;
		baseProperties.IsAffectedByNight = false;
		baseProperties.IsImmuneToBleeding = true;
		baseProperties.IsImmuneToDisarm = true;
		baseProperties.IsImmuneToKnockBackAndGrab = true;
		baseProperties.IsImmuneToPoison = true;
		baseProperties.IsImmuneToRoot = true;
		baseProperties.IsImmuneToStun = true;

		// This is purely a setting for AI decisions:
		baseProperties.IsIgnoringArmorOnAttack = true;
	}}.onAdded;

	q.onBeforeDamageReceived = @() { function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		switch (_hitInfo.DamageType)
		{
			case null:
				break;

			case ::Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 2.0;	// In Vanilla this is 1.33 for firelance and 3.0 for burning ground
				break;

			case ::Const.Damage.DamageType.Piercing:
				if (_skill == null)
				{
					_properties.DamageReceivedRegularMult *= 0.50;
				}
				else
				{
					if (_skill.isRanged())
					{
						_properties.DamageReceivedRegularMult *= 0.25;
						/* This streamlines the following differences in vanilla:
							javelins dealing 50% damage
							handgonne and one-use throwing spear dealing 100% damage
						*/
					}
					else
					{
						_properties.DamageReceivedRegularMult *= 0.50;	// New: In Vanilla piercing melee attacks are not reduced
					}
				}
				break;
		}
	}}.onBeforeDamageReceived;

	// We exported everything this function does into its own effect (rf_sapling_harvest).
	// By overwriting this method we also nullify all other mods hooking into this before us but there is clean solution to this
	q.onDamageReceived = @() function( _attacker, _damageHitpoints, _damageArmor ) {};
});
