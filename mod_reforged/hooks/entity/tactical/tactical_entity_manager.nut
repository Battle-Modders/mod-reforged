::mods_hookNewObject("entity/tactical/tactical_entity_manager", function(o) {
	local setupEntity = o.setupEntity;
	o.setupEntity = function( _e, _t )
	{
		setupEntity(_e, _t);
		_e.onSetupEntity();
	}
});