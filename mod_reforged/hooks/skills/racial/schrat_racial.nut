::Reforged.HooksMod.hook("scripts/skills/racial/schrat_racial", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Name = "Schrat";
		this.m.Icon = "ui/orientation/schrat_01_orientation.png";
		this.m.IsHidden = false;
	}

	q.isHidden = @(__original) function()	// In Vanilla this skill is only shown while the Schrat has a shield
	{
		return this.skill.isHidden();
	}

	q.getName <- function()
	{
		if (this.getContainer().getActor().isArmedWithShield()) return (this.skill.getName() + " (Shielded)");
		return this.skill.getName();
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
				text = ::MSU.Text.colorRed("66%") + " reduced ranged piercing damage received"
			},
			{
				id = 12,
				type = "text",
                icon = "ui/icons/campfire.png",
				text = ::MSU.Text.colorGreen("100%") + " increased burning damage received"
			}
		]);
		if (this.getContainer().getActor().isArmedWithShield())
		{
			ret.push({
				id = 15,
				type = "text",
                icon = "skills/status_effect_86.png",
				text = ::MSU.Text.colorRed("70%") + " reduced damage received while this character is shielded"
			})
		}
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
		baseProperties.IsImmuneToRoot = true;
		baseProperties.IsImmuneToStun = true;

		// This is purely a setting for AI decisions:
		baseProperties.IsIgnoringArmorOnAttack = true;
	}

	q.onBeforeDamageReceived = @(__original) function( _attacker, _skill, _hitInfo, _properties )
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
	}

	// We exported everything this function does into its own effect (rf_sapling_harvest).
	// By overwriting this method we also nullify all other mods hooking into this before us but there is clean solution to this
	q.onDamageReceived = @(__original) function( _attacker, _damageHitpoints, _damageArmor ) {};
});
