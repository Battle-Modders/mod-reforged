::mods_hookExactClass("ui/screens/tactical/modules/turn_sequence_bar/turn_sequence_bar", function(o) {
	o.m.IsWaitingRound <- false;	// Similar to IsSkippingRound but for the Wait Action

	// In Vanilla this funtion is also called at the start of an actors turn if that actor is flagged with 'IsSkippingTurn' (aka End Round button presset)
	// We manipulated some other function so it is now also called when that actors 'IsWaitingTurn' is true. So now we can redirect the wait behavior in here
	local initNextTurn = o.initNextTurn;
	o.initNextTurn = function( _force = false )
	{
		local activeEntity = this.getActiveEntity();
		if (activeEntity != null && activeEntity.m.IsWaitingTurn)
		{
			activeEntity.m.IsWaitingTurn = false;
			this.entityWaitTurn(activeEntity);	// This function also checks whether that entity still has a waiting action to spend. If not then you have to spend their turn manually
			return;
		}

		initNextTurn(_force);
	}

	local initNextRound = o.initNextRound;
	o.initNextRound = function()
	{
		this.m.JSHandle.call("setWaitTurnAllButtonVisible", true);
		this.m.IsWaitingRound = false;
		initNextRound();
	}

// New Functions:
	o.onWaitTurnAllButtonPressed <- function()
	{
		if (this.m.IsWaitingRound || this.getActiveEntity() == null || !this.getActiveEntity().isPlayerControlled())
		{
			return;
		}

		::Tactical.State.showDialogPopup("Wait Round", "Have all your characters use \'Wait\' on this round?", function ()
		{
			this.m.IsWaitingRound = true;
			this.m.JSHandle.call("setWaitTurnAllButtonVisible", false);

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
	}
});
