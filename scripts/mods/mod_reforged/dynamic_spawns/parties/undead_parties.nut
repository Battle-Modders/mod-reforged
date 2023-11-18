local parties = [
	{
		ID = "UndeadArmy",
		Variants = ::MSU.Class.WeightedContainer([
			[2, {
				ID = "UndeadArmy_0",
				HardMin = 4,
				DefaultFigure = "figure_skeleton_01",
				MovementSpeedMult = 0.9,
				VisibilityMult = 1.0,
				VisionMult = 1.0

				function generateIdealSize( _isLocation = false )
				{
					local startingResources = this.getSpawnProcess().getStartingResources();
					if (startingResources >= 350)
					{
						return 12;
					}
					else if (startingResources >= 300)
					{
						return 11;
					}
					else if (startingResources >= 250)
					{
						return 10;
					}
					else if (startingResources >= 180)
					{
						return 9;
					}
					else if (startingResources >= 120)
					{
						return 7;
					}
					else
					{
						return 5;
					}
				}

				UnitBlockDefs = [
					{ BaseID = "UnitBlock.RF.SkeletonFrontline", RatioMin = 0.40, RatioMax = 0.60 },
					{ BaseID = "UnitBlock.RF.SkeletonBackline", RatioMin = 0.00, RatioMax = 0.40 },
					{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.00, RatioMax = 0.30 },
					{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.00, RatioMax = 0.30 },
					{ BaseID = "UnitBlock.RF.SkeletonDecanus", RatioMax = 0.0, StartingResourceMin = 180, ReqPartySize = 6, function onBeforeSpawnStart() {
					    base.onBeforeSpawnStart();
					    local res = this.getSpawnProcess().getStartingResources();
					    if (res >= 375)
					    {
					        if (::Math.rand(1, 100) <= 90) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 20) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 5) this.spawnUnit();
					    }
					    else if (res >= 300)
					    {
					        if (::Math.rand(1, 100) <= 70) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 15) this.spawnUnit();
					    }
					    else if (res >= 250)
					    {
					        if (::Math.rand(1, 100) <= 55) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 11) this.spawnUnit();
					    }
					    else
					    {
					        if (::Math.rand(1, 100) <= 33) this.spawnUnit();
					    }
					}},
					{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.0, StartingResourceMin = 250, ReqPartySize = 6, function onBeforeSpawnStart() {
					    base.onBeforeSpawnStart();
					    local res = this.getSpawnProcess().getStartingResources();
					    if (res >= 450)
					    {
					        if (::Math.rand(1, 100) <= 80) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 20) this.spawnUnit();
					    }
					    else if (res >= 375)
					    {
					        if (::Math.rand(1, 100) <= 80) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 15) this.spawnUnit();
					    }
					    else if (res >= 300)
					    {
					        if (::Math.rand(1, 100) <= 55) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 11) this.spawnUnit();
					    }
					    else
					    {
					        if (::Math.rand(1, 100) <= 33) this.spawnUnit();
					    }
					}},
					{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.0, StartingResourceMin = 300, ReqPartySize = 6, function onBeforeSpawnStart() {
					    base.onBeforeSpawnStart();
					    local res = this.getSpawnProcess().getStartingResources();
					    if (res >= 450)
					    {
					        if (::Math.rand(1, 100) <= 80) this.spawnUnit();
					    }
					    else if (res >= 375)
					    {
					        if (::Math.rand(1, 100) <= 66) this.spawnUnit();
					    }
					    else (res >= 300)
					    {
					        if (::Math.rand(1, 100) <= 33) this.spawnUnit();
					    }
					}},
					{ BaseID = "UnitBlock.RF.SkeletonSupport", RatioMin = 0.00, RatioMax = 0.10}
				]
			}],
			[1, {
				ID = "UndeadArmy_1",
				HardMin = 5,
				DefaultFigure = "figure_skeleton_01",
				MovementSpeedMult = 0.9,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				StartingResourceMin = 250,
				UnitBlockDefs = [
					{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.01, RatioMax = 0.80 },
					{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.0, StartingResourceMin = 250, ReqPartySize = 6, function onBeforeSpawnStart() {
					    base.onBeforeSpawnStart();
					    local res = this.getSpawnProcess().getStartingResources();
					    if (res >= 450)
					    {
					        if (::Math.rand(1, 100) <= 50) this.spawnUnit();
					    }
					    else if (res >= 375)
					    {
					        if (::Math.rand(1, 100) <= 45) this.spawnUnit();
					    }
					    else if (res >= 300)
					    {
					        if (::Math.rand(1, 100) <= 35) this.spawnUnit();
					    }
					    else
					    {
					        if (::Math.rand(1, 100) <= 25) this.spawnUnit();
					    }
					}},
					{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.0, StartingResourceMin = 300, ReqPartySize = 6, function onBeforeSpawnStart() {
					    base.onBeforeSpawnStart();
					    local res = this.getSpawnProcess().getStartingResources();
					    if (res >= 450)
					    {
					        if (::Math.rand(1, 100) <= 40) this.spawnUnit();
					    }
					    else if (res >= 375)
					    {
					        if (::Math.rand(1, 100) <= 30) this.spawnUnit();
					    }
					    else (res >= 300)
					    {
					        if (::Math.rand(1, 100) <= 20) this.spawnUnit();
					    }
					}},
					{ BaseID = "UnitBlock.RF.SkeletonSupport", RatioMin = 0.01, RatioMax = 0.20 }
				]
			}],
			[1, {
				ID = "UndeadArmy_2",
				HardMin = 5,
				DefaultFigure = "figure_skeleton_01",
				MovementSpeedMult = 0.9,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				StartingResourceMin = 250,
				UnitBlockDefs = [
					{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.01, RatioMax = 0.80 },
					{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.01, RatioMax = 0.40 },
					{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.0, StartingResourceMin = 250, ReqPartySize = 6, function onBeforeSpawnStart() {
					    base.onBeforeSpawnStart();
					    local res = this.getSpawnProcess().getStartingResources();
					    if (res >= 450)
					    {
					        if (::Math.rand(1, 100) <= 50) this.spawnUnit();
					    }
					    else if (res >= 375)
					    {
					        if (::Math.rand(1, 100) <= 40) this.spawnUnit();
					    }
					    else if (res >= 300)
					    {
					        if (::Math.rand(1, 100) <= 30) this.spawnUnit();
					    }
					    else
					    {
					        if (::Math.rand(1, 100) <= 20) this.spawnUnit();
					    }
					}},
					{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.0, StartingResourceMin = 300, ReqPartySize = 6, function onBeforeSpawnStart() {
					    base.onBeforeSpawnStart();
					    local res = this.getSpawnProcess().getStartingResources();
					    if (res >= 450)
					    {
					        if (::Math.rand(1, 100) <= 40) this.spawnUnit();
					    }
					    else if (res >= 375)
					    {
					        if (::Math.rand(1, 100) <= 30) this.spawnUnit();
					    }
					    else (res >= 300)
					    {
					        if (::Math.rand(1, 100) <= 20) this.spawnUnit();
					    }
					}},
					{ BaseID = "UnitBlock.RF.SkeletonSupport", RatioMin = 0.01, RatioMax = 0.20 }
				]
			}],
			[1, {
				ID = "UndeadArmy_3",
				HardMin = 5,
				DefaultFigure = "figure_skeleton_01",
				MovementSpeedMult = 0.9,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				StartingResourceMin = 250,
				UnitBlockDefs = [
					{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.01, RatioMax = 1.00 },
					{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.0, StartingResourceMin = 180, ReqPartySize = 6, function onBeforeSpawnStart() {
					    base.onBeforeSpawnStart();
					    local res = this.getSpawnProcess().getStartingResources();
					    if (res >= 375)
					    {
					        if (::Math.rand(1, 100) <= 80) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 20) this.spawnUnit();
					    }
					    else if (res >= 300)
					    {
					        if (::Math.rand(1, 100) <= 70) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 15) this.spawnUnit();
					    }
					    else if (res >= 250)
					    {
					        if (::Math.rand(1, 100) <= 45) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 5) this.spawnUnit();
					    }
					    else
					    {
					        if (::Math.rand(1, 100) <= 25) this.spawnUnit();
					    }
					}},
					{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.0, StartingResourceMin = 300, ReqPartySize = 6, function onBeforeSpawnStart() {
					    base.onBeforeSpawnStart();
					    local res = this.getSpawnProcess().getStartingResources();
					    if (res >= 450)
					    {
					        if (::Math.rand(1, 100) <= 40) this.spawnUnit();
					    }
					    else if (res >= 375)
					    {
					        if (::Math.rand(1, 100) <= 30) this.spawnUnit();
					    }
					    else (res >= 300)
					    {
					        if (::Math.rand(1, 100) <= 20) this.spawnUnit();
					    }
					}}
				]
			}],
		])
	},
	{
		ID = "Vampires",
		HardMin = 2,
		DefaultFigure = "figure_vampire_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.01, RatioMax = 1.00 }
		]
	},
	{
		ID = "VampiresAndSkeletons",
		Variants = ::MSU.Class.WeightedContainer([
			[2, {
				ID = "VampiresAndSkeletons_0",
				HardMin = 7,
				DefaultFigure = "figure_vampire_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,

				function generateIdealSize( _isLocation = false )
				{
					local startingResources = this.getSpawnProcess().getStartingResources();
					if (startingResources >= 350)
					{
						return 12;
					}
					else if (startingResources >= 300)
					{
						return 10;
					}
					else
					{
						return 8
					}
				}
				UnitBlockDefs = [
					{ BaseID = "UnitBlock.RF.SkeletonFrontline", RatioMin = 0.01, RatioMax = 0.60 },
					{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.01, RatioMax = 0.40, HardMin = 3 },
					{ BaseID = "UnitBlock.RF.SkeletonDecanus", RatioMax = 0.0, StartingResourceMin = 180, ReqPartySize = 6, function onBeforeSpawnStart() {
					    base.onBeforeSpawnStart();
					    local res = this.getSpawnProcess().getStartingResources();
					    if (res >= 375)
					    {
					        if (::Math.rand(1, 100) <= 80) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 20) this.spawnUnit();
					    }
					    else if (res >= 300)
					    {
					        if (::Math.rand(1, 100) <= 70) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 15) this.spawnUnit();
					    }
					    else if (res >= 250)
					    {
					        if (::Math.rand(1, 100) <= 45) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 5) this.spawnUnit();
					    }
					    else
					    {
					        if (::Math.rand(1, 100) <= 25) this.spawnUnit();
					    }
					}},
					{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.0, StartingResourceMin = 250, ReqPartySize = 6, function onBeforeSpawnStart() {
					    base.onBeforeSpawnStart();
					    local res = this.getSpawnProcess().getStartingResources();
					    if (res >= 450)
					    {
					        if (::Math.rand(1, 100) <= 80) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 15) this.spawnUnit();
					    }
					    else if (res >= 375)
					    {
					        if (::Math.rand(1, 100) <= 65) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 10) this.spawnUnit();
					    }
					    else if (res >= 300)
					    {
					        if (::Math.rand(1, 100) <= 45) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 5) this.spawnUnit();
					    }
					    else
					    {
					        if (::Math.rand(1, 100) <= 25) this.spawnUnit();
					    }
					}},
					{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.0, StartingResourceMin = 300, ReqPartySize = 6, function onBeforeSpawnStart() {
					    base.onBeforeSpawnStart();
					    local res = this.getSpawnProcess().getStartingResources();
					    if (res >= 450)
					    {
					        if (::Math.rand(1, 100) <= 60) this.spawnUnit();
					    }
					    else if (res >= 375)
					    {
					        if (::Math.rand(1, 100) <= 40) this.spawnUnit();
					    }
					    else (res >= 300)
					    {
					        if (::Math.rand(1, 100) <= 20) this.spawnUnit();
					    }
					}}
				]
			}],
			[1, {
				ID = "VampiresAndSkeletons_1",
				HardMin = 5,
				DefaultFigure = "figure_vampire_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,

				function generateIdealSize( _isLocation = false )
				{
					local startingResources = this.getSpawnProcess().getStartingResources();
					if (startingResources >= 350)
					{
						return 12;
					}
					else if (startingResources >= 300)
					{
						return 10;
					}
					else
					{
						return 8
					}
				}

				UnitBlockDefs = [
					{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.01, RatioMax = 0.70 },
					{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.01, RatioMax = 0.70, HardMin = 3 },
					{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.0, StartingResourceMin = 250, ReqPartySize = 6, function onBeforeSpawnStart() {
					    base.onBeforeSpawnStart();
					    local res = this.getSpawnProcess().getStartingResources();
					    if (res >= 450)
					    {
					        if (::Math.rand(1, 100) <= 45) this.spawnUnit();
					    }
					    else if (res >= 375)
					    {
					        if (::Math.rand(1, 100) <= 35) this.spawnUnit();
					    }
					    else if (res >= 300)
					    {
					        if (::Math.rand(1, 100) <= 25) this.spawnUnit();
					    }
					    else
					    {
					        if (::Math.rand(1, 100) <= 15) this.spawnUnit();
					    }
					}},
					{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.0, StartingResourceMin = 300, ReqPartySize = 6, function onBeforeSpawnStart() {
					    base.onBeforeSpawnStart();
					    local res = this.getSpawnProcess().getStartingResources();
					    if (res >= 450)
					    {
					        if (::Math.rand(1, 100) <= 30) this.spawnUnit();
					    }
					    else if (res >= 375)
					    {
					        if (::Math.rand(1, 100) <= 20) this.spawnUnit();
					    }
					    else (res >= 300)
					    {
					        if (::Math.rand(1, 100) <= 10) this.spawnUnit();
					    }
					}}
				]
			}],
			[1, {
				ID = "VampiresAndSkeletons_2",
				HardMin = 5,
				DefaultFigure = "figure_vampire_01",
				MovementSpeedMult = 1.0,
				VisibilityMult = 1.0,
				VisionMult = 1.0,
				UnitBlockDefs = [
					{ BaseID = "UnitBlock.RF.SkeletonFrontline", RatioMin = 0.01, RatioMax = 0.70 },
					{ BaseID = "UnitBlock.RF.SkeletonElite", RatioMin = 0.01, RatioMax = 0.70 },
					{ BaseID = "UnitBlock.RF.Vampire", RatioMin = 0.01, RatioMax = 0.70, HardMin = 3 },
					{ BaseID = "UnitBlock.RF.SkeletonDecanus", RatioMax = 0.0, StartingResourceMin = 180, ReqPartySize = 6, function onBeforeSpawnStart() {
					    base.onBeforeSpawnStart();
					    local res = this.getSpawnProcess().getStartingResources();
					    if (res >= 300)
					    {
					        if (::Math.rand(1, 100) <= 65) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 15) this.spawnUnit();
					    }
					    else if (res >= 250)
					    {
					        if (::Math.rand(1, 100) <= 45) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 7) this.spawnUnit();
					    }
					    else
					    {
					        if (::Math.rand(1, 100) <= 25) this.spawnUnit();
					    }
					}},
					{ BaseID = "UnitBlock.RF.SkeletonCenturion", RatioMax = 0.0, StartingResourceMin = 250, ReqPartySize = 6, function onBeforeSpawnStart() {
					    base.onBeforeSpawnStart();
					    local res = this.getSpawnProcess().getStartingResources();
					    if (res >= 450)
					    {
					        if (::Math.rand(1, 100) <= 65) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 15) this.spawnUnit();
					    }
					    else if (res >= 375)
					    {
					        if (::Math.rand(1, 100) <= 60) this.spawnUnit();
					        if (::Math.rand(1, 100) <= 5) this.spawnUnit();
					    }
					    else if (res >= 300)
					    {
					        if (::Math.rand(1, 100) <= 40) this.spawnUnit();
					    }
					    else
					    {
					        if (::Math.rand(1, 100) <= 25) this.spawnUnit();
					    }
					}},
					{ BaseID = "UnitBlock.RF.SkeletonLegatus", RatioMax = 0.0, StartingResourceMin = 300, ReqPartySize = 6, function onBeforeSpawnStart() {
					    base.onBeforeSpawnStart();
					    local res = this.getSpawnProcess().getStartingResources();
					    if (res >= 450)
					    {
					        if (::Math.rand(1, 100) <= 50) this.spawnUnit();
					    }
					    else if (res >= 375)
					    {
					        if (::Math.rand(1, 100) <= 40) this.spawnUnit();
					    }
					    else (res >= 300)
					    {
					        if (::Math.rand(1, 100) <= 20) this.spawnUnit();
					    }
					}}
				]
			}]
		])
	},
	{
		ID = "SubPartyPrae",
		HardMin = 1,
		StaticUnitDefs = [
			{ BaseID = "Unit.RF.RF_SkeletonHeavyLesserBodyguard" }
		]
	},
	{
		ID = "SubPartyPrae2",
		HardMin = 2,
		StaticUnitDefs = [
			{ BaseID = "Unit.RF.RF_SkeletonHeavyLesserBodyguard" },
			{ BaseID = "Unit.RF.RF_SkeletonHeavyLesserBodyguard" }
		]
	},
	{
		ID = "SubPartyPraeHonor",
		HardMin = 1,
		StaticUnitDefs = [
			{ BaseID = "Unit.RF.RF_SkeletonHeavyLesserBodyguard" },
			{ BaseID = "Unit.RF.SkeletonHeavyBodyguard" }
		]
	},
	{
		ID = "SubPartyHonor2",
		HardMin = 2,
		StaticUnitDefs = [
			{ BaseID = "Unit.RF.SkeletonHeavyBodyguard" },
			{ BaseID = "Unit.RF.SkeletonHeavyBodyguard" }
		]
	},
	// {
	// 	ID = "SubPartySkeletonHeavy",
	// 	UnitBlockDefs = [
	// 		{ ID = "UnitBlock.RF_SkeletonHeavyBodyguard", RatioMin = 0.01, RatioMax = 1.00}
	// 	]
	// }
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
