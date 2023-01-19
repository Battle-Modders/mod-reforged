::mods_hookExactClass("skills/perks/perk_nimble", function(o) {
	o.isHidden <- function()
	{
		return ::Math.floor(this.getHitpointsDamage() * 100) >= 100 && ::Math.floor(this.getArmorDamage() * 100) >= 100;
	}

	o.getTooltip <- function()
	{
		local tooltip = this.skill.getTooltip();
		local hpBonus = ::Math.round(this.getHitpointsDamage() * 100);
		if (hpBonus < 100)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Damage to hitpoints from attacks is reduced by [color=" + ::Const.UI.Color.PositiveValue + "]" + (100-hpBonus) + "%[/color]"
			});
		}
		local armorBonus = ::Math.round(this.getArmorDamage() * 100);
		if (armorBonus < 100)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Damage to armor from attacks is reduced by [color=" + ::Const.UI.Color.PositiveValue + "]" + (100-armorBonus) + "%[/color]"
			});
		}

		if (hpBonus >= 100 && armorBonus >= 100)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]This character\'s body and head armor are too heavy to gain any benefit from being nimble[/color]"
			});
		}

		return tooltip;
	}

	o.getHitpointsDamage <- function()
	{
		local fat = this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);
		fat = ::Math.min(0, fat + 15);
		return ::Math.minf(1.0, 1.0 - 0.5 + this.Math.pow(this.Math.abs(fat), 1.23) * 0.01);
	}

	o.getArmorDamage <- function()
	{
		local fat = this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);
		fat = ::Math.min(0, fat + 15);
		return ::Math.minf(1.0, 1.0 - 0.25 + this.Math.pow(this.Math.abs(fat), 1.23) * 0.01);
	}

	o.onBeforeDamageReceived = function( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
		{
			return;
		}

		_properties.DamageReceivedRegularMult *= this.getHitpointsDamage();
		_properties.DamageReceivedArmorMult *= this.getArmorDamage();
	}
});
