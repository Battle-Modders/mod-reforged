::Reforged.HooksMod.hook("scripts/ui/screens/tactical/modules/turn_sequence_bar/turn_sequence_bar", function(q) {
	q.m.IsWaitingRound <- false;	// Similar to IsSkippingRound but for the Wait Action
	q.m.RF_LastActiveEntityID <- 0;

	// In Vanilla this funtion is also called at the start of an actors turn if that actor is flagged with 'IsSkippingTurn' (aka End Round button presset)
	// We manipulated some other function so it is now also called when that actors 'IsWaitingTurn' is true. So now we can redirect the wait behavior in here
	q.initNextTurn = @() { function initNextTurn( _force = false )
	{
		::logInfo("Reforged initNextTurn _force: " + _force);
		local activeEntity = this.getActiveEntity();
		::logInfo(typeof activeEntity);
		if (activeEntity != null && activeEntity.m.IsWaitingTurn)
		{
			activeEntity.m.IsWaitingTurn = false;
			this.entityWaitTurn(activeEntity);	// This function also checks whether that entity still has a waiting action to spend. If not then you have to spend their turn manually
			return;
		}

		if (_force && ::Time.hasEventScheduled(::TimeUnit.Virtual))
		{
			_force = false;
			this.m.RF_LastActiveEntityID = this.m.CurrentEntities[0].getID();
			::logInfo("Reforged: initNextTurn changing _force from true to false because of scheduled event");
		}

		if (this.m.IsBattleEnded)
		{
			::logInfo("initNextTurn return due to IsBattleEnded");
			return;
		}

		if (this.m.IsLocked)
		{
			if (this.m.CurrentEntities[0] != null && !this.m.CurrentEntities[0].isAlive())
			{
				this.m.IsLocked = false;
				::logInfo("initNextTurn setting IsLocked back to false as active entity is NOT null and is dead");
				return;
			}
			::logInfo("initNextTurn return due to IsLocked while CurrentEntities[0] = " + (this.m.CurrentEntities[0] == null ? null : this.m.CurrentEntities[0].getName()));
			// this.m.IsLocked = false;
			return;
		}

		if (!_force && (this.Time.hasEventScheduled(this.TimeUnit.Virtual) || this.Tactical.State.isPaused()))
		{
			::logInfo("initNextTurn return due to scheduled event or paused");
			return;
		}

		if (this.m.OnNextTurnListener != null)
		{
			if (!this.m.OnNextTurnListener())
			{
				::logInfo("initNextTurn return due to onNextTurnListener");
				return;
			}
		}

		if (this.m.CurrentEntities.len() <= 1)
		{
			if (!this.m.IsInitNextRound)
			{
				this.m.IsInitNextRound = true;
				this.m.CheckEnemyRetreat = true;
			}

			::logInfo("initNextTurn return due to CurrentEntities.len() <= 1");
			return;
		}

		local activeEntity = this.m.CurrentEntities[0];

		if (this.m.CurrentEntities.len() > 1)
		{
			this.m.CurrentEntities[1].onBeforeActivation();
		}

		this.m.IsLocked = true;
		::logInfo("triggering asyncCall removeEntity");
		if (this.m.RF_LastActiveEntityID != 0 && this.m.RF_LastActiveEntityID != activeEntity.getID())
		{
			::logInfo("Sending last entity id as " + this.m.RF_LastActiveEntityID + " instead of the bad id " + activeEntity.getID());
			::logInfo(format("this entity -- typeof: %s, isAlive: %s, isDying: %s, isPlacedOnMap: %s, getName: %s", typeof activeEntity, activeEntity.isAlive() + "", activeEntity.isDying() + "", activeEntity.isPlacedOnMap() + "", activeEntity.getName() + ""));
			::MSU.Log.printData(activeEntity.m);
			::MSU.Log.printData(activeEntity);
			::Reforged.Mod.Debug.addPopupMessage("Got an issue where active entity id had to be fixed. Check your log.", ::MSU.Popup.State.Full);
		}
		this.m.JSHandle.asyncCall("removeEntity", this.m.RF_LastActiveEntityID == 0 ? activeEntity.getID() : this.m.RF_LastActiveEntityID);
		this.m.RF_LastActiveEntityID = 0;
		::logInfo("triggering activeEntity.onTurnEnd()");
		activeEntity.onTurnEnd();
		this.m.CurrentEntities.remove(0);
		++this.m.TurnPosition;
		this.m.IsLastEntityPlayerControlled = activeEntity.isPlayerControlled();

		if (this.m.CurrentEntities.len() >= this.m.MaxVisibleEntities)
		{
			local entityToAddIndex = this.Math.min(this.m.CurrentEntities.len() - 1, this.m.MaxVisibleEntities - 1);
			::logInfo("triggering asyncCall addEntity");
			this.m.JSHandle.asyncCall("addEntity", this.convertEntityToUIData(this.m.CurrentEntities[entityToAddIndex], entityToAddIndex == this.m.CurrentEntities.len() - 1));
		}

		// __original(_force);
	}}.initNextTurn;

	q.initNextRound = @(__original) { function initNextRound()
	{
		this.m.JSHandle.call("RF_setWaitTurnAllButtonVisible", true);
		this.m.IsWaitingRound = false;
		__original();
	}}.initNextRound;

	// Overwrite to remove the vanilla condition of not being the last entity in the turn order.
	// We allow waiting even when you are the last entity in the turn order.
	// This is important as some skills may have triggers based on Waiting e.g. recovering AP.
	q.canEntityWait = @() { function canEntityWait( _entity )
	{
		return !_entity.isWaitActionSpent();
	}}.canEntityWait;

	// Overwrite to change behavior when waiting entity is the last entity in the turn order.
	// Vanilla ends the turn and triggers the next round in this case. We, instead only trigger
	// the wait of the entity and then update the entity's visuals.
	q.entityWaitTurn = @() { function entityWaitTurn( _entity )
	{
		if (::Time.hasEventScheduled(::TimeUnit.Virtual) || ::Tactical.State.isPaused())
		{
			return;
		}

		local entity = this.findEntityByID(this.m.CurrentEntities, _entity.getID());

		if (entity != null)
		{
			if (!entity.entity.isWaitActionSpent())
			{
				if (_entity.getID() == this.m.CurrentEntities.top().getID())
				{
					_entity.wait();
					this.updateEntity(_entity.getID());
					return true;
				}

				this.initNextTurnBecauseOfWait();
				return true;
			}
		}

		return false;
	}}.entityWaitTurn;

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
