::Reforged.HooksMod.hook("scripts/items/accessory/accessory", function(q) {
	// Vanilla does not compare compare/display the Stamina using 'getStaminaModifier' which is why this value is not updated correctly in the tooltip for unleashables
	q.getTooltip = @(__original) function()
	{
		local ret = __original();
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
					entry.text = "Maximum Fatigue " + ::MSU.Text.colorizeValue(this.getStaminaModifier(), {AddSign = true})
				}
				break;
			}
		}
		return ret;
	}

	// In vanilla this function is empty. We replace that function because chances are higher that another mod also "fixes" this StaminaModifier than that they introduce a completely different own global accessory effect
	q.onUpdateProperties = @() function( _properties )
	{
		// In vanilla, some accessories count as equipped while in the bag and manually call 'onEquip' in 'onPutIntoBag'
		// Therefore, we exclude accessories in the bag so that their StaminaModifier isn't applied twice (once here and once via bag_fatigue skill)
		if (this.getCurrentSlotType() != ::Const.ItemSlot.Bag)
		{
			_properties.Stamina += this.getStaminaModifier();
		}
	}
});
