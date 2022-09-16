::mods_hookExactClass("skills/perks/perk_nimble", function(o) {
	o.isHidden = function()
	{
		return (::Math.floor(this.getMultiplier(0.4) * 100) >= 100) && (::Math.floor(this.getMultiplier(0.6) * 100) >= 100);
	}

	o.getTooltip = function()
	{
		local tooltip = this.skill.getTooltip();
		local multMin = ::Math.round(this.getMultiplier(0.4) * 100);
		local multMax = ::Math.round(this.getMultiplier(0.6) * 100);

		if (multMin >= 100 && multMax >= 100)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]This character\'s body and head armor are too heavy to gain any benefit from being nimble[/color]"
			});
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Damage to hitpoints from attacks is reduced by [color=" + ::Const.UI.Color.PositiveValue + "]" + (100-multMin) + "%[/color] to [color=" + ::Const.UI.Color.PositiveValue + "]" + (100-multMax) + "%[/color]"
			});
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Damage to armor from attacks is reduced by [color=" + ::Const.UI.Color.PositiveValue + "]" + ((100-multMin)/2) + "%[/color] to [color=" + ::Const.UI.Color.PositiveValue + "]" + ((100-multMax)/2) + "%[/color]"
			});
		}

		return tooltip;
	}

	o.getMultiplier <- function( _reduction )
	{
		local fat = 0;
		local body = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Body);
		local head = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Head);

		if (body != null)
		{
			fat = fat + body.getStaminaModifier();
		}

		if (head != null)
		{
			fat = fat + head.getStaminaModifier();
		}

		fat = ::Math.min(0, fat + 15);
		return ::Math.minf(1.0, 1.0 - _reduction + ::Math.pow(::Math.abs(fat), 1.23) * 0.01);
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
		{
			return;
		}

		local reduction = ::MSU.Math.randf(0.4, 0.6);
		_properties.DamageReceivedRegularMult *= this.getMultiplier(reduction);
		_properties.DamageReceivedArmorMult *= this.getMultiplier(reduction/2);
	}
});
