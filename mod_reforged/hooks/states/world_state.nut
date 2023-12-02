::Reforged.HooksMod.hook("scripts/states/world_state", function(q) {
	// Add functionality to allow using more vars in troop names e.g. for champions
    q.startScriptedCombat = @(__original) function( _properties = null, _isPlayerInitiated = true, _isCombatantsVisible = true, _allowFormationPicking = true )
    {
    	if (_properties != null)
    	{
    		foreach (entity in _properties.Entities)
    		{
    			if ("Name" in entity)
    				entity.Name = ::buildTextFromTemplate(entity.Name, ::Const.World.Common.RF_getTroopNameTemplateVars(entity));
    		}
    	}

    	return __original(_properties, _isPlayerInitiated, _isCombatantsVisible, _allowFormationPicking);
    }
});
