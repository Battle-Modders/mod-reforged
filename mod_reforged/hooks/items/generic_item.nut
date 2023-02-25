::mods_hookExactClass("skills/items/generic_item", function(o) {

    local onUpdate = o.onUpdate;
	o.onUpdate = function( _properties )
	{
        // This will void all Stamina-Changes applied by any equipped item. We handle those at another place now.
        local oldStamina = _properties.Stamina;
        onUpdate(_properties);
        _properties.Stamina = oldStamina;

        // Now we write the weight of the equipped item into the respective field in _properties
        local currentItemSlot = this.getItem().getCurrentSlotType();
        if (currentItemSlot == ::Const.ItemSlot.None) return;   // This is just to be safe because we have no field called "None" under 'Weight'
        _properties.Weight[currentItemSlot] = this.getItem().getWeight();
	}
});
