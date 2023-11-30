::Reforged.HooksMod.hook("scripts/states/world_state", function(q) {
	// Add functionality to allow using %factionname% in entity names which is to be replaced by that character's faction's name
    q.startScriptedCombat = @(__original) function( _properties = null, _isPlayerInitiated = true, _isCombatantsVisible = true, _allowFormationPicking = true )
    {
    	if (_properties != null)
    	{
    		foreach (entity in _properties.Entities)
    		{
    			entity.Name = ::buildTextFromTemplate(entity.Name, ::Const.World.Common.RF_generateNameVars(entity));
    		}
    	}

    	return __original(_properties, _isPlayerInitiated, _isCombatantsVisible, _allowFormationPicking);
    }
});
