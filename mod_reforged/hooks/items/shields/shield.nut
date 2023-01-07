::mods_hookExactClass("items/shields/shield", function (o) {

	local onUpdateProperties = o.onUpdateProperties;
	o.onUpdateProperties = function( _properties )
	{
        local oldStamina = _properties.Stamina;
        onUpdateProperties(_properties);
        local staminaDifference = _properties.Stamina - oldStamina;
		_properties.Burden += (-1.0 * staminaDifference);
	}
});
