::Reforged.HooksMod.hook("scripts/skills/actives/throw_spear_skill", function(q) {
	q.m.AdditionalAccuracy <- 20;
	q.m.AdditionalHitChance <- -15;
	q.m.FatigueDamage <- 40;

	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultTooltip();

		local damage = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand).getShieldDamage();
		if (damage != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/shield_damage.png",
				text = "Inflicts " + ::MSU.Text.colorDamage(damage) + " damage to shields"
			});
		}

		if (this.m.FatigueDamage != 0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Reforged.Mod.Tooltips.parseString("Inflicts " + ::MSU.Text.colorDamage(this.m.FatigueDamage) + " [Fatigue|Concept.Fatigue] when hitting a shield")
			});
		}

		ret.extend(this.getRangedTooltip());

		if (this.getContainer().getActor().isEngagedInMelee())
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Cannot be used because this character is [engaged|Concept.ZoneOfControl] in melee"))
			});
		}

		return ret;
	}

	// Same as vanilla except we use the custom AdditionalAccuracy and AdditionalHitChance instead of hard-coded ones
	q.onAnySkillUsed = @() function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;

			if (_targetEntity != null)
			{
				local shield = _targetEntity.getOffhandItem();

				if (shield != null && shield.isItemType(::Const.Items.ItemType.Shield))
				{
					this.m.IsUsingHitchance = false;
				}
				else
				{
					this.m.IsUsingHitchance = true;
				}
			}
			else
			{
				this.m.IsUsingHitchance = true;
			}
		}
	}

	q.onApplyShieldDamage = @(__original) function( _tag )
	{
		if (this.m.FatigueDamage != 0)
		{
			local targetEntity = _tag.TargetTile.getEntity();
			local hitInfo = clone ::Const.Tactical.HitInfo;
			hitInfo.MV_PropertiesForBeingHit = targetEntity.getCurrentProperties();
			hitInfo.DamageFatigue = this.m.FatigueDamage;
			targetEntity.setFatigue(::Math.min(targetEntity.getFatigueMax(), targetEntity.getFatigue() + targetEntity.MV_calcFatigueDamageReceived(this, hitInfo)));
		}

		return __original(_tag);
	}
});
