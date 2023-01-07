::mods_hookExactClass("skills/special/bag_fatigue", function(o) {

    local oldOnUpdate = o.onUpdate;
	o.onUpdate = function( _properties )
	{
        local oldStamina = _properties.Stamina;
        oldOnUpdateProperties(_properties);
        local staminaDifference = _properties.Stamina - oldStamina;
		_properties.Burden += (-1.0 * staminaDifference);
	}
});
