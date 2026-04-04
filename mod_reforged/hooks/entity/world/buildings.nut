::mods_hookExactClass("entity/world/buildings", function(o) {
	local onUpdate = o.onUpdate;
	o.onUpdate = function( _modifiers )
	{
		switch (_id)
		{

			case "building.taxidermist":
				_modifiers.BeastPartsPriceMult *= 2.0;
				break;

			case "building.taxidermist_oriental":
				_modifiers.BeastPartsPriceMult *= 2.0;
				break;
		}

		return onUpdate( _modifiers );
	}
});
