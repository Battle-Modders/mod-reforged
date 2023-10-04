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
				text = ::MSU.Text.colorRed("33%") + " reduced burning damage received"
			}/*,
			{
				id = 13,
				type = "text",
                icon = "ui/icons/initiative.png",
				text = "Initiative is treated as 15 higher for the purpose of turn order if there is a potential target to be hooked nearby"
			}*/
		]);
		return ret;
	}

	q.onAdded <- function()
	{
		local baseProperties = this.getContainer().getActor().getBaseProperties();

		baseProperties.IsAffectedByNight = false;
		baseProperties.IsImmuneToDisarm = true;
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
