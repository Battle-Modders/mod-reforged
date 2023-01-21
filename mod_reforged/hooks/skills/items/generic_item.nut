::mods_hookExactClass("skills/items/generic_item", function(o) {

    local onUpdate = o.onUpdate;
	o.onUpdate = function( _properties )
	{
        local oldStamina = _properties.Stamina;
        onUpdate(_properties);
        local staminaDifference = _properties.Stamina - oldStamina;
		_properties.Burden += (-1.0 * staminaDifference);
	}
});
