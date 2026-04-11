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
});
