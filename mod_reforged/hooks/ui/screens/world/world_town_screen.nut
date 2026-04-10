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
				break;
			}
		}
	}
});
