this.rf_draugr_location_enter_event <- ::inherit("scripts/events/event", {
	m = {
		LocationID = null
	},
	function create()
	{
		this.m.ID = "event.location.rf_draugr_location_enter";
		this.m.Title = "As you approach...";
		this.m.Cooldown = 999999.0 * ::World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			// TODO: Needs event text
			Text = "[img]gfx/ui/events/rf_draugr_01.png[/img]",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Prepare the attack.",
					function getResult( _event )
					{
						::World.Events.showCombatDialog(true, true, true);
						return 0;
					}
				},
				{
					Text = "Fall back for now.",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				// TODO Change event text based on this.m.LocationID
			}
		});
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
		if (::World.State.getLastLocation() != null)
		{
			this.m.LocationID = ::World.State.getLastLocation().getID();
		}
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.LocationID = null;
	}
});

