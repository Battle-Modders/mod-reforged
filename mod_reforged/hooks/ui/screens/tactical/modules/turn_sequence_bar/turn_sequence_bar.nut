::Reforged.HooksMod.hook("scripts/ui/screens/tactical/modules/turn_sequence_bar/turn_sequence_bar", function(q) {
	q.m.IsWaitingRound <- false;	// Similar to IsSkippingRound but for the Wait Action

	// In Vanilla this funtion is also called at the start of an actors turn if that actor is flagged with 'IsSkippingTurn' (aka End Round button presset)
	// We manipulated some other function so it is now also called when that actors 'IsWaitingTurn' is true. So now we can redirect the wait behavior in here
	q.initNextTurn = @(__original) { function initNextTurn( _force = false )
	{
		local activeEntity = this.getActiveEntity();
		if (activeEntity != null && activeEntity.m.IsWaitingTurn)
		{
			activeEntity.m.IsWaitingTurn = false;
			this.entityWaitTurn(activeEntity);	// This function also checks whether that entity still has a waiting action to spend. If not then you have to spend their turn manually
			return;
		}

		__original(_force);
	}}.initNextTurn;

	q.initNextRound = @(__original) { function initNextRound()
	{
		this.m.JSHandle.call("RF_setWaitTurnAllButtonVisible", true);
		this.m.IsWaitingRound = false;
		__original();
	}}.initNextRound;

	q.convertEntityToUIData = @(__original) { function convertEntityToUIData( _entity, isLastEntity = false )
	{
		local ret = __original(_entity, isLastEntity);

		// Replace Morale values with Reach values. Morale is no longer displayed as a bar
		local currentProperties = _entity.getCurrentProperties();
		local reach = currentProperties.getReach();
		local reachAtk = currentProperties.OffensiveReachIgnore;
		local reachDef = currentProperties.DefensiveReachIgnore;
		ret.morale = reach;
		ret.moraleMax = 15; // arbitrary maximum value
		ret.moraleLabel = reach + " (" + reachAtk + ", " + reachDef + ")";

		local isShowingValue = false;
		switch (::Reforged.Mod.ModSettings.getSetting("TacticalTooltip_Values").getValue())
		{
			case "All":
				isShowingValue = true;
				break;
			case "Player Only":
				isShowingValue = ::MSU.isKindOf(_entity, "player");
				break;
			case "AI Only":
				isShowingValue = !::MSU.isKindOf(_entity, "player");
				break;
		}

		if (!isShowingValue)
		{
			// All these entries are not added by vanilla in this function, but they are used by vanilla
			// in the js function. So if we just add them here, it works automatically.
			ret.armorHeadLabel <-  ::Const.ArmorStateName[_entity.getArmorState(::Const.BodyPart.Head)];
			ret.armorBodyLabel <- ::Const.ArmorStateName[_entity.getArmorState(::Const.BodyPart.Body)];
			ret.fatigueLabel <-  ::Const.FatigueStateName[_entity.getFatigueState()];
			ret.hitpointsLabel <- ::Const.HitpointsStateName[_entity.getHitpointsState()];
			ret.actionPointsLabel <- ::Const.RF_ActionPointsStateName[_entity.RF_getActionPointsState()];
		}

		return ret;
	}}.convertEntityToUIData;

	// Overwrite, because we completely change the behavior of the original function to fix a vanilla bug
	// VanillaFix: We ignore completely ignore this.m.IsLocked here to fix the root cause of:
	//	- getActiveEntity() returning null during a skillcontainers onTurnStart and onTurnEnd events
	//	- other actors changing the field of view, when moving at the start of an actors turn (e.g. actor being pushed away from reanimating zombies)
	q.getActiveEntity = @() { function getActiveEntity()
	{
		if (this.m.CurrentEntities.len() != 0)
		{
			return this.m.CurrentEntities[0];
		}
		else
		{
			return null;
		}
	}}.getActiveEntity;

	// We replace the vanilla function for performance reason and because it is a simple function. We don't want to query an entitys skills twice for no reason.
	q.convertEntityStatusEffectsToUIData = @() { function convertEntityStatusEffectsToUIData( _entity )
	{
		if (!_entity.isPlayerControlled()) return null;

		local result = [];
		foreach (statusEffect in _entity.getSkills().query(::Const.SkillType.StatusEffect | ::Const.SkillType.PermanentInjury, false, true))
		{
			result.push({
				id = statusEffect.getID(),
				imagePath = statusEffect.getIcon()
			});
		}

		return result;
	}}.convertEntityStatusEffectsToUIData;

// New Functions:
	q.RF_onWaitTurnAllButtonPressed <- { function RF_onWaitTurnAllButtonPressed()
	{
		if (this.m.IsWaitingRound || this.getActiveEntity() == null || !this.getActiveEntity().isPlayerControlled())
		{
			return;
		}

		::Tactical.State.showDialogPopup("Wait Round", "Have all your characters use \'Wait\' on this round?", function ()
		{
			this.m.IsWaitingRound = true;
			this.m.JSHandle.call("RF_setWaitTurnAllButtonVisible", false);

			foreach (e in this.m.CurrentEntities)
			{
				if (e.isPlayerControlled()) e.setWaitTurn(true);
			}

			local activeEntity = this.getActiveEntity();
			if (activeEntity != null && activeEntity.m.IsWaitingTurn)
			{
				activeEntity.m.IsWaitingTurn = false;
				this.entityWaitTurn(activeEntity);	// This function also checks whether the active entity still has a waiting action to spend. If not then you have to spend their turn manually
				return;
			}
		}.bindenv(this), null);
	}}.RF_onWaitTurnAllButtonPressed;
});
