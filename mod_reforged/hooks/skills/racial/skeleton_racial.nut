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
				text = ::MSU.Text.colorRed("75%") + " reduced burning damage received"
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
		baseProperties.IsImmuneToPoison = true;
	}

	q.onBeforeDamageReceived = @(__original) function( _attacker, _skill, _hitInfo, _properties )
	{
		switch (_hitInfo.DamageType)
		{
			case null:
				break;

			case ::Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 0.25;
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
							one-use throwing spear dealing 50% damage
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
