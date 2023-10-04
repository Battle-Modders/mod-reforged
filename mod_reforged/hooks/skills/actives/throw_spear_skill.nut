::Reforged.HooksMod.hook("scripts/skills/actives/throw_spear_skill", function(q) {
	q.m.AdditionalAccuracy <- 20;
	q.m.AdditionalHitChance <- -15;

	q.getTooltip = @() function()
	{
		local ret = this.skill.getDefaultTooltip();
		local damage = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).getShieldDamage();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/shield_damage.png",
			text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + damage + "[/color] damage to shields"
		});

		ret.extend(this.getRangedTooltip());

		if (this.getContainer().getActor().isEngagedInMelee())
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Cannot be used because this character is engaged in melee[/color]"
			});
		}

		return ret;
	}

	q.onAnySkillUsed = @() function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.RangedSkill += 20;
			_properties.HitChanceAdditionalWithEachTile -= 10;

			if (_targetEntity != null)
			{
				local shield = _targetEntity.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);

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
});
