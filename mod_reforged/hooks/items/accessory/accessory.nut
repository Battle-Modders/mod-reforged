::mods_hookExactClass("items/accessory/accessory", function(o) {
	// Vanilla does not compare compare/display the Stamina using 'getStaminaModifier' which is why this value is not updated correctly in the tooltip for unleashables
	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local ret = getTooltip();
		foreach(index, entry in ret)
		{
			if (entry.id == 8 && entry.icon == "ui/icons/fatigue.png")
			{
				if (this.getStaminaModifier() == 0)
				{
					ret.remove(index);
				}
				else
				{
					entry.text = "Maximum Fatigue " + ::MSU.Text.colorizeValue(this.getStaminaModifier())
				}
				break;
			}
		}
		return ret;
	}

	// In vanilla this function is empty. We replace that function because chances are higher that another mod also "fixes" this StaminaModifier than that they introduce a completely different own global accessory effect
	o.onUpdateProperties = function( _properties )
	{
		_properties.Stamina += this.getStaminaModifier();
	}
});
