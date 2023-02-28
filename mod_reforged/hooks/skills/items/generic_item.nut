::mods_hookExactClass("skills/items/generic_item", function(o) {
	local onUpdate = o.onUpdate;
	o.onUpdate = function( _properties )
	{
		// Revert any changes to _properties.Stamina by the vanilla function
        local oldStamina = _properties.Stamina;
        onUpdate(_properties);
        _properties.Stamina = oldStamina;
	}
});
