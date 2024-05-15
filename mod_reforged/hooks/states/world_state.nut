::Reforged.HooksMod.hook("scripts/states/world_state", function(q) {
	// Add functionality to allow using more vars in troop names e.g. for champions
    q.startScriptedCombat = @(__original) function( _properties = null, _isPlayerInitiated = true, _isCombatantsVisible = true, _allowFormationPicking = true )
    {
    	if (_properties != null)
    	{
    		foreach (entity in _properties.Entities)
    		{
    			if (("Name" in entity) && entity.Name != "")
    				entity.Name = ::buildTextFromTemplate(entity.Name, ::Const.World.Common.RF_getTroopNameTemplateVars(entity));
    		}
    	}

    	return __original(_properties, _isPlayerInitiated, _isCombatantsVisible, _allowFormationPicking);
    }

	q.onMouseInput = @(__original) function( _mouse )
	{
		local ret = __original(_mouse);

		// Hook, in order to increase the interaction range with towns while on a caravan mission
		if (ret == false)	// If the original function wasn't able to process the mouseclick we try to do that with increased interaction range
		{
			if (!::MSU.isNull(this.m.EscortedEntity) && _mouse.getState() == 1 && !this.isInCameraMovementMode() && !this.m.WasInCameraMovementMode)
			{
				foreach (entity in ::World.getAllEntitiesAndOneLocationAtPos(::World.getCamera().screenToWorld(_mouse.getX(), _mouse.getY()), 1.0))
				{

					if (!::MSU.isKindOf(entity, "settlement")) continue;
					if (!entity.isEnterable()) continue;
					if (!entity.isAlliedWithPlayer()) continue;

					if (this.m.Player.getDistanceTo(entity) <= 200)		// Vanilla uses ::Const.World.CombatSettings.CombatPlayerDistance here which equals to 100 by default
					{
						this.enterLocation(entity);
						return true;
					}
				}
			}
		}

		return ret;
	}
});
