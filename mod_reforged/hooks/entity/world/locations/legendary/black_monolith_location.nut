::Reforged.HooksMod.hook("scripts/entity/world/locations/legendary/black_monolith_location", function(q) {
	q.onSpawned = @() function()
	{
		this.m.Name = "Black Monolith";
		this.location.onSpawned();

		local troops = [
			// [num, troopType]

			// Right (31)
			[3, ::Const.World.Spawn.Troops.RF_SkeletonDecanus],
			[7, ::Const.World.Spawn.Troops.RF_SkeletonMediumElite],
			[3, ::Const.World.Spawn.Troops.SkeletonMedium],
			[3, ::Const.World.Spawn.Troops.RF_SkeletonMediumElitePolearm],
			[2, ::Const.World.Spawn.Troops.RF_SkeletonCenturion],
			[2, ::Const.World.Spawn.Troops.RF_SkeletonMediumElitePolearm],
			[3, ::Const.World.Spawn.Troops.SkeletonMediumPolearm],
			[1, ::Const.World.Spawn.Troops.RF_SkeletonLegatus],
			[6, ::Const.World.Spawn.Troops.Vampire],
			[1, ::Const.World.Spawn.Troops.RF_VampireLord]

			// Top (16)
			[2, ::Const.World.Spawn.Troops.SkeletonHeavyBodyguard],
			[3, ::Const.World.Spawn.Troops.RF_SkeletonHeavyLesserBodyguard],
			[2, ::Const.World.Spawn.Troops.SkeletonHeavy],
			[5, ::Const.World.Spawn.Troops.RF_SkeletonHeavyLesser],
			[1, ::Const.World.Spawn.Troops.SkeletonBoss],
			[3, ::Const.World.Spawn.Troops.SkeletonPriest]
		];

		foreach (entry in troops)
		{
			local num = entry[0];
			local troop = entry[1];
			for (local i = 0; i < num; i++)
			{
				::Const.World.Common.addTroop(this, { Type = troop }, false));
			}
		}
	}

	q.onBeforeCombatStarted = @() function()
	{}
});
