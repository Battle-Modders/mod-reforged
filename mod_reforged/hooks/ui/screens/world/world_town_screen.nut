::Reforged.HooksMod.hook("scripts/ui/screens/world/world_town_screen", function(q) {
	q.RF_onContractRightClicked <- function( _contractID )
	{
		if (this.isAnimating())
			return;

		foreach (c in ::World.Contracts.getOpenContracts())
		{
			if (c.getID() == _contractID)
			{
				::World.Contracts.removeContract(c);
				::Sound.play("sounds/cloth_01.wav", ::MSU.Math.randf(0.9, 1.1), ::World.State.getPlayer().getPos(), ::MSU.Math.randf(0.9, 1.1));
				break;
			}
		}
	}

	// We add handling for auto-negotiation of contracts and for skipping
	// contracts to a certain screen.
	q.onContractClicked = @(__original) { function onContractClicked( _data )
	{
		// Same guard as vanilla
		if (this.isAnimating())
		{
			__original();
			return;
		}

		local n = ::Reforged.Mod.ModSettings.getSetting("AutoNegotiateAttempts").getValue();
		local skipTo = ::Reforged.Mod.ModSettings.getSetting("SkipContractsToScreen").getValue();
		if (n != 0 || skipTo != "Disabled")
		{
			foreach (c in ::World.Contracts.getOpenContracts())
			{
				if (c.getID() != _data)
					continue;

				// If a contract is already at Overview, it has been
				// fully negotiated, so we mustn't do anything.
				if (c.m.ActiveScreen.ID == "Overview")
					break;

				if (skipTo == "Negotiation")
				{
					c.setScreen("Negotiation");
				}

				if (n != 0)
				{
					c.RF_autoNegotiate(n);
				}

				if (skipTo == "Overview")
				{
					if (c.m.ActiveScreen.ID == "Negotiation")
					{
						c.setScreen(c.m.ActiveScreen.Options[0].getResult());
					}
					else if (c.m.ActiveScreen.ID != "Negotiation.Fail")
					{
						c.setScreen("Negotiation");
						c.setScreen(c.m.ActiveScreen.Options[0].getResult());
					}
				}

				break;
			}
		}

		__original(_data);
	}}.onContractClicked;
});
