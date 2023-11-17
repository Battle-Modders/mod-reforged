local generateBanditIdealSize = function( _spawnProcess, _isLocation = false )
{
	local startingResources = _spawnProcess.getStartingResources();
	if (startingResources >= 300)
	{
		return 14;
	}
	else if (startingResources >= 216)
	{
		return 12
	}
	else if (startingResources >= 164)
	{
		return 10;
	}
	else
	{
		return 8;
	}
}

local parties = [
	{
		ID = "BanditRoamers", // Spawn from patrol contract and send bandit raomers action.
		HardMin = 5,
		DefaultFigure = "figure_bandit_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UpgradeChance = 0.5,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.BanditBalanced", RatioMin = 0.20, RatioMax = 0.70 },
			{ BaseID = "UnitBlock.RF.BanditFast", RatioMin = 0.00, RatioMax = 0.40 },
			{ BaseID = "UnitBlock.RF.BanditTough", RatioMin = 0.00, RatioMax = 0.40 },
			{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.00, RatioMax = 0.35 },
			{ BaseID = "UnitBlock.RF.BanditDog", RatioMin = 0.00, RatioMax = 0.20 }
		]

		generateIdealSize( _isLocation = false )
		{
			return generateBanditIdealSize(this.getSpawnProcess(), _isLocation);
		}
	},
	{
		ID = "BanditScouts", // Only spawn from restore location contract
		HardMin = 7,
		DefaultFigure = "figure_bandit_02",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UpgradeChance = 0.5,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.BanditBalanced", RatioMin = 0.30, RatioMax = 0.70 },
			{ BaseID = "UnitBlock.RF.BanditFast", RatioMin = 0.00, RatioMax = 0.30 },
			{ BaseID = "UnitBlock.RF.BanditTough", RatioMin = 0.00, RatioMax = 0.30 },
			{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.00, RatioMax = 0.40 },
			{ BaseID = "UnitBlock.RF.BanditDog", RatioMin = 0.00, RatioMax = 0.20 }
		]

		function generateIdealSize( _isLocation = false )
		{
			return generateBanditIdealSize(this.getSpawnProcess(), _isLocation);
		}
	},
	{
		ID = "BanditRaiders",  // Spawn from defend settlment contract, discover location contract, escort caravan contract, investigate cemetary contract, patrol contract, return item contract, root out undead contract and send bandit ambushers action.
		HardMin = 5,
		DefaultFigure = "figure_bandit_02",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UpgradeChance = 0.5,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.BanditBalanced", RatioMin = 0.30, RatioMax = 0.70 },
			{ BaseID = "UnitBlock.RF.BanditFast", RatioMin = 0.00, RatioMax = 0.25 },
			{ BaseID = "UnitBlock.RF.BanditTough", RatioMin = 0.00, RatioMax = 0.25 },
			{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.00, RatioMax = 0.35 },
			{ BaseID = "UnitBlock.RF.BanditElite", RatioMin = 0.00, RatioMax = 0.35, StartingResourceMin = 320 },
			{ BaseID = "UnitBlock.RF.BanditBoss", RatioMin = 0.00, RatioMax = 0.11, StartingResourceMin = 180, DeterminesFigure = true }
		]

		function generateIdealSize( _isLocation = false )
		{
			return generateBanditIdealSize(this.getSpawnProcess(), _isLocation);
		}
	},
	{
		ID = "BanditDefenders",  // Spawn from deliver item contract, drive away bandits contract, bandit camp locations, bandit hideout locations, bandit ruins locations, man in forest event and defend bandits action.
		HardMin = 5,
		DefaultFigure = "figure_bandit_02",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UpgradeChance = 0.5,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.BanditBalanced", RatioMin = 0.40, RatioMax = 0.70 },
			{ BaseID = "UnitBlock.RF.BanditFast", RatioMin = 0.00, RatioMax = 0.30 },
			{ BaseID = "UnitBlock.RF.BanditTough", RatioMin = 0.00, RatioMax = 0.30 },
			{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.00, RatioMax = 0.25 },
			{ BaseID = "UnitBlock.RF.BanditElite", RatioMin = 0.00, RatioMax = 0.35 },
			{ BaseID = "UnitBlock.RF.BanditBoss", RatioMin = 0.0, RatioMax = 0.11 }
		]

		function generateIdealSize( _isLocation = false )
		{
			return generateBanditIdealSize(this.getSpawnProcess(), _isLocation);
		}
	},
	{
		ID = "BanditBoss",
		HardMin = 9,
		DefaultFigure = "figure_bandit_04",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UpgradeChance = 0.5,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.BanditBalanced", RatioMin = 0.40, RatioMax = 0.70 },
			{ BaseID = "UnitBlock.RF.BanditFast", RatioMin = 0.00, RatioMax = 0.30 },
			{ BaseID = "UnitBlock.RF.BanditTough", RatioMin = 0.00, RatioMax = 0.30 },
			{ BaseID = "UnitBlock.RF.BanditRanged", RatioMin = 0.00, RatioMax = 0.25 },
			{ BaseID = "UnitBlock.RF.BanditElite", RatioMin = 0.00, RatioMax = 0.35 },
			{ BaseID = "UnitBlock.RF.BanditBoss", RatioMin = 0.01, RatioMax = 0.11 }				// One boss is always guaranteed
		]

		function generateIdealSize( _isLocation = false )
		{
			return generateBanditIdealSize(this.getSpawnProcess(), _isLocation);
		}
	},
	{
		ID = "BanditsDisguisedAsDirewolves", // Only spawn from roaming beasts contract.
		HardMin = 3,
		DefaultFigure = "figure_werewolf_01",
		MovementSpeedMult = 1.0,
		VisibilityMult = 1.0,
		VisionMult = 1.0,
		UpgradeChance = 0.5,
		UnitBlockDefs = [
			{ BaseID = "UnitBlock.RF.BanditDisguisedDirewolf" }
		],

		function generateIdealSize( _isLocation = false )
		{
			return 8;
		}
	}
]

foreach(partyDef in parties)
{
	::DynamicSpawns.Public.registerParty(partyDef);
}
