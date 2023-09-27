::Reforged.HooksMod.hook("scripts/entity/tactical/tactical_entity_manager", function(q) {
	q.setupEntity = @(__original) function( _e, _t )
	{
		__original(_e, _t);
		_e.getSkills().onSetupEntity();
	}
});
