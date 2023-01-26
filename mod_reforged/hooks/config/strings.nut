::MSU.Table.merge(::Const.Strings.PerkName, {
	RF_Alert = "Alert",
	RF_Angler = "Angler",
	RF_BattleFervor = "Battle Fervor",
	RF_BackToBasics = "Back to Basics",
	RF_Skirmisher = "Skirmisher",
	RF_Ballistics = "Ballistics",
	RF_BattleFlow = "Battle Flow",
	RF_BearDown = "Bear Down",
	RF_BestialVigor = "Bestial Vigor",
	RF_BetweenTheEyes = "Between the Eyes",
	RF_BetweenTheRibs = "Between the Ribs",
	RF_Blitzkrieg = "Blitzkrieg",
	RF_Bloodbath = "Bloodbath",
	RF_Bloodlust = "Bloodlust",
	RF_DeathDealer = "Death Dealer",
	RF_Bolster = "Bolster",
	RF_BoneBreaker = "Bone Breaker",
	RF_Bully = "Bully",
	RF_Bulwark = "Bulwark",
	RF_Finesse = "Finesse",
	RF_ConcussiveStrikes = "Concussive Strikes",
	RF_Cull = "Cull",
	RF_DeepCuts = "Deep Cuts",
	RF_DeepImpact = "Deep Impact",
	RF_DentArmor = "Dent Armor",
	RF_DiscoveredTalent = "Discovered Talent",
	RF_Dismantle = "Dismantle",
	RF_DoubleStrike = "Double Strike",
	RF_EnGarde = "En Garde",
	RF_Entrenched = "Entrenched",
	RF_ExploitOpening = "Exploit Opening",
	RF_ExudeConfidence = "Exude Confidence",
	RF_EyesUp = "Eyes Up",
	RF_FailedPotential = "Failed Potential",
	RF_FamilyPride = "Family Pride",
	RF_Featherweight = "Featherweight",
	RF_Fencer = "Fencer",
	RF_FeralRage = "Feral Rage",
	RF_FlailSpinner = "Flail Spinner",
	RF_FlamingArrows = "Flaming Arrows",
	RF_FluidWeapon = "Fluid Weapon",
	RF_FollowUp = "Follow Up",
	RF_FormidableApproach = "Formidable Approach",
	RF_FreshAndFurious = "Fresh and Furious",
	RF_FromAllSides = "From all Sides",
	RF_FruitsOfLabor = "Fruits of Labor",
	RF_Ghostlike = "Ghostlike",
	RF_HaleAndHearty = "Hale and Hearty",
	RF_Heft = "Heft",
	RF_HipShooter = "Hip Shooter",
	RF_HoldSteady = "Hold Steady",
	RF_Hybridization = "Hybridization",
	InspiringPresence = "Inspiring Presence",
	RF_InternalHemorrhage = "Internal Hemorrhage",
	RF_Intimidate = "Intimidate",
	RF_IronSights = "Iron Sights",
	RF_Kata = "Kata",
	RF_Kingfisher = "Kingfisher",
	RF_KingOfAllWeapons = "King of all Weapons",
	RF_Leverage = "Leverage",
	RF_LineBreaker = "Line Breaker",
	RF_Poise = "Poise",
	RF_LongReach = "Long Reach",
	RF_ManOfSteel = "Man of Steel",
	RF_Marksmanship = "Marksmanship",
	RF_Menacing = "Menacing",
	RF_Momentum = "Momentum",
	RF_MuscleMemory = "Muscle Memory",
	RF_OffhandTraining = "Offhand Training",
	RF_Opportunist = "Opportunist",
	RF_PatternRecognition = "Pattern Recognition",
	RF_PersonalArmor = "Personal Armor",
	RF_Phalanx = "Phalanx",
	RF_PowerShot = "Power Shot",
	RF_Professional = "Professional",
	RF_PromisedPotential = "Promised Potential",
 	RF_ProximityThrowingSpecialist = "Proximity Throwing Specialist",
	RF_Onslaught = "Onslaught",
	RF_Rattle = "Rattle",
	RF_RealizedPotential = "Realized Potential",
	RF_RisingStar = "Rising Star",
	RF_Sanguinary = "Sanguinary",
	RF_SavageStrength = "Savage Strength",
	RF_ShieldSergeant = "Shield Sergeant",
	RF_SmallTarget = "Small Target",
	RF_ShieldSplitter = "Shield Splitter",
	RF_SneakAttack = "Sneak Attack",
	RF_SpearAdvantage = "Spear Advantage",
	RF_StrengthInNumbers = "Strength in Numbers",
	RF_SurvivalInstinct = "Survival Instinct",
	RF_SweepingStrikes = "Sweeping Strikes",
	RF_SwiftStabs = "Swift Stabs",
	RF_Swordlike = "Swordlike",
	RF_SwordmasterBladeDancer = "Blade Dancer",
	RF_SwordmasterGrappler = "Grappler",
	RF_SwordmasterJuggernaut = "Juggernaut",
	RF_SwordmasterMetzger = "Metzger",
 	RF_SwordmasterPrecise = "Precise",
	RF_SwordmasterReaper = "Reaper",
	RF_SwordmasterVersatileSwordsman = "Versatile Swordsman",
	RF_TakeAim = "Take Aim",
	RF_TargetPractice = "Target Practice",
	RF_Tempo = "Tempo",
	RF_TheRushOfBattle = "The Rush of Battle",
	RF_ThroughTheGaps = "Through the Gaps",
	RF_ThroughTheRanks = "Through the Ranks",
	RF_TraumaSurvivor = "Trauma Survivor",
	RF_TripArtist = "Trip Artist",
	RF_TwoForOne = "Two for One",
	RF_Unstoppable = "Unstoppable",
	RF_Retribution = "Retribution",
	RF_VengefulSpite = "Vengeful Spite",
	RF_Vigilant = "Vigilant",
	RF_VigorousAssault = "Vigorous Assault",
	RF_WeaponMaster = "Weapon Master",
	RF_WearThemDown = "Wear Them Down",
	RF_WearsItWell = "Wears it Well",
	RF_WhirlingDeath = "Whirling Death",
});

local vanillaDescriptions = [
	{
		ID = "perk.coup_de_grace",
		Key = "CoupDeGrace",
		Description = ::UPD.getDescription({
	 		Fluff = "\'Off with their heads!\'",
	 		Effects = [{
 				Type = ::UPD.EffectType.Passive,
 				Description = [
 					"Damage is increased by " + ::MSU.Text.colorGreen("20%") + " against enemies who have sustained an injury or are Sleeping, Stunned, Netted, Webbed, or Rooted."
 				]
 			}]
	 	}),
	},
	{
		ID = "perk.crippling_strikes",
		Key = "CripplingStrikes",
		Description = ::UPD.getDescription({
	 		Fluff = "Cripple your enemies!",
	 		Effects = [{
 				Type = ::UPD.EffectType.Passive,
 				Description = [
 					"Lowers the threshold to inflict injuries by " + ::MSU.Text.colorRed("33%") + " for both melee and ranged attacks.",
 					"Allows attacks to inflict injuries on the Undead."
 				]
 			}]
	 	}),
	},
	{
		ID = "perk.duelist",
		Key = "Duelist",
		Description = ::UPD.getDescription({
	 		Fluff = "Become one with your weapon and go for the weak spots!",
	 		Requirement = "Melee Attack",
	 		Effects = [{
 				Type = ::UPD.EffectType.Passive,
 				Description = [
 					"Additional damage ignores armor. This bonus is " + ::MSU.Text.colorGreen("25%") + " for one-handed weapons and " + ::MSU.Text.colorGreen("15%") + " for two-handed weapons.",
 					"Gain " + ::MSU.Text.colorGreen("+2") + " Reach when engaged with a single enemy, and " + ::MSU.Text.colorGreen("+1") + " when engaged with a maximum of 2 enemies."
 				]
 			}]
	 	}),
	 	Footer = ::MSU.Text.colorRed("This perk ONLY works with melee attacks with a Base Action Point cost of 4 or less that are either \'Lunge\' or have a Base Maximum Range of 1 tile.")
	},
	{
		ID = "perk.indomitable",
		Key = "Indomitable",
		Description = ::UPD.getDescription({
	 		Fluff = "\'Mountains cannot be moved, nor taken down!\'",
	 		Effects = [{
 				Type = ::UPD.EffectType.Active,
 				Name = "Indomitable",
 				Description = [
 					"Costs 5 AP and builds 25 Fatigue",
 					"Grants a " + ::MSU.Text.colorGreen("50%") + " damage reduction and immunity to being stunned, knocked back, grabbed, swallowed or culled for one turn."
 				]
 			}]
	 	}),
	 	Footer = ::MSU.Text.colorRed("This perk ONLY works with melee attacks with a Base Action Point cost of 4 or less that are either \'Lunge\' or have a Base Maximum Range of 1 tile.")
	},
	{
		ID = "perk.lone_wolf",
		Key = "LoneWolf",
		Description = ::UPD.getDescription({
	 		Fluff = "I work best alone.",
	 		Effects = [{
 				Type = ::UPD.EffectType.Passive,
 				Description = [
 					"With no ally within 2 tiles of distance, gain a " + ::MSU.Text.colorGreen("+15%") + " bonus to Melee Skill, Ranged Skill, Melee Defense, Ranged Defense, and Resolve."
 				]
 			}]
	 	}),
	},
	{
		ID = "perk.mastery.axe",
		Key = "SpecAxe",
		Description = ::UPD.getDescription({
	 		Fluff = "Master combat with axes and destroying shields.",
	 		Requirement = "Axe",
	 		Effects = [
		 		{
	 				Type = ::UPD.EffectType.Passive,
	 				Description = [
	 					"Skills build up " + ::MSU.Text.colorRed("25%") + " less Fatigue.",
	 					"Split Shield damage to shields is increased by " + ::MSU.Text.colorGreen("50%") + " when used with axes."
	 					"Round Swing gains " + ::MSU.Text.colorGreen("+5%") + " chance to hit."
	 					"The Longaxe no longer has a penalty for attacking targets directly adjacent.",
	 				]
	 			},
	 			{
	 				Type = ::UPD.EffectType.Active,
	 				Name = "Bearded Blade",
	 				Description = [
	 					"Costs 3 AP and builds 15 Fatigue",
	 					"Gain the \'Bearded Blade\' effect until your next attack or the start of your next turn.",
	 					"Causes your next attack, hit or miss, to have a chance equal to the hit chance to disarm the target.",
	 					"Attackers who miss against you have a chance to be disarmed equal to the miss chance. Expires upon a successful disarm."
	 				]
	 			}
 			]
	 	})
	},
	{
		ID = "perk.mastery.bow",
		Key = "SpecBow",
		Description = ::UPD.getDescription({
	 		Fluff = "Master the art of archery and pelting your opponents with arrows from afar.",
	 		Requirement = "Bow",
	 		Effects = [
		 		{
	 				Type = ::UPD.EffectType.Passive,
	 				Description = [
	 					"Skills build up " + ::MSU.Text.colorRed("25%") + " less Fatigue.",
	 					"View range and maximum shooting range with bows is increased by " + ::MSU.Text.colorGreen("+1") + "."
	 				]
	 			},
	 			{
	 				Type = ::UPD.EffectType.Active,
	 				Name = "Arrow to the Knee",
	 				Description = [
	 					"Costs 7 AP and builds 20 Fatigue",
	 					"Applies a debuff on the target for 2 turns reducing their Melee and Ranged Defense by " + ::MSU.Text.colorRed("-5") + " each and requiring them to spend " + ::MSU.Text.colorRed("2") + " additional Action Points per tile moved."
	 					"Deals " + ::MSU.Text.colorRed("50%") + " reduced Ranged Damage, and has no chance to hit the head."
	 				]
	 			}
 			]
	 	})
	},
	{
		ID = "perk.mastery.polearm",
		Key = "SpecPolearm",
		Description = ::UPD.getDescription({
	 		Fluff = "Master polearms and keeping the enemy at bay.",
	 		Requirement = "Polearm",
	 		Effects = [{
 				Type = ::UPD.EffectType.Passive,
 				Description = [
 					"Skills build up " + ::MSU.Text.colorRed("25%") + " less Fatigue.",
 					"All skills with two-handed weapons, with a range of 2 tiles, having an Action Point cost of " + ::MSU.Text.colorRed("6") + " have their Action Point cost reduced to " + ::MSU.Text.colorRed("5") + ", and no longer have a penalty for attacking targets directly adjacent."
 				]
 			}]
	 	}),
	},
	{
		ID = "perk.mastery.spear",
		Key = "SpecSpear",
		Description = ::UPD.getDescription({
	 		Fluff = "Master fighting with spears and keeping the enemy at bay.",
	 		Requirement = "Spear",
	 		Effects = [{
 				Type = ::UPD.EffectType.Passive,
 				Description = [
 					"Skills build up " + ::MSU.Text.colorRed("25%") + " less Fatigue.",
 					"The Action Point cost of Spearwall is reduced by " + ::MSU.Text.colorGreen("1") + ".",
 					"Spearwall is no longer disabled once an opponent manages to overcome it. Instead, Spearwall can still be used and continues to give free attacks on any further opponent attempting to enter the Zone of Control.",
 					"The Spetum and Warfork no longer have a penalty for attacking targets directly adjacent."
 				]
 			}]
	 	}),
	},
	{
		ID = "perk.mastery.throwing",
		Key = "SpecThrowing",
		Description = ::UPD.getDescription({
	 		Fluff = "Master throwing weapons to wound or kill the enemy before they even get close.",
	 		Requirement = "Throwing Weapon",
	 		Effects = [{
 				Type = ::UPD.EffectType.Passive,
 				Description = [
 					"Skills build up " + ::MSU.Text.colorRed("25%") + " less Fatigue.",
 					"Damage is increased by " + ::MSU.Text.colorGreen("20%") + " when attacking at a distance of 3 tiles or less.",
 					"Gain 20% of your Melee Skill as additional chance to hit when attacking at a distance of 3 tiles or less.",
 					"Throwing Spear ignores the target\'s damage reduction to shields from Shield Mastery."
 				]
 			}]
	 	}),
	},
	{
		ID = "perk.nimble",
		Key = "Nimble",
		Description = ::UPD.getDescription({
	 		Fluff = "Specialize in light armor! By nimbly dodging or deflecting blows, convert any hits to glancing hits.",
	 		Effects = [{
 				Type = ::UPD.EffectType.Passive,
 				Description = [
 					"Damage to Hitpoints is reduced by " + ::MSU.Text.colorGreen("50%") + " and that to armor by " + ::MSU.Text.colorGreen("25%") + ".",
 					"The bonus drops exponentially when wearing head and body armor with a total penalty to Maximum Fatigue above 15. The lighter your armor and helmet, the more you benefit.",
 					"Does not affect damage from mental attacks or status effects, but can help to avoid receiving them.",
 					"Brawny does not affect this perk."
 				]
 			}]
	 	}),
	},
	{
		ID = "perk.overwhelm",
		Key = "Overwhelm",
		Description = ::UPD.getDescription({
	 		Fluff = "Learn to take advantage of your high Initiative and prevent the enemy from attacking effectively by overwhelming them with your attacks!",
	 		Requirement = "Melee Attack",
	 		Effects = [{
 				Type = ::UPD.EffectType.Passive,
 				Description = [
 					"With every attack, hit or miss, against an opponent that acts after you in the current round, inflict the \'Overwhelmed\' status effect which lowers both Melee Skill and Ranged Skill by " + ::MSU.Text.colorRed("-10%") + " for one turn.",
 					"The effect stacks with each attack, up to a maximum of 7 times, and can be applied to multiple targets at once with a single attack."
 				]
 			}]
	 	}),
	},
	{
		ID = "perk.pathfinder",
		Key = "Pathfinder",
		Description = ::UPD.getDescription({
	 		Fluff = "Learn to move on difficult terrain.",
	 		Effects = [
		 		{
	 				Type = ::UPD.EffectType.Passive,
	 				Description = [
	 					"Action Point costs for movement on all terrain is reduced by " + ::MSU.Text.colorRed("-1") + " to a minimum of 2 Action Points per tile, and Fatigue cost is reduced to half.",
	 					"Changing height levels also has no additional Action Point cost anymore."
	 				]
	 			},
	 			{
	 				Type = ::UPD.EffectType.Active,
	 				Name = "Sprint",
	 				Description = [
	 					"Costs 0 AP and builds 10 Fatigue",
	 					"Further reduces the Action Point cost of movement on all terrain by " + ::MSU.Text.colorRed("-1") + ".",
	 					"Increases the Fatigue Cost of movement by " + ::MSU.Text.colorRed("20%") + "."
	 				]
	 			}
 			]
	 	}),
	},
	{
		ID = "perk.quick_hands",
		Key = "QuickHands",
		Description = ::UPD.getDescription({
	 		Fluff = "Looking for this?",
	 		Effects = [{
 				Type = ::UPD.EffectType.Passive,
 				Description = [
 					"Swapping any item in battle a free action with no Action Point cost once every turn.",
 					"Does not work when swapping a shield, or when swapping from one Two-Handed melee weapon to another Two-Handed melee weapon."
 				]
 			}]
	 	}),
	},
	{
		ID = "perk.shield_expert",
		Key = "ShieldExpert",
		Description = ::UPD.getDescription({
	 		Fluff = "Learn to better deflect hits to the side instead of blocking them head on.",
	 		Effects = [
		 		{
	 				Type = ::UPD.EffectType.Passive,
	 				Description = [
	 					"The shield defense bonus is increased by " + ::MSU.Text.colorGreen("25%") + ". This also applies to the additional defense bonus of the Shieldwall skill.",
	 					"Shield damage received is reduced by " + ::MSU.Text.colorRed("50%") + " to a minimum of 1.",
	 					"The \'Knock Back\' skill gains " + ::MSU.Text.colorGreen("+15%") + " chance to hit and now applies the Staggered effect.",
	 					"Missed attacks against you no longer increase your Fatigue."
	 				]
	 			},
	 			{
	 				Type = ::UPD.EffectType.Active,
	 				Name = "Cover Ally",
	 				Description = [
	 					"Costs 4 AP and builds 20 Fatigue",
	 					"Give an adjacent ally the \'Move Under Cover\' skill allowing them to move " + ::MSU.Text.colorGreen("1") + " tile ignoring Zone of Control.",
	 					"The ally\'s turn order in the next round is determined with " + ::MSU.Text.colorGreen("+5000") + " Initiative.",
	 					"Your Melee Skill, Ranged Skill, Melee Defense, and Ranged Defense are reduced by " + ::MSU.Text.colorRed("-15") + ".",
	 					"The effect expires if you are no longer adjacent to that ally."
	 				]
	 			}
 			]
	 	}),
	},
	{
		ID = "perk.steel_brow",
		Key = "SteelBrow",
		Description = ::UPD.getDescription({
	 		Fluff = "\'I can take it!\'",
	 		Effects = [{
 				Type = ::UPD.EffectType.Passive,
 				Description = [
 					"Hits to the head no longer cause critical damage to this character, which also lowers the risk of sustaining debilitating head injuries significantly."
 					"Grants passive immunity against Cull."
 				]
 			}]
	 	}),
	},
];

foreach (vanillaDesc in vanillaDescriptions)
{
	::UPD.setDescription(vanillaDesc.ID, vanillaDesc.Key, vanillaDesc.Description);
}

::MSU.Table.merge(::Const.Strings.PerkDescription, {
	RF_Alert = ::UPD.getDescription({
 		Fluff = "What was that over there?",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Initiative is increased by " + ::MSU.Text.colorGreen("20%") + "."
			]
		}]
 	}),
 	RF_Angler = ::UPD.getDescription({
 		Fluff = "Throw nets in a way that perfectly billows around your targets.",
 		Requirement = "Net",
 		Effects = [
 			{
 				Type = ::UPD.EffectType.Passive,
 				Description = ["Enemies have a " + ::MSU.Text.colorRed("-20%") + " chance to break from from nets you throw."]
 			},
 			{
 				Type = ::UPD.EffectType.Active,
 				Name = "Net Pull",
 				Description = [
 					"Costs 6 AP and builds 25 Fatigue",
 					"Can be used on a target up to 2 tiles away to pull them towards you and net them.",
 					"Does not gain the passive " + ::MSU.Text.colorRed("-20%") + " chance to break free."
 				]
 			}
 		]
 	}),
	RF_BattleFervor = ::UPD.getDescription({
 		Fluff = "It is our destiny!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Resolve is increased by " + ::MSU.Text.colorGreen("10%") + " at all times.",
				"Additionally, at positive morale checks, Resolve is increased by a further " + ::MSU.Text.colorGreen(10) + ".",
				"When at Confident Morale, all the bonuses of this perk are doubled, and Melee Skill, Ranged Skill, Melee Defense, and Ranged Defense are increased by " + ::MSU.Text.colorGreen("5%") + "."
			]
		}]
 	}),
	RF_BackToBasics = ::UPD.getDescription({
 		Fluff = "Captain told you to focus on the basics, trying fancy stuff is only going to get you killed!",
 		Effects = [{
			Type = ::UPD.EffectType.OneTimeEffect,
			Description = [
				"Gain 2 perk points.",
				"Drop your perk tree tier down to " + ::MSU.Text.colorRed(2) + ".",
			]
		}]
 	}),
	RF_Skirmisher = ::UPD.getDescription({
 		Fluff = "Gain increased speed and endurance by balancing your armor and mobility.",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The penalty to initiative from head and body armor is reduced by " + ::MSU.Text.colorRed("30%") + ".",
				"At all times your Initiative is reduced only by " + ::MSU.Text.colorGreen("50%") + " of accumulated Fatigue, instead of all of it.",
				"Stacks multiplicatively with the Relentless perk."
			]
		}]
 	}),
 	RF_Ballistics = ::UPD.getDescription({
 		Fluff = "Death from afar!",
 		Requirement = "Ranged Attack",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The penalty to hit chance per tile of distance is reduced by " + ::MSU.Text.colorGreen("2%") + "."
			]
		}]
 	}),
 	BattleFlow = ::UPD.getDescription({
 		Fluff = "On to the next!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Once per turn, making a kill reduces current Fatigue by " + ::MSU.Text.colorGreen("15%") + " of Base Maximum Fatigue."
			]
		}]
 	}),
 	RF_Ballistics = ::UPD.getDescription({
 		Fluff = "Take your time and get it right, just like the Captain says!",
 		Requirement = "Ranged Attack",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The penalty to hit chance per tile of distance is reduced by " + ::MSU.Text.colorGreen(2) + "."
			]
		}]
 	}),
	RF_BearDown = ::UPD.getDescription({
 		Fluff = "\'Give their \'ed a nice knock, then move in for the kill!\'",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Gain " + ::MSU.Text.colorGreen("+10") + " Melee Skill and Ranged Skill, and " + ::MSU.Text.colorGreen("+20%") + " chance to hit the head when attacking a rattled, stunned, dazed, netted, sleeping, staggered, webbed, or rooted target."
			]
		}]
 	}),
	RF_BestialVigor = ::UPD.getDescription({
 		Fluff = "Unleash the beast within!",
 		Effects = [{
			Type = ::UPD.EffectType.Active,
			Name = "Bestial Vigor",
			Description = [
				"Costs 0 AP and builds 0 Fatigue",
				"Reduce current Fatigue by " + ::MSU.Text.colorRed("50%") + " and gain " + ::MSU.Text.colorGreen("+3") + " Action Points for the current turn.",
				"Can only be used once per combat."
			]
		}]
 	}),
	RF_BetweenTheEyes = ::UPD.getDescription({
 		Fluff = "Like splitting butter!",
 		Requirement = "Melee Attack",
 		Effects = [{
			Type = ::UPD.EffectType.Active,
			Name = "Between the Eyes",
			Description = [
				"Costs 1 AP and builds 20 Fatigue",
				"The Action Point cost and Fatigue Cost of your weapon\'s primary melee attack is added to the costs of this skill.",
				"Perform your primary attack with an additional chance to hit the head equal to " + ::MSU.Text.colorGreen("50%") + " of your Melee Skill."
			]
		}]
 	}),
	RF_BetweenTheRibs = ::UPD.getDescription({
 		Fluff = "Striking when an enemy is distracted allows this character to aim for the vulnerable bits!",
 		Requirement = "Melee Piercing Attack",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Damage against surrounded targets is increased by " + ::MSU.Text.colorGreen("5%") + " per character surrounding the target."
			]
		}]
 	}),
	RF_Blitzkrieg = ::UPD.getDescription({
 		Fluff = "It will be over in a flash!",
 		Effects = [{
			Type = ::UPD.EffectType.Active,
			Name = "Blitzkrieg",
			Description = [
				"Costs 7 AP and builds 30 Fatigue",
				"You and other members of your company within 4 tiles, who have at least " + ::MSU.Text.colorRed(10) + " Fatigue remaining and are not Stunned or Fleeing, gain the Adrenaline effect.",
				"The affect allies build " + ::MSU.Text.colorRed(10) + " Fatigue.",
				"Is only usable once per day."
			]
		}]
 	}),
	RF_Bloodbath = ::UPD.getDescription({
 		Fluff = "There\'s something about removing someone\'s head that just makes you want to do it again!",
 		Requirement = "Melee Attack",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Fatalities instantly restore " + ::MSU.Text.colorGreen(3) + " Action Points.",
				"Can proc multiple times per turn, but only once per attack."
			]
		}]
 	}),
 	RF_Bloodlust = ::UPD.getDescription({
 		Fluff = "When surrounded by carnage, you feel revitalized and right at home!",
 		Requirement = "Melee Attack",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"During your turn, every successful attack reduces current Fatigue by " + ::MSU.Text.colorGreen("5%") + " per stack of Bleeding on the target and increases Fatigue Recovery by " + ::MSU.Text.colorGreen("+1") + " for one turn per stack of Bleeding on the target.",
				"Bleeding inflicted by the attack, or killing a target, also counts towards the bonus."
			]
		}]
 	}),
	RF_DeathDealer = ::UPD.getDescription({
 		Fluff = "Like wheat before a scythe!",
 		Requirement = "Melee AOE Attack",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Melee AOE attacks gain " + ::MSU.Text.colorGreen("+10%") + " chance to hit and deal " + ::MSU.Text.colorGreen("10%") + " increased damage."
			]
		}]
 	}),
	RF_Bolster = ::UPD.getDescription({
 		Fluff = "Your battle brothers feel confident when you\'re there backing them up!",
 		Requirement = "Weapon with 6 or more Reach",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Increase the Resolve of adjacent allies by " + ::MSU.Text.colorGreen("5%") + " of your Melee Skill. If multiple characters with this perk are present, only the highest bonus applies.",
				"When not engaged in melee, whenever you attack, hit or miss, trigger a Positive Morale Check for adjacent members of your company with a penalty to Resolve of " + ::MSU.Text.colorRed("50%") + "."
			]
		}]
 	}),
	RF_BoneBreaker = ::UPD.getDescription({
 		Fluff = "Snap, crunch, crumble. Music to your ears!",
 		Requirement = "Mace",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Attacks that do at least " + ::MSU.Text.colorRed(5) + " damage to Hitpoints and apply a valid status effect or are against characters with a valid status effect have a chance to inflict an injury. This chance is " + ::MSU.Text.colorGreen("100%") + " for two-handed maces and " + ::MSU.Text.colorGreen("50%") + " for one-handed maces.",
				"If the damage was sufficient to inflict an injury, it inflicts an additional injury.",
				"Valid status effects include: stunned, netted, webbed, rooted, sleeping."
			]
		}]
 	}),
	RF_Bully = ::UPD.getDescription({
 		Fluff = "Did you say stop?",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Attacks against characters with a lower Morale State than you deal " + ::MSU.Text.colorGreen("10%") + " increased damage per level of Morale State difference."
			]
		}]
 	}),
	RF_Bulwark = ::UPD.getDescription({
 		Fluff = "\'Not much to be afraid of behind a suit of plate!\'",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Gain " + ::MSU.Text.colorGreen("2%") + " of your combined head and body armor durability as Resolve.",
				"This bonus is doubled against negative morale checks except mental attacks."
			]
		}]
 	}),
	RF_Finesse = ::UPD.getDescription({
 		Fluff = "Years of combat training have given you insight into the most efficient way of carrying yourself on the battlefield.",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Fatigue build-up is reduced by " + ::MSU.Text.colorRed("20%") + "."
			]
		}]
 	}),
	RF_ConcussiveStrikes = ::UPD.getDescription({
 		Fluff = "A strike to the head from this character means goodnight!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Hits to the head with any weapon apply Dazed for 1 turn. This duration is increased to 2 turns for one-handed maces.",
				"Hits to the head with two-handed maces apply Stunned for 1 turn, and if the target is immune to being stunned, apply Dazed for 1 turn."
			]
		}]
 	}),
	RF_Cull = ::UPD.getDescription({
 		Fluff = "A strike to the head from this character means goodnight!",
 		Requirement = "Axe",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Hits to the head will instantly kill a target that has less than " + ::MSU.Text.colorRed("33%") + " Hitpoints remaining after the hit.",
				"Ignores the Nine Lives perk on the target.",
				"If killed via culling, decapitates the target."
			]
		}]
 	}),
	RF_DeepCuts = ::UPD.getDescription({
 		Fluff = "You know the best whetstone techniques to get your cutting edge wickedly sharp!",
 		Requirement = "Cutting Damage",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"During your turn, after a successful attack against a target, all subsequent attacks have a " + ::MSU.Text.colorRed("33%") + " reduced threshold to inflict injury and will inflict an additional stack of Bleeding for " + ::MSU.Text.colorRed(5) + " damage. This damage is increased to " + ::MSU.Text.colorRed(10) + " if any of the attacks inflicted an injury.",
				"The effect expires upon switching your target, moving, swapping an item, waiting or ending a turn, or using any skill except a cutting attack."
			]
		}]
 	}),
 	RF_DeepImpact = ::UPD.getDescription({
 		Fluff = "\'Roll out the barrel, feel it in your bones!\'",
 		Requirement = "Blunt Damage",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"An additional " + ::MSU.Text.colorRed("10%") + " of damage ignores armor."
			]
		}]
 	}),
	RF_DentArmor = ::UPD.getDescription({
 		Fluff = "\'Can\'t fight if they can\'t walk.\'",
 		Requirement = "Hammer and Blunt Damage",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Successful attacks have a chance to dent the target\'s armor for the remainder of the combat. Dented armor reduces Action Points by " + ::MSU.Text.colorRed(2) + ".",
				"The chance is " + ::MSU.Text.colorRed("66%") + " for two-handed hammers and " + ::MSU.Text.colorGreen("33%") + " for one-handed hammers.",
				"Only works when attacks hit an armor item with a maximum durability of at least 200.",
				"The affected target, or their allies, can use the \'Adjust Armor\' skill, when not engaged in melee, to remove the effect."
			]
		}]
 	}),
	RF_DiscoveredTalent = ::UPD.getDescription({
 		Fluff = "You don\'t know where it came from, but you\'ve suddenly started excelling at everything you do!",
 		Effects = [{
			Type = ::UPD.EffectType.OneTimeEffect,
			Description = [
				"Gain " + ::MSU.Text.colorGreen(1) + " star in the talents of all attributes.",
				"Then instantly gain a levelup to increase this character\'s attributes with normal rolls with talents.",
			]
		}]
		Footer = ::MSU.Text.colorRed("This perk cannot be refunded.")
 	}),
	RF_Dismantle = ::UPD.getDescription({
 		Fluff = "Strip them of their protection while they still wear it!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Every successful hit causes the target to receive a stacking " + ::MSU.Text.colorRed("+15%") + " additional damage ignoring armor from all sources for the remainder of the combat."
			]
		}]
 	}),
	RF_DoubleStrike = ::UPD.getDescription({
 		Fluff = "Here, take another one!",
 		Requirement = "Melee Attack",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"A successful hit increases the damage of your next attack(s) by " + ::MSU.Text.colorRed("20%") + ".",
				"The effect is lost upon moving, swapping an item, using any skill except a single-target attack, missing an attack, or waiting or ending your turn."
			]
		}]
 	}),
	RF_EnGarde = ::UPD.getDescription({
 		Fluff = "You\'ve become so well-practiced with a blade that attacking and defending are done congruously!",
 		Requirement = "Sword",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"When wielding a sword, if you have not moved from your position during your turn, use Riposte freely at the end of your turn if your weapon has Riposte.",
				"If your weapon does not have Riposte and is two-handed, gain the \'Return Favor\' effect instead until the start of your next turn.",
				"Does not build any Fatigue or cost any Action Points but only triggers if you have at least " + ::MSU.Text.colorRed(15) + " Fatigue remaining."
			]
		}]
 	}),
	RF_Entrenched = ::UPD.getDescription({
 		Fluff = "You\'ve learned to fight in formation, trusting in the comrades to your front and sides to keep you safe while you go to work!",
 		Requirement = "Ranged Weapon",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"When standing adjacent to an ally wielding a melee weapon who is not engaged in melee, gain " + ::MSU.Text.colorGreen("+7") + " Ranged Skill, Ranged Defense, and Resolve. The bonus increases by " + ::MSU.Text.colorGreen("+2") + " every turn up to a maximum of " + ::MSU.Text.colorGreen("+15") + " as long as you continue to start your turn adjacent to any ally wielding a melee weapon who is not engaged in melee.",
				"While entrenched, swapping between two ranged weapons becomes a free action once per turn."
			]
		}]
 	}),
	RF_ExploitOpening = ::UPD.getDescription({
 		Fluff = "A low shield. A slobby stab. A fake stumble. All are ways that you\'ve learned to tempt your opponent into a fatal false move!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Whenever an opponent misses a Melee attack against you, gain " + ::MSU.Text.colorGreen("+10%") + " chance to hit against them for your next attack.",
				"Unlocks the \'Riposte\' skill on southern curved swords such as the Shamshir and One-Handed versions of Saif and Scimitar."
			]
		}]
 	}),
	RF_ExudeConfidence = ::UPD.getDescription({
 		Fluff = "With you by their side, your comrades feel they can conquer mountains!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"At the start of your turn, improve the Morale state of adjacent allies by " + ::MSU.Text.colorGreen(1) + " as long as their Morale state is lower than yours."
			]
		}]
 	}),
	RF_EyesUp = ::UPD.getDescription({
 		Fluff = "Rain down arrows upon your enemies from a higher angle, forcing them to divert their attention!",
 		Requirement = "Bow",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Every attack, hit or miss, applies a stacking debuff on the target reducing their Melee Skill and Ranged Skill by " + ::MSU.Text.colorRed("-5") + " and Melee Defense by " + ::MSU.Text.colorRed("-3") + " for one turn.",
				"Only applies half a stack if the primary target is wielding a shield. Additionally, applies half a stack to enemies adjacent to the primary target who are not wielding shields. Bucklers do not count as shields for this perk.",
				"Can have a maximum of " + ::MSU.Text.colorGreen(10) + " stacks."
			]
		}]
 	}),
	RF_FailedPotential = ::UPD.getDescription({
 		Fluff = "This character looked promising, but either due to bad luck or simply lack of talent, they have not shown the potential you thought they had. " + ::MSU.Text.colorRed("This perk does nothing and cannot be refunded") + ".",
 	}),
	RF_FamilyPride = ::UPD.getDescription({
 		Fluff = "Death before dishonor!",
 		Effects = [
 			{
				Type = ::UPD.EffectType.Passive,
				Description = [
					"Always start battles at Confident morale.",
					"Morale checks can never drop your morale below Confident for the first " + ::MSU.Text.colorGreen(5) + " rounds of battle (the entire battle if you have the \'Determined\' trait) and below Steady after that."
				]
			},
			{
				Type = ::UPD.EffectType.OneTimeEffect,
				Description = [
					"Removes the \'Insecure\' and \'Dastard\' traits."
				]
			}
		]
 	}),
	RF_Featherweight = ::UPD.getDescription({
 		Fluff = "Take advantage of your weapon\'s light weight to maneuver around the battlefield faster than your enemies!",
 		Requirement = "Unarmed or weapon with Fatigue Penalty of 3 or less",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Gain " + ::MSU.Text.colorGreen("+1") + " Action Point."
			]
		}]
 	}),
	RF_Fencer = ::UPD.getDescription({
 		Fluff = "Master the art of fighting with a nimble sword.",
 		Requirement = "Unarmed or weapon with Fatigue Penalty of 3 or less",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Skills build up " + ::MSU.Text.colorRed("20%") + " less Fatigue and gain " + ::MSU.Text.colorGreen("+10%") + " chance to hit.",
				"When using a one-handed fencing sword, the Action Point costs of Sword Thrust, Riposte and Lunge are reduced by " + ::MSU.Text.colorGreen(1) + ".",
				"When using a two-handed fencing sword, the range of Lunge is increased by " + ::MSU.Text.colorGreen(1) + " tile."
			]
		}]
 	}),
	RF_FeralRage = ::UPD.getDescription({
 		Fluff = "Like sheep before a wolf!",
 		Requirement = "Melee Attack",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Gain stacking rage during combat. You gain 1 stack for getting hit, 3 for making a kill, 1 for every successful hit against an adjacent target with a skill with a base Action Point cost of 4 or less and 2 for greater.",
				"You lose 2 rage at the start of every turn.",
				"Each stack of rage increases Resolve, Initiative, and Damage by " + ::MSU.Text.colorGreen("+1") + ", lowers Melee Defense by " + ::MSU.Text.colorRed("-1") + ", and reduces incoming damage by " + ::MSU.Text.colorGreen("2%") + ".",
				"At 5 stacks, gain immunity to being Dazed and a " + ::MSU.Text.colorGreen("33%") + " chance to resist physical status effects such as Staggered, Distracted and Withered.",
				"At 7 stacks, additionally gain immunity to being Stunned.",
				"At 10 stacks, additionally gain immunity to being knocked back, grabbed or swallowed."
			]
		}]
 	}),
	RF_FlailSpinner = ::UPD.getDescription({
 		Fluff = "Use the momentum of your flail to enable quick follow-up blows!",
 		Requirement = "Flail",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Attacks have a " + ::MSU.Text.colorGreen("50%") + " chance to perform a free extra attack of the same type with " + ::MSU.Text.colorRed("50%") + " reduced damage."
			]
		}]
 	}),
	RF_FlamingArrows = ::UPD.getDescription({
 		Fluff = "Burn them all!",
 		Requirement = "Bow",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"A successful Aimed Shot will now light the target tile on fire for 2 rounds and trigger an additional morale check for the target and adjacent enemies."
			]
		}]
 	}),
	RF_FluidWeapon = ::UPD.getDescription({
 		Fluff = "A well-balanced sword is like an extension of yourself!",
 		Requirement = "Sword",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Initiative is increased by " + ::MSU.Text.colorGreen("35%") + " of the equipped sword\'s armor ignore damage percentage.",
				"The Fatigue Cost of weapon skills is reduced by " + ::MSU.Text.colorGreen("20%") + " of the equipped sword\'s armor effectiveness."
			]
		}]
 	}),
	RF_FollowUp = ::UPD.getDescription({
 		Fluff = "\'When your buddy\'s hittin\' \'em, you hit \'em too!\'",
 		Requirement = "Two-Handed Melee Weapon",
 		Effects = [{
			Type = ::UPD.EffectType.Active,
			Name = "Follow Up",
			Description = [
				"Costs 4 AP and builds 30 Fatigue",
				"Gain the \'Follow Up\' effect until your next turn. Under this effect:",
				"When wielding a two-handed melee weapon and not engaged in melee, perform a free attack with " + ::MSU.Text.colorRed("30%") + " reduced damage against enemies in your attack range who get successfully hit by your allies.",
				"Each susbequent attack increases the damage reduction by " + ::MSU.Text.colorRed("10%") + " up to a maximum of " + ::MSU.Text.colorRed("90%") + ".",
				"Attacks from Follow Up are non-lethal i.e. they cannot kill the target."
			]
		}]
 	}),
	RF_FormidableApproach = ::UPD.getDescription({
 		Fluff = "Make them think twice about getting close!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Your Reach is increased by " + ::MSU.Text.colorGreen("+2") + " against enemies in your zone of control, until they hit you.",
				"After being hit the effect expires, but is reset if the zone of control is broken."
			]
		}]
 	}),
	RF_FreshAndFurious = ::UPD.getDescription({
 		Fluff = "The period of vigor at the beginning of the fight is when you do the most damage!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"As long as your current Fatigue is below " + ::MSU.Text.colorRed("30%") + " of Maximum Fatigue after gear, the Action Point cost of the first skill used every turn is " + ::MSU.Text.colorGreen("halved") + " and its Fatigue Cost is reduced by " + ::MSU.Text.colorGreen("25%") + ".",
				"Does not expire when using a skill with no Action Point and Fatigue cost."
			]
		}]
 	}),
	RF_FromAllSides = ::UPD.getDescription({
 		Fluff = "You\'ve learned to use the unpredictable swings of your flail to keep your enemies guessing!",
 		Requirement = "Flail",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Successful hits from Flails progressively reduce the target's Melee and Ranged Defense by a stacking " + ::MSU.Text.colorRed(-3) + " for one turn.",
				"The effect is doubled if the attacks hit the head.",
				"Missed attacks reduce the target\'s defenses by " + ::MSU.Text.colorRed(-1) + " instead."
			]
		}]
 	}),
	RF_FruitsOfLabor = ::UPD.getDescription({
 		Fluff = "You\'ve quickly realized that your years of hard labor give you an edge in mercenary work!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Hitpoints, Maximum Fatigue, and Initiative are increased by " + ::MSU.Text.colorGreen("10%") + " of their respective base values."
			]
		}]
 	}),
 	RF_Ghostlike = ::UPD.getDescription({
 		Fluff = "Blink and you\'ll miss me.",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"When the number of adjacent allies is greater than or equal to the number of adjacent enemies, you may ignore Zone of Control for your next movement action."
			]
		}]
 	}),
	RF_HaleAndHearty = ::UPD.getDescription({
 		Fluff = "Years of hard labor have given you a stamina like none other!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Fatigue Recovery is increased by " + ::MSU.Text.colorGreen("5%") + " of your Maximum Fatigue after gear."
			]
		}]
 	}),
	RF_Heft = ::UPD.getDescription({
 		Fluff = "Take advantage of the weight of your axe to inflict maximum damage!",
 		Requirement = "Axe",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Maximum Damage is increased by " + ::MSU.Text.colorGreen("30%") + " of the Maximum Damage of the currently equipped axe."
			]
		}]
 	}),
	RF_HipShooter = ::UPD.getDescription({
 		Fluff = "They shall cower in the shade of your arrows!",
 		Requirement = "Bow",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The Action Point cost of Quick Shot is reduced by " + ::MSU.Text.colorGreen(1) + ".",
				"Each subsequent Quick Shot in a turn builds " + ::MSU.Text.colorRed("10%") + " more Fatigue."
			]
		}]
 	}),
	RF_HoldSteady = ::UPD.getDescription({
 		Fluff = "Direct your troops to stand their ground!",
 		Effects = [{
			Type = ::UPD.EffectType.Active,
			Name = "Hold Steady",
			Description = [
				"Costs 7 AP and builds 30 Fatigue",
				"You and any allies within 4 tiles who have at least " + ::MSU.Text.colorRed("10") + " Fatigue remaining gain " + ::MSU.Text.colorGreen("+10") + " Melee Defense and Ranged Defense, and immunity to being stunned, knocked back, grabbed, or swallowed for one turn.",
				"Affected allies build " + ::MSU.Text.colorRed("10") + " Fatigue."
			]
		}]
 	}),
	RF_Hybridization = ::UPD.getDescription({
 		Fluff = "\'Hatchet, throwing axe, spear, javelin... they all kill just the same!\'",
 		Requirement = "Bow",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Gain " + ::MSU.Text.colorGreen("10%") + " of your Base Ranged Skill as additional Melee Skill and Melee Defense."
			]
		}]
 	}),
	InspiringPresence = ::UPD.getDescription({
 		Fluff = "Standing next to the company\'s banner inspires your men to go beyond their limits!",
 		Requirement = "Banner",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Any member of your company who is adjacent to an enemy, or is adjacent to an ally who is adjacent to an enemy, gains " + ::MSU.Text.colorGreen("+3") + " Action Points as long as they start their turn adjacent to you."
			]
		}]
 	}),
	RF_InternalHemorrhage = ::UPD.getDescription({
 		Fluff = "Learn to strike at your target\'s softest spots, causing intense internal bleeding.",
 		Requirement = "Blunt Damage",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Blunt Damage attacks now apply the \'Hemorrhaging Internally\' effect that deals " + ::MSU.Text.colorGreen("20%") + " of the damage dealt to Hitpoints in that attack as Bleeding damage to the target at the end of their turn."
			]
		}]
 	}),
	RF_Intimidate = ::UPD.getDescription({
 		Fluff = "\'Trust me, ye don\'t want to be on the other end of a spike on a pole!\'",
 		Requirement = "Weapon with 6 or more Reach",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Attacks, hit or miss, trigger an additional Negative Morale Check."
			]
		}]
 	}),
	RF_IronSights = ::UPD.getDescription({
 		Fluff = "With a little tinkering, you\'ve managed to rig up sighting methods for your ranged weapons that allow more focused shots!",
 		Requirement = "Crossbow or Firearm",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Attacks have an additional " + ::MSU.Text.colorGreen("25%") + " chance to hit the head."
			]
		}]
 	}),
	RF_Kata = ::UPD.getDescription({
 		Fluff = "Practiced footwork allows you to dance around your opponents!",
 		Requirement = "Sword",
 		Effects = [{
			Type = ::UPD.EffectType.Active,
			Name = "Kata Step",
			Description = [
				"Costs 0 AP and builds 0 Fatigue",
				"This skill has variable cost. The Action Point cost is 2 less than the movement cost of your current tile. The Fatigue cost is equal to the movement cost of your current tile.",
				"Immediately after a successful attack, allows you to move one tile ignoring zone of control. However, the target tile for the movement must be adjacent to an enemy.",
				"Only works with Two-Handed swords or with One-Handed swords with the offhand free."
			]
		}]
 	}),
	RF_Kingfisher = ::UPD.getDescription({
 		Fluff = "\'There is no limit to how many times you can go fishing.\'",
 		Requirement = "Net",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"While holding a net, every successful melee attack against an adjacent target has a chance to net the target without expending your currently held net. The chance is equal to the hit chance of the attack.",
				"You cannot use or swap this net until the enemy escapes or dies.",
				"The net effect can be broken out of with 100% effectiveness",
				"Does not benefit from Angler."
			]
		}]
 	}),
	RF_KingOfAllWeapons = ::UPD.getDescription({
 		Fluff = "One King to rule them all!",
 		Requirement = "Spear",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"When starting your turn with a Spear equipped, the first Thrust or Prong during your turn costs no Action Points and builds no Fatigue, but does " + ::MSU.Text.colorRed("25%") + " reduced Damage.",
				"The effect is lost upon switching your weapon."
			]
		}]
 	}),
	RF_Leverage = ::UPD.getDescription({
 		Fluff = "Use the reach of your weapon to find an angle on the head!",
 		Requirement = "Weapon with a Max Range of 2 tiles",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"When attacking a target at a range of 2 tiles, gain " + ::MSU.Text.colorRed("+20%") + " chance to hi tthe head."
			]
		}]
 	}),
	RF_LineBreaker = ::UPD.getDescription({
 		Fluff = "\'Make way for the bad guy!\'",
 		Requirement = "Shield",
 		Effects = [{
			Type = ::UPD.EffectType.Active,
			Name = "Line Breaker",
			Description = [
				"Costs 4 AP and builds 25 Fatigue",
				"Knock back an enemy and take their place, all in one action."
			]
		}]
 	}),
	RF_Poise = ::UPD.getDescription({
 		Fluff = "Specialize in Medium Armor! Not as nimble as some but more lithe than others!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Damage to Hitpoints is reduced by " + ::MSU.Text.colorRed("30%") + " and to Armor by " + ::MSU.Text.colorRed("15%") + ".",
				"The bonus drops exponentially when wearing head and body armor with a total penalty to Maximum Fatigue above 35.",
				"Does not work if you have the Nimble perk."
			]
		}]
 	}),
	RF_LongReach = ::UPD.getDescription({
 		Fluff = "\'If the target is watchin\' the head of yer pike, they\'re sure not watchin\' their back!\'",
 		Requirement = "Polearm",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Enemies within 2 tiles are considered surrounded by you for the purposes of hit-chance bonus for any allies attacking that target."
			]
		}]
 	}),
 	RF_ManOfSteel = ::UPD.getDescription({
 		Fluff = "\'S\' is the symbol for \'Hope\'",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Armor penetrating damage received is reduced by " + ::MSU.Text.colorGreen("10%") + " of the current durability of the armor piece hit."
			]
		}]
 	}),
	RF_Marksmanship = ::UPD.getDescription({
 		Fluff = "Intuitively calculate wind velocity and distance to target your enemies\' weak spots!",
 		Requirement = "Ranged Weapon",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Gain " + ::MSU.Text.colorGreen("10%") + " of your Base Ranged Skill as additional Minimum and Maximum Damage."
			]
		}]
 	}),
	RF_Menacing = ::UPD.getDescription({
 		Fluff = "Your appearance gives your enemies a bit of doubt!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Lower the Resolve of adjacent enemies by " + ::MSU.Text.colorRed("-10") + "."
			]
		}]
 	}),
	RF_Momentum = ::UPD.getDescription({
 		Fluff = "\'Ye\'ve gotta get a running start!\'",
 		Requirement = "Throwing Weapon",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Throwing attacks do " + ::MSU.Text.colorGreen("5%") + " more damage and have their Action Point cost reduced by " + ::MSU.Text.colorGreen(1) + " per tile moved before throwing."
			]
		}]
 	}),
	RF_MuscleMemory = ::UPD.getDescription({
 		Fluff = "Load.. aim.. fire... repeat!",
 		Requirement = "Crossbow or Handgonne",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The Action Point Cost of reloading a Handgonne is reduced by " + ::MSU.Text.colorGreen(2) + ".",
				"When using a crossbow, for each point of current Ranged Skill above 90, damage is increased by " + ::MSU.Text.colorGreen("1%") + " up to a maximum of " + ::MSU.Text.colorGreen("30%") + "."
			]
		}]
 	}),
	RF_OffhandTraining = ::UPD.getDescription({
 		Fluff = "Frequent use of tools with your offhand has given you an enviable level of ambidexterity!",
 		Requirement = "Buckler or Tool",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Once per turn, the first use of the tool in your offhand costs no Action Points.",
				"Once per turn, switching a buckler or tool in your offhand costs no Action Points. Does not stack with other free item swapping skills e.g. Quick Hands."
			]
		}]
 	}),
	RF_Opportunist = ::UPD.getDescription({
 		Fluff = "\'I\'m not lootin\' Captain! Just grabbing my javelin!\'",
 		Requirement = "Throwing Weapon",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The first 2 throwing attacks during a combat have their Action Point costs " + ::MSU.Text.colorGreen("halved") + ".",
				"Every time you stand over an enemy\'s corpse during your turn, gain " + ::MSU.Text.colorGreen(1) + " ammo and restore " + ::MSU.Text.colorGreen(4) + " Action Points. Afterward, the next throwing attack has its Fatigue Cost " + ::MSU.Text.colorGreen("halved") + ".",
				"A corpse can only be used once per combat and cannot be used by multiple characters with this perk."
			]
		}]
 	}),
	RF_PatternRecognition = ::UPD.getDescription({
 		Fluff = "Your experience in battle has led to you being able to quickly adapt to an opponent\'s fighting style!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Every time an opponent attacks you or you attack an opponent, gain stacking Melee Skill and Melee Defense against that opponent for the remainder of the combat.",
				"Every subsequent attack gives a larger bonus, with the first attack giving " + ::MSU.Text.colorGreen("+1") + ", the second " + ::MSU.Text.colorGreen("+2") + ", the third " + ::MSU.Text.colorGreen("+3") + " and so on.",
				"Once the total bonus reaches " + ::MSU.Text.colorGreen(10) + ", all subsequent attacks increase it by " + ::MSU.Text.colorGreen("+1") + " only.",
				"Only works with dealing or receiving melee attacks."
			]
		}]
 	}),
 	RF_PersonalArmor = ::UPD.getDescription({
 		Fluff = "Give your own armor some of that special treatment!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Damage received to armor is reduced by " + ::MSU.Text.colorGreen("10%") + "."
			]
		}]
 	}),
 	RF_Phalanx = ::UPD.getDescription({
 		Fluff = "Learn the ancient art of fighting in a shielded formation.",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"When equipped with a shield, gain " + ::MSU.Text.colorGreen("+1") + " Reach per adjacent ally also equipped with a shield up to a maximum of " + ::MSU.Text.colorGreen("+2") + ".",
				"Bucklers do not count as shields for this perk."
			]
		}]
 	}),
	RF_PowerShot = ::UPD.getDescription({
 		Fluff = "Learn where to aim to hinder your enemies the most!",
 		Requirement = "Crossbow or Firearm",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Attacks from crossbows and firearms have a " + ::MSU.Text.colorGreen("50%") + " chance to inflict Staggered for one turn."
			]
		}]
 	}),
	RF_Professional = ::UPD.getDescription({
 		Fluff = "You\'re a professional, experienced fighter, able to wield many weapons in many styles!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Gain the \'Shield Expert\', \'Duelist\', \'Weapon Master\', \'Bloody Harvest\', and \'Formidable Approach\' perks as long as you have a weapon equipped."
			]
		}]
 	}),
	RF_PromisedPotential = ::UPD.getDescription({
 		Fluff = "The Captain said he\'d take a gamble on you, but you\'d better not disappoint!",
 		Effects = [{
			Type = ::UPD.EffectType.OneTimeEffect,
			Description = [
				"This perk remains inert until level 11."
				"Upon reaching level 11, it has a " + ::MSU.Text.colorGreen("50%") + " chance of being replaced with \'Realized Potential\' which will double this character\'s salary, increase all attributes by " + ::MSU.Text.colorGreen("+15") + ", unlock new perk groups, and refund all perk points, including the one spent on this perk.",
				"If unsuccessful, it is replaced by \'Failed Potential\' which does nothing."
				"The success chance is reduced by " + ::MSU.Text.colorRed("-10%") + " per perk point already spent before picking this perk. Only perks you spend perk points on are counted for this reduction."
			]
		}]
 	}),
	RF_ProximityThrowingSpecialist = ::UPD.getDescription({
 		Fluff = "\'Don\'t attack until you\'ve seen the whites of their eyes!\'",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Damage is increased by " + ::MSU.Text.colorGreen("20%") + " when attacking at 2 tiles of distance.",
				"Piercing type throwing attacks have a " + ::MSU.Text.colorGreen("50%") + " chance to inflict the \'Arrow to the Knee\' effect.",
				"Cutting type throwing attacks always apply the \'Overwhelmed\' effect.",
				"Blunt type throwing attacks have a " + ::MSU.Text.colorGreen("100%") + " chance to inflict Staggered and if the target is already Staggered, inflict Stunned.",
				"The damage bonus and chance applies up to a distance of 2 tiles, is halved at 3 tiles of distance, and does not apply at longer distances."
			]
		}]
 	}),
	RF_Onslaught = ::UPD.getDescription({
 		Fluff = "Break their ranks, break their backs, break them all!",
 		Effects = [{
			Type = ::UPD.EffectType.Active,
			Name = "Onslaught",
			Description = [
				"Costs 7 AP and builds 30 Fatigue",
				"You and other members of your company within 4 tiles, who have at least " + ::MSU.Text.colorRed(10) + " Fatigue remaining and are not Fleeing or Stunned, gain " + ::MSU.Text.colorGreen("+20") + " Initiative, " + ::MSU.Text.colorGreen("+10") + " Melee Skill and the \'Line Breaker\' skill for one turn.",
				"The first use of this \'Line Breaker\' skill costs " + ::MSU.Text.colorGreen(1) + " fewer Action Point and builds " + ::MSU.Text.colorGreen(10) + " less Fatigue.",
				"The affected allies build " + ::MSU.Text.colorRed(10) + " Fatigue."
			]
		}]
 	}),
	RF_Rattle = ::UPD.getDescription({
 		Fluff = "Rattle your enemies to their bones to weaken them!",
 		Requirement = "Blunt Damage",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Every attack from a mace, or from other weapons that does at least " + ::MSU.Text.colorRed(10) + " damage, applies the \'Rattled\' effect which reduces the target\'s Melee Defense by " + ::MSU.Text.colorRed(-10) + " for one turn."
			]
		}]
 	}),
	RF_RealizedPotential = ::UPD.getDescription({
 		Fluff = "From rags to riches! This character has truly come a long way. Who was once a dreg of society is now a full-fledged mercenary. " + ::MSU.Text.colorGreen("All perk points have been refunded and attributes increased. This perk cannot be refunded") + ".",
 	}),
	RF_RisingStar = ::UPD.getDescription({
 		Fluff = "Captain said take it slow and steady and I could become a legend someday!",
 		Effects = [
	 		{
				Type = ::UPD.EffectType.Passive,
				Description = [
					"Experience gained is increased by " + ::MSU.Text.colorGreen("20%") + " for the next 5 levels and by " + ::MSU.Text.colorGreen("5%") + " after that."
				]
			},
			{
				Type = ::UPD.EffectType.OneTimeEffect,
				Description = [
					"Gain " + ::MSU.Text.colorGreen(2) + " perk points upon completing your next 5 levels after picking this perk."
				]
			}
		],
		Footer = ::MSU.Text.colorRed("This perk cannot be refunded.")
 	}),
	RF_Sanguinary = ::UPD.getDescription({
 		Fluff = "Fountain of Blood!",
 		Requirement = "Melee Attack",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The chance to inflict fatalities is increased by " + ::MSU.Text.colorGreen("50%") + ".",
				"Fatalities refund " + ::MSU.Text.colorGreen("25%") + " of the Base Fatigue Cost of the skill used.",
				"During your turn, every successful attack that applies Bleeding, or is against an already bleeding target, improves your Morale by one level up to a maximum of Steady, and fatalities instantly set the Morale to Confident."
			]
		}]
 	}),
	RF_SavageStrength = ::UPD.getDescription({
 		Fluff = "Orcs call me brother!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The Fatigue Cost of weapon skills is reduced by " + ::MSU.Text.colorRed("25%") + "."
			]
		}]
 	}),
	RF_ShieldSergeant = ::UPD.getDescription({
 		Fluff = "Lock and Shield",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Allies with a shield will use Shieldwall for free at the start of each battle.",
				"Allies within 2 tiles have the Action Point and Fatigue costs of Shieldwall halved. Cannot reduce the Action Point cost below " + ::MSU.Text.colorRed(2) + ".",
				"If you have the Shieldwall skill available, any ally who starts or ends their turn adjacent to you will use Shieldwall for free."
				"You will use Shieldwall for free as long as you start or end your turn adjacent to an ally who has the Shieldwall skill available."
				"Only members of your company are considered allies for this perk."
			]
		}]
 	}),
	RF_SmallTarget = ::UPD.getDescription({
 		Fluff = "Training against melons of all types has given you a penchant for hitting heads!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"All attacks, melee or ranged, gain " + ::MSU.Text.colorGreen("+10%") + " chance to hit the head.",
			]
		}]
 	}),
	RF_ShieldSplitter = ::UPD.getDescription({
 		Fluff = "\'If you can\'t get around it, try smashing through. It works!\'",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Upon destroying a shield using the \'Split Shield\' skill, with any weapon, " + ::MSU.Text.colorGreen(4) + " Action Points are instantly restored.",
			]
		}]
 	}),
	RF_SneakAttack = ::UPD.getDescription({
 		Fluff = "\'If you can see me, you\'re already dead.\'",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Only works when wielding a one-handed melee weapon with a Reach of " + ::MSU.Text.colorRed(4) + " or less and a total penalty to Fatigue from head and body armor less than " + ::MSU.Text.colorRed(20) + ".",
				"When you enter a tile adjacent to an enemy, your next attack gains " + ::MSU.Text.colorGreen("+2") + " Reach, has " + ::MSU.Text.colorGreen("+20%") + " armor penetration and deals " + ::MSU.Text.colorGreen("25%") + " increased damage."
				"The effect is lost upon switching an item, waiting or ending your turn, or using any skill.",
				"Ranged attacks gain " + ::MSU.Text.colorGreen("+10%") + " armor penetration and " + ::MSU.Text.colorGreen("15%") + " increased damage against targets you have not previously attacked and who have not previously attacked you."
			]
		}]
 	}),
	RF_SpearAdvantage = ::UPD.getDescription({
 		Fluff = "Stick \'em with the pointy end.",
 		Requirement = "Spear",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Every successful hit against an opponent increases your Melee Skill and Melee Defense against that opponent by " + ::MSU.Text.colorGreen("+5") + " up to a maximum of " + ::MSU.Text.colorGreen("+20") + ".",
				"This bonus does not expire on its own but is lost upon taking damage from that opponent."
			]
		}]
 	}),
	RF_StrengthInNumbers = ::UPD.getDescription({
 		Fluff = "\'Yeah, skill doesn\'t mean so much when you\'re surrounded by 10 angry townsfolk with sharp pitchforks!\'",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Gain " + ::MSU.Text.colorGreen("+2") + " Melee Skill, Ranged Skill, Melee  Defense and Ranged Defense for each adjacent ally.",
				"Gain " + ::MSU.Text.colorGreen("+1") + " Resolve for each ally on the battlefield, up to a maximum of " + ::MSU.Text.colorGreen("+20") + "."
			]
		}]
 	}),
	RF_SurvivalInstinct = ::UPD.getDescription({
 		Fluff = "Your will to live is strong!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Whenever you are attacked, gain a stacking bonus to Melee and Ranged Defense of " + ::MSU.Text.colorGreen("+2") + " on a miss and " + ::MSU.Text.colorGreen("+5") + " on a hit.",
				"At the start of every turn the bonus is reset except the bonus gained from getting hit which is retained for the remainder of the combat. This retained bonus cannot be higher than " + ::MSU.Text.colorGreen("+10") + "."
			]
		}]
 	}),
	RF_SweepingStrikes = ::UPD.getDescription({
 		Fluff = "Keep your enemies at bay with the sweeping swings of your weapon!",
 		Requirement = "Weapon with a Reach of 3 or greater"
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Attacks, hit or miss, increase your Reach by " + ::MSU.Text.colorGreen("+3") + " for AOE attacks, and " + ::MSU.Text.colorGreen("+1") + " for regular attacks until the start of your next turn.",
			]
		}]
 	}),
	RF_SwiftStabs = ::UPD.getDescription({
 		Fluff = "Create an opening, then finish them!",
 		Requirement = "Non-hybrid Dagger"
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"A successful attack with your mainhand dagger reduces the Action Point cost of all its skills by " + ::MSU.Text.colorGreen("2") + " to a minimum of " + ::MSU.Text.colorGreen("2") + " for the remainder of this turn.",
				"The effect expires upon missing an attack, switching your weapon, switching the target, killing the target, or using any skill that is not a dagger attack.",
			]
		}]
 	}),
	RF_Swordlike = ::UPD.getDescription({
 		Fluff = "Cleaver... sword... pretty much the same thing, right?",
 		Requirement = "Cleaver with a range of 1 tile"
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Cleaver attacks gain " + ::MSU.Text.colorGreen("+10%") + " chance to hit."
			]
		}]
 	}),
	RF_SwordmasterBladeDancer = ::UPD.getDescription({
 		Fluff = "Let's Dance!",
 		Requirement = "Non-hybrid Sword"
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"When using a non-fencing sword, the Action Point costs of sword skills is reduced by " + ::MSU.Text.colorGreen(1) + ".",
				"Allows \'Kata Step\' to be usable even while holding something, e.g. a shield, in your offhand.",
				"\'Kata Step\' costs " + ::MSU.Text.colorGreen(2) + " fewer Action Points and builds " + ::MSU.Text.colorGreen(2) + " less Fatigue, both down to a minimum of 0."
			]
		}],
		Footer = ::MSU.Text.colorRed("You can only pick ONE perk from the Swordmaster perk group.")
 	}),
	RF_SwordmasterGrappler = ::UPD.getDescription({
 		Fluff = "You have to fight for your place in this world.",
 		Requirement = "Non-hybrid Sword"
 		Effects = [
	 		{
				Type = ::UPD.EffectType.Active,
				Name = "Kick",
				Description = [
					"Costs 4 AP and builds 20 Fatigue",
					"Knocks back and staggers the target."
					"When using a two-handed sword or double-gripping a one-handed sword, the Action Point cost is reduced by " + ::MSU.Text.colorGreen(1) + " and the Fatigue Cost by " + ::MSU.Text.colorGreen(5) + "."

				]
			},
			{
				Type = ::UPD.EffectType.Active,
				Name = "Push Through",
				Description = [
					"Costs 4 AP and builds 25 Fatigue",
					"Allows you to knock back and stagger a target while moving into their tile in one action."

				]
			},
			{
				Type = ::UPD.EffectType.Active,
				Name = "Tackle",
				Description = [
					"Costs 6 AP and builds 25 Fatigue",
					"Allows you to exchange positions with and stagger an adjacent target.",
					"Requires a two-handed or double-gripped one-handed sword."

				]
			}
		],
		Footer = ::MSU.Text.colorRed("You can only pick ONE perk from the Swordmaster perk group.")
 	}),
	RF_SwordmasterJuggernaut = ::UPD.getDescription({
 		Fluff = "There\'s a fine line between bravery and stupidity.",
 		Requirement = "Non-hybrid Two-Handed Sword"
 		Effects = [
	 		{
				Type = ::UPD.EffectType.Passive,
				Description = [
					"Each single-target attack additionally does an attack on a random adjacent enemy to the target with " + ::MSU.Text.colorRed("50%") + " reduced damage."

				]
			},
			{
				Type = ::UPD.EffectType.Active,
				Name = "Juggernaut Charge",
				Description = [
					"Costs 5 AP and builds 25 Fatigue",
					"Immediately gain the \'Indomitable\' effect that lasts until your next turn.",
					"Charge towards a tile up to 2 tiles away, staggering all enemies adjacent to that tile and performing a free attack against a random enemy that does " + ::MSU.Text.colorGreen("50%") + " increased damage (allows you to close the gap with targets up to 3 tiles away).",
					"Can only be used once per turn and cannot be used when engaged in melee."
				]
			}
		],
		Footer = ::MSU.Text.colorRed("You can only pick ONE perk from the Swordmaster perk group.")
 	}),
	RF_SwordmasterMetzger = ::UPD.getDescription({
 		Fluff = "A sword, too, can take someone\'s head off just fine!",
 		Requirement = "Non-hybrid Southern Sword"
 		Effects = [
	 		{
				Type = ::UPD.EffectType.Passive,
				Description = [
					"Adds the \'Decapitate\' skill to southern swords.",
					"Grants the \'Sanguinary\' and \'Bloodbath\' perks for free as long as a southern sword is equipped.",
					"\n• Attacks inflict \'Bleeding\' on the target for " + ::MSU.Text.colorRed(10) + " damage."
				]
			},
			{
				Type = ::UPD.EffectType.OneTimeEffect,
				Description = [
					"Adds the Cleaver perk group to this character\'s perk tree, except the perks which require a Cleaver."
				]
			}
		],
		Footer = ::MSU.Text.colorRed("You can only pick ONE perk from the Swordmaster perk group.")
 	}),
 	RF_SwordmasterPrecise = ::UPD.getDescription({
 		Fluff = "Let me show you how to thread a needle... blindfolded!",
 		Requirement = "Non-hybrid Sword"
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The bonuses of the \'Swordmaster\'s Training\' or \'Swordmaster\'s Finesse\' effect are doubled."
				"While wielding a Fencing Sword an additional " + ::MSU.Text.colorGreen("25%") + " of damage ignores armor."
			]
		}],
		Footer = ::MSU.Text.colorRed("You can only pick ONE perk from the Swordmaster perk group.")
 	}),
	RF_SwordmasterReaper = ::UPD.getDescription({
 		Fluff = "Bring in the harvest!",
 		Requirement = "Non-Hybrid Sword"
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The Action Point costs of AOE sword skills is reduced by " + ::MSU.Text.colorGreen(2) + " and the Fatigue Cost by " + ::MSU.Text.colorGreen("10%") + "."
			]
		}],
		Footer = ::MSU.Text.colorRed("You can only pick ONE perk from the Swordmaster perk group.")
 	}),
	RF_SwordmasterVersatileSwordsman = ::UPD.getDescription({
 		Fluff = "King of all trades. Jack of none.",
 		Requirement = "Non-hybrid Sword"
 		Effects = [
	 		{
				Type = ::UPD.EffectType.Active,
				Name = "Stance: Half-Swording",
				Description = [
					"Costs 3 AP and builds 1 Fatigue to switch",
					"While this stance is active, all the skills of the equipped sword are removed and replaced with \'Puncture\'."
					"Requires a two-handed sword or double-gripped one-handed sword."

				]
			},
			{
				Type = ::UPD.EffectType.Active,
				Name = "Stance: Reverse Grip",
				Description = [
					"Costs 3 AP and builds 1 Fatigue to switch",
					"While this stance is active, all the skills of the equipped sword are removed and replaced with \'Cudgel\' and \'Strike Down\' for two-handed swords and \'Bash\' and \'Knock Out\' for one-handed swords.",
					"Requires a two-handed sword or double-gripped one-handed sword.This is the default stance. While this stance is active, moving from your position no longer disables the En Garde perk."

				]
			},
			{
				Type = ::UPD.EffectType.Active,
				Name = "Stance: Meisterhau",
				Description = [
					"Costs 3 AP and builds 1 Fatigue to switch",
					"While this stance is active, moving from your position no longer disables the En Garde perk.",
					"This is the default stance."
				]
			}
		],
		Footer = ::MSU.Text.colorRed("You can only pick ONE perk from the Swordmaster perk group.")
 	}),
	RF_TakeAim = ::UPD.getDescription({
 		Fluff = "You\'ve learned the value of taking time with your shots when the situation calls for it!",
 		Requirement = "Crossbow or Handgonne",
 		Effects = [{
			Type = ::UPD.EffectType.Active,
			Name = "Take Aim",
			Description = [
				"Applies to your next attack during this turn only.",
				"For crossbows, the attack ignores the hitchance penalty from obstacles and the shot cannot go astray.",
				"For Handgonnes the attack has its Maximum Range increased by " + ::MSU.Text.colorGreen(1) + " and if used at a shorter range, the area of effect is increased by " + ::MSU.Text.colorGreen(1) + " instead."
			]
		}]
 	}),
	RF_TargetPractice = ::UPD.getDescription({
 		Fluff = "Time in training has allowed you to come up with an efficient way to organize your ammo, while increasing your accuracy!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Swapping quivers or bags of ammo never costs any Action Points.",
				"Ranged attacks gain " + ::MSU.Text.colorGreen("+10%") + " chance to hit against enemies wielding ranged weapons or enemies with none of their allies adjacent to them."
			]
		}]
 	}),
	RF_Tempo = ::UPD.getDescription({
 		Fluff = "By keeping ahead of your opponent, you set the terms of engagement!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Every attack, hit or miss, against a target who acts after you in the current round increases your Initiative by " + ::MSU.Text.colorGreen("+15") + ".",
				"The bonus lasts over into your next turn but only until the first skill used or waiting that turn."
			]
		}]
 	}),
	RF_TheRushOfBattle = ::UPD.getDescription({
 		Fluff = "\'It\'s not uncommon to make it to the end of the battle not remembering any details, just that you slew many men!\'",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Whenever you are attacked, hit or miss, gain a stacking " + ::MSU.Text.colorGreen("+5") + " Initiative and " + ::MSU.Text.colorGreen("+5%") + " reduction to the Fatigue Cost of skills during your next turn, up to a maximum of " + ::MSU.Text.colorGreen("+25") + " and " + ::MSU.Text.colorGreen("+25%") + " respectively."
			]
		}]
 	}),
	RF_ThroughTheGaps = ::UPD.getDescription({
 		Fluff = "Learn to call your strikes and target gaps in your opponents\' armor!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Requirement = "Melee Piercing Attack",
			Description = [
				"Your attacks ignore an additional " + ::MSU.Text.colorGreen("15%") + " of the target\'s armor."
			]
		}]
 	}),
	RF_ThroughTheRanks = ::UPD.getDescription({
 		Fluff = "\'My projectiles find their own way\'",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Ranged attacks have a " + ::MSU.Text.colorGreen("50%") + " reduced chance to inflict friendly fire."
			]
		}]
 	}),
	RF_TraumaSurvivor = ::UPD.getDescription({
 		Fluff = "You\'ve been to hell, and back.",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Resolve is increased by " + ::MSU.Text.colorGreen("50%") + " against negative morale checks.",
				"If Promised Potential is a success, this perk becomes permanent and the perk point is refunded."
			]
		}]
 	}),
	RF_TripArtist = ::UPD.getDescription({
 		Fluff = "\'Let me take you on a trip to the floor.\'",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The first attack every turn against an adjacent target will apply the Staggered effect.",
				"When wielding a weapon with a Reach of less than 4, gain the difference in Reach up to 4."
			]
		}]
 	}),
	RF_TwoForOne = ::UPD.getDescription({
 		Fluff = "Practice in spear-handling has taught you to strike in the most efficient way possible!",
 		Requirement = "Spear",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The Action Point cost of Thrust, Glaive Slash, and Prong is reduced by " + ::MSU.Text.colorGreen(1) + ".",
				"When double-gripping one-handed spears, the range of Thrust is increased to " + ::MSU.Text.colorGreen(2) + " tiles. When used at this range, it does " + ::MSU.Text.colorRed("20%") + " reduced damage, has no bonus chance to hit, and has " + ::MSU.Text.colorRed("-20%") + " chance to hit per character between you and the target."
			]
		}]
 	}),
	RF_Unstoppable = ::UPD.getDescription({
 		Fluff = "Once you get going, you cannot be stopped!",
 		Requirement = "Melee Attack,"
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"During your turn, every successful attack provides a stacking bonus to Melee Skill and Action Points.",
				"Each stack increases Melee Skill by " + ::MSU.Text.colorGreen("+5") + ".",
				"Your Action Points are increased by a total of " + ::MSU.Text.colorGreen("+1") + " at 3 stacks, " + ::MSU.Text.colorGreen("+2") + " at 6 stacks and " + ::MSU.Text.colorGreen("+3") + " at 10 stacks.",
				"Attacks at 2 tiles range only grant a stack after two successful hits.",
				"You lose half of the stacks if you miss an attack or if you get hit.",
				"Cannot have more than 10 stacks."
			]
		}]
 	}),
	RF_Retribution = ::UPD.getDescription({
 		Fluff = "Revenge is a dish best served with a vengeance.",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Every time you are hit, gain a stacking " + ::MSU.Text.colorGreen("25%") + " damage bonus for your next attack.",
				"The effect lasts until your next attack or the end of your turn."
			]
		}]
 	}),
	RF_VengefulSpite = ::UPD.getDescription({
 		Fluff = "They shall pay for this!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Whenever an ally dies next to you, gain a stacking " + ::MSU.Text.colorGreen("5%") + " increased damage for the remainder of the combat."
			]
		}]
 	}),
	RF_Vigilant = ::UPD.getDescription({
 		Fluff = "\'On the battlefield, you must always be ready to defend at a moment\'s notice, or strike at a narrow opportunity!\'",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"At the end of your turn, gain " + ::MSU.Text.colorGreen("half") + " of your remaining Action Points, rounded down, as additional Action Points during your next turn."
			]
		}]
 	}),
	RF_VigorousAssault = ::UPD.getDescription({
 		Fluff = "You\'ve learned to use the very momentum of your movement as a weapon unto itself!",
 		Requirement = "Melee or Throwing Attack",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"For every 2 tiles moved, the Action Point cost of your next attack is reduced by " + ::MSU.Text.colorGreen(1) + " to a minimum of " + ::MSU.Text.colorGreen(1) + ", and the Fatigue Cost is reduced by " + ::MSU.Text.colorGreen("10%") + ".",
				"The bonus is lost upon waiting or ending your turn, using any skill, or swapping your weapon except to or from a throwing weapon."
			]
		}]
 	}),
	RF_WeaponMaster = ::UPD.getDescription({
 		Fluff = "You\'ve learned well that weapons are like tools, tailor-made to accomplish specific tasks. Therefore, you carry a small arsenal, ready to handle any situation!",
 		Requirement = "One-Handed Melee or Throwing Weapon",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Grants the bonuses of the weapon mastery perks for all One-Handed Melee and Throwing weapons whose perk groups this character has access to.",
				"Once per turn, switching from a One-Handed Melee or Throwing weapon to another costs no Action Points. Does not stack with other free item swap skills."
			]
		}]
 	}),
	RF_WearThemDown = ::UPD.getDescription({
 		Fluff = "\'It ain\'t hard to dodge \'em when they\'re flailing around like fools...!\'"
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Successful attacks apply the \'Worn Down\' effect on the target which reduces Initiative by " + ::MSU.Text.colorRed("10%") + " and increase Fatigue build-up by " + ::MSU.Text.colorRed("10%") + ".",
				"Gain a stacking " + ::MSU.Text.colorGreen("20%") + " chance that an enemy requires two successful rolls to hit you per negative status effect affecting the enemy. Valid status effects include: Worn Down, Stunned, Dazed, Rattled, Netted, Sleeping, Staggered, Rooted, Webbed.",
			]
		}]
 	}),
	RF_WearsItWell = ::UPD.getDescription({
 		Fluff = "Years of carrying heavy loads has given you the capability to carry the burden of your mercenary gear with ease!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The penalty to Maximum Fatigue and Initiative from equipped items in your head, body, mainhand and offhand slots is reduced by " + ::MSU.Text.colorRed("20%") + ". Stacks with Brawny."
			]
		}]
 	}),
	RF_WhirlingDeath = ::UPD.getDescription({
 		Fluff = "Use the arc of your flailhead to target weak spots in your opponents' armor!",
 		Requirement = "Flail",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"An additional random " + ::MSU.Text.colorGreen("0-25%") + " of damage ignores armor."
			]
		}]
 	}),
});
