::Reforged.HooksMod.hook("scripts/retinue/retinue_manager", function(q) {
	q.setFollower = @(__original) { function setFollower( _slot, _follower )
	{
		__original(_slot, _follower);

		if (_follower.getID() == "follower.agent")
		{
			foreach (c in ::World.Contracts.getOpenContracts())
			{
				c.RF_fakeStart(true);
			}
		}
	}}.setFollower;
});
