::Reforged.Config <- {
	IsLegendaryDifficulty = false,
}

::Reforged.DummyPlayer <- null;
::Reforged.getDummyPlayer <- function()
{
	if (this.DummyPlayer == null)
	{
		this.DummyPlayer = ::World.getTemporaryRoster().create("scripts/entity/tactical/player");
		::World.getTemporaryRoster().clear();
	}
	return this.DummyPlayer;
}
