::mods_hookExactClass("skills/items/generic_item", function(o) {

    local onUpdate = o.onUpdate;
	o.onUpdate = function( _properties )
	{
        // This will void all Stamina-Changes applied by any equipped item. We handle those at another place now.
        local oldStamina = _properties.Stamina;
        onUpdate(_properties);
        _properties.Stamina = oldStamina;
	}
});
