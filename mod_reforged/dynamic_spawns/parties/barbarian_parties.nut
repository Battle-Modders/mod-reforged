local parties = [
	{
		// Vanilla: Size 4-28, Cost 48-900
		ID = "Barbarians",
		HardMin = 4,
		DefaultFigure = "figure_wildman_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BarbarianFrontline", RatioMin = 0.60, RatioMax = 1.00 },
				{ BaseID = "UnitBlock.RF.BarbarianSupport", HardMax = 2, RatioMax = 0.15, PartySizeMin = 10 },
				{ BaseID = "UnitBlock.RF.BarbarianDog", RatioMax = 0.4, PartySizeMin = 5, ExclusionChance = 70 },
				{ BaseID = "UnitBlock.RF.BarbarianBeastmaster", HardMax = 3, RatioMax = 0.15, PartySizeMin = 5}
			]
		},

		function onBeforeSpawnStart()
		{
			local res = this.getTopParty().getStartingResources();
			local frontline = this.getSpawnable("UnitBlock.RF.BarbarianFrontline");
			local support = this.getSpawnable("UnitBlock.RF.BarbarianSupport");
			local dog = this.getSpawnable("UnitBlock.RF.BarbarianDog");
			local beastmaster = this.getSpawnable("UnitBlock.RF.BarbarianBeastmaster");

			beastmaster.ExclusionChance = ::Reforged.Math.lerpClamp(res, 500, 70, 600, 30);
			beastmaster.SpawnWeightMult = ::Reforged.Math.lerpClamp(res, 500, 0.1, 900, 1.0);

			support.ExclusionChance = ::Reforged.Math.multilerp(res, [
				[200, 75],
				[300, 60],
				[400, 50],
				[600, 0]
			]);
			support.ExclusionChance = ::Reforged.Math.clamp(support.ExclusionChance, 0, 75);

			dog.RatioMax = ::Reforged.Math.lerpClamp(res, 200, 0.4, 600, 0.2);
			dog.StartingResourceMax = 600;

			// Chance to exclude Thrall at higher resources to help Marauders upgrade to Champions.
			local thrall = this.getSpawnable("Unit.RF.BarbarianThrall");
			thrall.ExclusionChance = ::Reforged.Math.multilerp(res, [
				[200, 25],
				[300, 50],
				[400, 75],
				[800, 100]
			]);
			thrall.ExclusionChance = ::Reforged.Math.clamp(thrall.ExclusionChance, 0, 100);
		}

		function getUpgradeChance()
		{
			return 25 + this.getTotal() * ::Reforged.Math.multilerp(this.getTopParty().getStartingResources(), [
				[200, 1.0],
				[300, 1.15],
				[400, 1.25],
				[800, 2.0]
			]);
		}
	},
	{
		// Vanilla: Size 5-19, Cost 56-214
		// In vanilla it is only Thralls and Warhounds.
		ID = "BarbarianHunters",
		HardMin = 5,
		DefaultFigure = "figure_wildman_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BarbarianHunterFrontline", RatioMin = 0.60, RatioMax = 1.0 },
				{ BaseID = "UnitBlock.RF.BarbarianDog", RatioMin = 0.3, RatioMax = 0.40 }
			]
		}
	},
	{
		// Is never spawned on its own, but rather is used by vanilla to add units (in vanilla only a Barbarian King)
		// to the party spawned by the Barbarian King Contract.
		ID = "BarbarianKing",
		DefaultFigure = "figure_wildman_04",
		StaticDefs = {
			Units = [
				{ BaseID = "Unit.RF.BarbarianChosen" }
			]
		}
	},

	// SubParties
	{
		ID = "OneUnhold",
		HardMin = 1,
		HardMax = 1,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BarbarianUnhold" }
			]
		}
	},
	{
		ID = "TwoUnhold",
		HardMin = 2,
		HardMax = 2,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BarbarianUnhold" }
			]
		}
	},
	{
		ID = "OneFrostUnhold",
		HardMin = 1,
		HardMax = 1,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BarbarianUnholdFrost" }
			]
		}
	},
	{
		ID = "TwoFrostUnhold",
		HardMin = 2,
		HardMax = 2,
		DynamicDefs = {
			UnitBlocks = [
				{ BaseID = "UnitBlock.RF.BarbarianUnholdFrost" }
			]
		}
	}
];

foreach(partyDef in parties)
{
	::Reforged.Spawns.Parties[partyDef.ID] <- partyDef;
}
