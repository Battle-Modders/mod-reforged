this.rf_vampire_lord_agent <- ::inherit("scripts/ai/tactical/agents/vampire_agent", {
	m = {},
	function create()
	{
		this.vampire_agent.create();
	}

	function onUpdate()
	{
		this.vampire_agent.onUpdate();

		this.m.Properties.BehaviorMult[::Const.AI.Behavior.ID.Swing] *= 3.0;
		this.m.Properties.BehaviorMult[::Const.AI.Behavior.ID.Split] *= 3.0;

		// Don't use Darkflight first when at Max AP and able to use Swing or Split effectively.
		local actor = this.getActor();
		if (actor.getActionPoints() == actor.getActionPointsMax())
		{
			local myTile = this.getActor().getTile();
			local swingGap = 0;
			local swingCount = 0;
			local canSplit = false;
			for (local i = 0; i < 6; i++)
			{
				if (!myTile.hasNextTile(i))
					continue;

				local nextTile = myTile.getNextTile(i);
				if (nextTile.IsOccupiedByActor && !nextTile.getEntity().isAlliedWith(actor))
				{
					if (swingGap <= 1)
					{
						swingGap = 0;
						swingCount++;
					}
					if (!canSplit && nextTile.hasNextTile(i))
					{
						local nextnextTile = nextTile.getNextTile(i);
						if (nextnextTile.IsOccupiedByActor && !nextnextTile.getEntity().isAlliedWith(actor))
						{
							canSplit = true;
						}
					}
				}
				else
				{
					swingGap++;
				}
			}

			if (canSplit || swingCount >= 2)
			{
				this.m.Properties.BehaviorMult[::Const.AI.Behavior.ID.Darkflight] = 0.0;
			}
		}
	}
});

