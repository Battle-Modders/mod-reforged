::Reforged.HooksMod.hook("scripts/skills/racial/serpent_racial", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Name = "Serpent";
		this.m.Icon = "ui/orientation/serpent_orientation.png";
		this.m.IsHidden = false;
		if (this.isType(::Const.SkillType.Perk))
			this.removeType(::Const.SkillType.Perk);	// This effect having the type 'Perk' serves no purpose and only causes issues in modding
	}

	q.getTooltip <- function()
	{
		local ret = this.skill.getTooltip();
		ret.extend([
			{
				id = 12,
				type = "text",
				icon = "ui/icons/campfire.png",
				text = ::MSU.Text.colorNegative("33%") + " less burning damage received"
			},
			/*{
				id = 13,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "Initiative is treated as 15 higher for the purpose of turn order if there is a potential target to be hooked nearby"
			}*/
			{
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Not affected by [Nighttime|Skill+night_effect]")
			},
			{
				id = 23,
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

		baseProperties.IsAffectedByNight = false;
		baseProperties.IsImmuneToDisarm = true;
	}

	q.onBeingAttacked = @() function( _attacker, _skill, _properties )
	{
		local d = _skill.getDamageType();
		if (d.contains(::Const.Damage.DamageType.Burning))
		{
			_properties.DamageReceivedRegularMult *= 1.0 - d.getProbability(::Const.Damage.DamageType.Burning) * 0.33;
		}
	}

	q.onBeforeDamageReceived = @() function( _attacker, _skill, _hitInfo, _properties )
	{
		switch (_hitInfo.DamageType)
		{
			case null:
				break;

			case ::Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 0.66;
				break;

			// In Vanilla they also take reduced damage from firearms and mortars. But those are currently not covered here
		}
	}
});
