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

				// Some contracts may not have a Negotiation screen (e.g. contracts in Stronghold mod)
				// so we check that we have a Negotiation screen before moving forward.
				local hasNegotiationScreen = false;
				foreach (s in c.m.Screens)
				{
					if (s.ID == "Negotiation")
					{
						hasNegotiationScreen = true;
						break;
					}
				}

				if (!hasNegotiationScreen)
				{
					// We should not do `setScreen("Overview")` for such contracts
					// because going to the Overview screen may be expected
					// to be from a previous screen's option which may set some
					// state. So, for such contracts we let them behave unchanged
					// i.e. don't apply any skipping or auto-negotiation.
					break;
				}

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
