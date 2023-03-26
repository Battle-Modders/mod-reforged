::MSU.Table.merge(::Const.Strings.PerkName, {
	RF_Alert = "Alert",
	RF_Angler = "Angler",
	RF_BattleFervor = "Battle Fervor",
	RF_BackToBasics = "Back to Basics",
	RF_Skirmisher = "Skirmisher",
	RF_Ballistics = "Ballistics",
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
	RF_NailedIt = "Nailed It",
	RF_OffhandTraining = "Offhand Training",
	RF_Opportunist = "Opportunist",
	RF_PatternRecognition = "Pattern Recognition",
	RF_PersonalArmor = "Personal Armor",
	RF_Phalanx = "Phalanx",
	RF_PowerShot = "Power Shot",
	RF_Professional = "Professional",
	RF_PromisedPotential = "Promised Potential",
 	RF_ProximityThrowingSpecialist = "Proximity Specialist",
	RF_Onslaught = "Onslaught",
	RF_Rattle = "Rattle",
	RF_RealizedPotential = "Realized Potential",
	RF_Rebuke = "Rebuke",
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
		ID = "perk.backstabber",
		Key = "Backstabber",
		Description = ::UPD.getDescription({
			Fluff = "Honor doesn\'t win you fights, stabbing the enemy where it hurts does.",
	 		Effects = [{
 				Type = ::UPD.EffectType.Passive,
 				Description = [
					"The bonus to hitchance in melee is doubled to [color=" + ::Const.UI.Color.PositiveValue + "]+10%[/color] for each ally surrounding and distracting your target.",
					"Daggers do " + ::MSU.Text.colorGreen("5%") + " increased damage per character [surrounding|Concept.Surrounding] the target."
				]
 			}]
	 	}),
	},
	{
		ID = "perk.rotation",
		Key = "Rotation",
		Description = ::UPD.getDescription({
	 		Effects = [{
 				Type = ::UPD.EffectType.Active,
 				Description = [
					"Unlocks the [Rotation|Skill+rotation] skill which allows you to switch places with an adjacent allied character while ignoring [Zone of Control|Concept.ZoneOfControl].",
					"Does not work if either character is [stunned|Skill+stunned_effect], [rooted|Skill+rooted_effect] or otherwise disabled."
				]
 			}]
	 	}),
	},
	{
		ID = "perk.footwork",
		Key = "Footwork",
		Description = ::UPD.getDescription({
	 		Effects = [{
 				Type = ::UPD.EffectType.Active,
 				Description = [
					"Unlocks the [Footwork|Skill+footwork] skill which allows you to leave a [Zone of Control|Concept.ZoneOfControl] without triggering free attacks."
				]
 			}]
	 	}),
	},
	{
		ID = "perk.rally_the_troops",
		Key = "RallyTheTroops",
		Description = ::UPD.getDescription({
	 		Effects = [{
 				Type = ::UPD.EffectType.Active,
 				Description = [
					"Unlocks the [Rally|Skill+rally_the_troops] skill which can raise [morale|Concept.Morale] of all nearby allies to a steady level.",
					"The higher the [Resolve|Concept.Resolve] of the character using this skill, the higher the chance to succeed."
				]
 			}]
	 	}),
	},
	{
		ID = "perk.adrenaline",
		Key = "Adrenaline",
		Description = ::UPD.getDescription({
			Fluff = "Feel the adrenaline rushing through your veins!",
	 		Effects = [{
 				Type = ::UPD.EffectType.Active,
 				Description = [
					"Unlocks the [Adrenaline|Skill+adrenaline_skill] skill which puts you first in the [turn|Concept.Turn] order for the next [round|Concept.Round], to have another [turn|Concept.Turn] before your enemies do."
				]
 			}]
	 	}),
	},
	{
		ID = "perk.taunt",
		Key = "Taunt",
		Description = ::UPD.getDescription({
	 		Effects = [{
 				Type = ::UPD.EffectType.Active,
 				Description = [
					"Unlocks the [Taunt|Skill+taunt] skill which makes the targeted opponent take offensive actions instead of defensive ones, and attack the taunting character over another, potentially more vulnerable one."
				]
 			}]
	 	}),
	},
	{
		ID = "perk.recover",
		Key = "Recover",
		Description = ::UPD.getDescription({
	 		Effects = [{
 				Type = ::UPD.EffectType.Active,
 				Description = [
					"Unlocks the [Recover|Skill+recover_skill] skill which allows for resting a [turn|Concept.Turn] in order to reduce accumulated [Fatigue|Concept.Fatigue]."
				]
 			}]
	 	}),
	},
	{
		ID = "perk.underdog",
		Key = "Underdog",
		Description = ::UPD.getDescription({
			Fluff = "I\'m used to it.",
	 		Effects = [{
 				Type = ::UPD.EffectType.Passive,
 				Description = [
					"The defense malus due to being [surrounded|Concept.Surrounding] by opponents no longer applies to this character.",
					"If an attacker has the [Backstabber|Perk+perk_backstabber] perk, the effect of that perk is negated, and the normal defense malus due to being [surrounded|Concept.Surrounding] is applied instead."
				]
 			}]
	 	}),
	},
	{
		ID = "perk.coup_de_grace",
		Key = "CoupDeGrace",
		Description = ::UPD.getDescription({
	 		Fluff = "\'Off with their heads!\'",
	 		Effects = [{
 				Type = ::UPD.EffectType.Passive,
 				Description = [
 					"Damage is increased by " + ::MSU.Text.colorGreen("20%") + " against enemies who have sustained an [injury|Concept.Injury] or are [sleeping|Skill+sleeping_effect], [stunned|Skill+stunned_effect], [netted|Skill+net_effect], [webbed|Skill+web_effect], or [rooted|Skill+rooted_effect]."
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
 					"Lowers the threshold to inflict [injuries|Concept.Injury] by " + ::MSU.Text.colorRed("33%") + " for both melee and ranged attacks.",
 					"Allows attacks to inflict [injuries|Concept.Injury] on the Undead."
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
 					"Gain " + ::MSU.Text.colorGreen("+2") + " [Reach|Concept.Reach] when engaged with a single enemy, and " + ::MSU.Text.colorGreen("+1") + " when engaged with a maximum of 2 enemies."
 				]
 			}],
 			Footer = ::MSU.Text.colorRed("This perk ONLY works with melee attacks with a [Base|Concept.BaseAttribute] [Action Point|Concept.ActionPoints] cost of 4 or less that are either [Lunge|Skill+lunge_skill] or have a Base Maximum Range of 1 tile.")
	 	})
	},
	{
		ID = "perk.indomitable",
		Key = "Indomitable",
		Description = ::UPD.getDescription({
	 		Fluff = "\'Mountains cannot be moved, nor taken down!\'",
	 		Effects = [
		 		{
	 				Type = ::UPD.EffectType.Active,
	 				Description = [
	 					"Unlocks the [Indomitable|Skill+indomitable] skill that reduces incoming damage and grants immunity to being [culled|Perk+perk_rf_cull], [stunned|Skill+stunned_effect], knocked back or grabbed."
	 				]
	 			},
	 			{
	 				Type = ::UPD.EffectType.Passive,
	 				Description = [
	 					"During combat, gain the [Retribution|NullEntitySkill+rf_retribution_effect] effect."
	 				]
	 			}
 			]
	 	}),
	},
	{
		ID = "perk.lone_wolf",
		Key = "LoneWolf",
		Description = ::UPD.getDescription({
	 		Fluff = "I work best alone.",
	 		Effects = [{
 				Type = ::UPD.EffectType.Passive,
 				Description = [
 					"With no ally within 2 tiles of distance, gain a " + ::MSU.Text.colorGreen("+15%") + " bonus to [Melee Skill|Concept.MeleeSkill], [Ranged Skill|Concept.RangeSkill], [Melee Defense|Concept.MeleeDefense], [Ranged Defense|Concept.RangeDefense], and [Resolve|Concept.Bravery]."
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
	 					"Skills build up " + ::MSU.Text.colorRed("25%") + " less [Fatigue|Concept.Fatigue].",
	 					"[Split Shield|Skill+split_shield] damage to shields is increased by " + ::MSU.Text.colorGreen("50%") + " when used with axes."
	 					"[Round Swing|Skill+round_swing] gains " + ::MSU.Text.colorGreen("+5%") + " chance to hit."
	 					"The [Longaxe|Item+longaxe] no longer has a penalty for attacking targets directly adjacent.",
	 				]
	 			},
	 			{
	 				Type = ::UPD.EffectType.Active,
	 				Description = [
	 					"Unlocks the [Bearded Blade|Skill+rf_bearded_blade_skill] skill which allows you to disarm your opponents during an attack or when they miss attacks against you."
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
	 					"Skills build up " + ::MSU.Text.colorRed("25%") + " less [Fatigue|Concept.Fatigue].",
	 					"View range and maximum shooting range with bows is increased by " + ::MSU.Text.colorGreen("+1") + "."
	 				]
	 			},
	 			{
	 				Type = ::UPD.EffectType.Active,
	 				Description = [
	 					"Unlocks the [Arrow to the Knee|Skill+rf_arrow_to_the_knee_skill] skill to debilitate your opponents\' capability to move around the battlefield."
	 				]
	 			}
 			]
	 	})
	},
	{
		ID = "perk.mastery.crossbow",
		Key = "SpecCrossbow",
		Description = ::UPD.getDescription({
	 		Fluff = "Master crossbows and firearms, and learn where to aim best.",
	 		Requirement = "Crossbow",
	 		Effects = [
		 		{
	 				Type = ::UPD.EffectType.Passive,
	 				Description = [
	 					"Skills build up " + ::MSU.Text.colorRed("25%") + " less [Fatigue|Concept.Fatigue].",
	 					"An additional " + ::MSU.Text.colorGreen("20%") + " of damage inflicted with crossbows ignores armor.",
	 					"[Heavy crossbows|Item+heavy_crossbow] now require " + ::MSU.Text.colorRed("4") + ", [Action Points|Concept.ActionPoints] to [reload|Skill+reload_bolt], just like regular crossbows, allowing you to shoot, reload and move.",
						"[Handgonnes|Item+handgonne] now require " + ::MSU.Text.colorRed("6") + " [Action Points|Concept.ActionPoints] to [reload|Skill+reload_handgonne_skill] and can be fired every turn instead of every other turn."
	 				]
	 			}
 			]
	 	})
	},
	{
		ID = "perk.mastery.flail",
		Key = "SpecFlail",
		Description = ::UPD.getDescription({
			Fluff = "Master flails and circumvent your opponent\'s shield.",
			Requirement = "Flail",
	 		Effects = [{
 				Type = ::UPD.EffectType.Passive,
 				Description = [
					"Skills build up [color=" + ::Const.UI.Color.NegativeValue + "]25%[/color] less Fatigue.",
					"Pound ignores an additional [color=" + ::Const.UI.Color.PositiveValue + "]+10%[/color] of armor on head hits.",
					"Thresh gains [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] chance to hit.",
					"Poleflails no longer have a penalty for attacking targets directly adjacent."
				]
 			}]
	 	}),
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
 					"Skills build up " + ::MSU.Text.colorRed("25%") + " less [Fatigue|Concept.Fatigue].",
 					"All skills with two-handed weapons, with a range of 2 tiles, having an [Action Point|Concept.ActionPoints] cost of " + ::MSU.Text.colorRed("6") + " have their [Action Point|Concept.ActionPoints] cost reduced to " + ::MSU.Text.colorRed("5") + ".",
 					"Polearms no longer have a penalty for attacking targets directly adjacent."
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
 					"Skills build up " + ::MSU.Text.colorRed("25%") + " less [Fatigue|Concept.Fatigue].",
 					"The [Action Point|Concept.ActionPoints] cost of [Spearwall|Skill+spearwall] is reduced by " + ::MSU.Text.colorGreen("1") + ".",
 					"[Spearwall|Skill+spearwall] is no longer disabled once an opponent manages to overcome it. Instead, [Spearwall|Skill+spearwall] can still be used and continues to give free attacks on any further opponent attempting to enter the [Zone of Control|Concept.ZoneOfControl]",
 					"The [Spetum|Item+spetum] and [Warfork|Item+warfork] no longer have a penalty for attacking targets directly adjacent."
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
 					"Skills build up " + ::MSU.Text.colorRed("25%") + " less [Fatigue|Concept.Fatigue].",
 					"Gain " + ::MSU.Text.colorGreen("20%") + " of your current [Melee Skill|Concept.MeleeSkill] as additional chance to hit.",
 					"Damage is increased by " + ::MSU.Text.colorGreen("30%") + " when attacking at a distance of 2 tiles and by " + ::MSU.Text.colorGreen("20%") + " when attacking at a distance of 3 tiles."
 				]
 			}]
	 	}),
	},
	{
		ID = "perk.student",
		Key = "Student",
		Description = ::UPD.getDescription({
			Fluff = "Everything can be learned if you put your mind to it.",
	 		Effects = [{
 				Type = ::UPD.EffectType.OneTimeEffect,
 				Description = [
					"At the eleventh character level, you gain an additional perk point and this perk becomes inert.",
					"Playing the \'Manhunters\' origin, your indebted get the perk point refunded at the seventh character level."
				]
 			},
			{
				Type = ::UPD.EffectType.Passive,
				Description = [
					"Gain additional [color=" + ::Const.UI.Color.PositiveValue + "]20%[/color] experience from battle."
				]
			}],
			Footer = ::MSU.Text.colorRed("This perk cannot be refunded.")	// This line is new, rest is the same
	 	})
	},
	{
		ID = "perk.gifted",
		Key = "Gifted",
		Description = ::UPD.getDescription({
			Fluff = "Mercenary life comes easy when you\'re naturally gifted.",
	 		Effects = [{
 				Type = ::UPD.EffectType.OneTimeEffect,
 				Description = [
					"Instantly gain a levelup to increase this character\'s attributes with maximum rolls, but without talents."
				]
 			}],
			Footer = ::MSU.Text.colorRed("This perk cannot be refunded.")	// This line is new, rest is the same
	 	})
	},
	{
		ID = "perk.nimble",
		Key = "Nimble",
		Description = ::UPD.getDescription({
	 		Fluff = "Specialize in light armor! By nimbly dodging or deflecting blows, convert any hits to glancing hits.",
	 		Effects = [{
 				Type = ::UPD.EffectType.Passive,
 				Description = [
 					"Damage to [Hitpoints|Concept.Hitpoints] is reduced by " + ::MSU.Text.colorGreen("50%") + " and that to armor by " + ::MSU.Text.colorGreen("25%") + ".",
 					"The bonus drops exponentially when wearing head and body armor with a total penalty to [Maximum Fatigue|Concept.MaximumFatigue] above 15. The lighter your armor and helmet, the more you benefit.",
 					"Does not affect damage from mental attacks or status effects, but can help to avoid receiving them.",
 					"[Brawny|Perk+perk_brawny] does not affect this perk.",
 					"Cannot be picked if you have [Poise|Perk+perk_rf_poise]."

 				]
 			}]
	 	}),
	},
	{
		ID = "perk.overwhelm",
		Key = "Overwhelm",
		Description = ::UPD.getDescription({
	 		Fluff = "Learn to take advantage of your high [Initiative|Concept.Initiative] and prevent the enemy from attacking effectively by overwhelming them with your attacks!",
	 		Requirement = "Melee Attack",
	 		Effects = [{
 				Type = ::UPD.EffectType.Passive,
 				Description = [
 					"With every attack, hit or miss, against an opponent that acts after you in the current round, inflict the [Overwhelmed|Skill+overwhelmed_effect] status effect which lowers both [Melee Skill|Concept.MeleeSkill] and [Ranged Skill|Concept.RangeSkill] by " + ::MSU.Text.colorRed("-10%") + " for one [turn|Concept.Turn].",
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
	 					"[Action Point|Concept.ActionPoints] costs for movement on all terrain is reduced by " + ::MSU.Text.colorRed("-1") + " to a minimum of 2 [Action Points|Concept.ActionPoints] per tile, and [Fatigue|Concept.Fatigue] cost is reduced to half.",
	 					"Changing height levels also has no additional [Action Point|Concept.ActionPoints] cost anymore."
	 				]
	 			},
	 			{
	 				Type = ::UPD.EffectType.Active,
	 				Description = [
	 					"Unlocks the [Sprint|Skill+rf_sprint_skill] skill that allows you to travel longer distances during your [turn|Concept.Turn]."
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
 					"Swapping any item in battle a free action with no [Action Point|Concept.ActionPoints] cost once every [turn|Concept.Turn].",
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
	 					"The shield defense bonus is increased by " + ::MSU.Text.colorGreen("25%") + ". This also applies to the additional defense bonus of the [Shieldwall|Skill+shieldwall] skill.",
	 					"Shield damage received is reduced by " + ::MSU.Text.colorRed("50%") + " to a minimum of 1.",
	 					"The [Knock Back|Skill+knock_back] skill gains " + ::MSU.Text.colorGreen("+15%") + " chance to hit and now applies the [Staggered|Skill+staggered_effect] effect.",
	 					"Shields now also negate the [Reach Advantage|Concept.ReachAdvantage] of the target when attacking.",
	 					"Missed attacks against you no longer increase your [Fatigue|Concept.Fatigue]."
	 				]
	 			},
	 			{
	 				Type = ::UPD.EffectType.Active,
	 				Description = [
	 					"Unlocks the [Cover Ally|Skill+rf_cover_ally_skill] skill which allows you to target an ally to allow them to move 1 tile ignoring [Zone of Control|Concept.ZoneOfControl] on their [turn|Concept.Turn] while improving their position in the turn order in the next [round|Concept.Round]."
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
 					"Hits to the head no longer cause critical damage to this character, which also lowers the risk of sustaining debilitating head [injuries|Concept.Injury] significantly."
 					"Grants passive immunity against [Cull|Perk+perk_rf_cull]."
 				]
 			}]
	 	}),
	},
];

foreach (vanillaDesc in vanillaDescriptions)
{
	::UPD.setDescription(vanillaDesc.ID, vanillaDesc.Key, ::Reforged.Mod.Tooltips.parseString(vanillaDesc.Description));
}

::MSU.Table.merge(::Const.Strings.PerkDescription, {
	RF_Alert = ::UPD.getDescription({
 		Fluff = "What was that over there?",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"[Initiative|Concept.Initiative] is increased by " + ::MSU.Text.colorGreen("20%") + "."
			]
		}]
 	}),
 	RF_Angler = ::UPD.getDescription({
 		Fluff = "Throw nets in a way that perfectly billows around your targets.",
 		Requirement = "Net",
 		Effects = [
 			{
 				Type = ::UPD.EffectType.Passive,
 				Description = [
 					"Enemies have a " + ::MSU.Text.colorRed("-20%") + " chance to break from from nets you throw."
 				]
 			},
 			{
 				Type = ::UPD.EffectType.Active,
 				Description = [
 					"Unlocks the [Net Pull|Skill+rf_net_pull_skill] skill that allows you to pull a target and net it, but does not gain the passive " + ::MSU.Text.colorRed("-20%") + " chance to break free."
 				]
 			}
 		]
 	}),
	RF_BattleFervor = ::UPD.getDescription({
 		Fluff = "It is our destiny!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"[Resolve|Concept.Bravery] is increased by " + ::MSU.Text.colorGreen("10%") + " at all times.",
				"Additionally, at positive morale checks, [Resolve|Concept.Bravery] is increased by a further " + ::MSU.Text.colorGreen(10) + ".",
				"When at Confident Morale, all the bonuses of this perk are doubled, and [Melee Skill|Concept.MeleeSkill], [Ranged Skill|Concept.RangeSkill], [Melee Defense|Concept.MeleeDefense], and [Ranged Defense|Concept.RangeDefense] are increased by " + ::MSU.Text.colorGreen("5%") + "."
			]
		}]
 	}),
	RF_BackToBasics = ::UPD.getDescription({
 		Fluff = "Captain told you to focus on the basics, trying fancy stuff is only going to get you killed!",
 		Effects = [{
			Type = ::UPD.EffectType.OneTimeEffect,
			Description = [
				"Gain 2 perk points.",
				"Drop your [perk tier|Concept.PerkTier] down to " + ::MSU.Text.colorRed(2) + ".",
			]
		}],
		Footer = ::MSU.Text.colorRed("This perk cannot be refunded.")
 	}),
	RF_Skirmisher = ::UPD.getDescription({
 		Fluff = "Gain increased speed and endurance by balancing your armor and mobility.",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The penalty to [Initiative|Concept.Initiative] from head and body armor is reduced by " + ::MSU.Text.colorRed("30%") + ".",
				"At all times your [Initiative|Concept.Initiative] is reduced only by " + ::MSU.Text.colorGreen("50%") + " of accumulated [Fatigue|Concept.Fatigue], instead of all of it.",
				"Stacks [multiplicatively|Concept.StackMultiplicatively] with the [Relentless|Perk+perk_relentless] perk."
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
				"Once per [turn|Concept.Turn], making a kill reduces current [Fatigue|Concept.Fatigue] by " + ::MSU.Text.colorGreen("15%") + " of [Base|Concept.BaseAttribute] [Maximum Fatigue|Concept.MaximumFatigue]."
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
				"Gain " + ::MSU.Text.colorGreen("+10") + " [Melee Skill|Concept.MeleeSkill] and [Ranged Skill|Concept.RangeSkill], and " + ::MSU.Text.colorGreen("+20%") + " chance to hit the head when attacking a [rattled|Skill+rf_rattled_effect], [stunned|Skill+stunned_effect], [dazed|Skill+dazed_effect], [netted|Skill+net_effect], [sleeping|Skill+sleeping_effect], [staggered|Skill+staggered_effect], [webbed|Skill+web_effect], or [rooted|Skill+rooted_effect] target."
			]
		}]
 	}),
	RF_BestialVigor = ::UPD.getDescription({
 		Fluff = "Unleash the beast within!",
 		Effects = [{
			Type = ::UPD.EffectType.Active,
			Description = [
				"Unlocks the [Bestial Vigor|Skill+rf_bestial_vigor_skill] skill which can be used to reduce [Fatigue|Concept.Fatigue] and gain [Action Points|Concept.ActionPoints] during combat."
			]
		}]
 	}),
	RF_BetweenTheEyes = ::UPD.getDescription({
 		Fluff = "Like splitting butter!",
 		Requirement = "Melee Attack",
 		Effects = [{
			Type = ::UPD.EffectType.Active,
			Description = [
				"Unlocks the [Between the Eyes|NullEntitySkill+rf_between_the_eyes_skill] skill which can be used to perform your primary attack with an additional chance to hit the head equal to " + ::MSU.Text.colorGreen("50%") + " of your [Melee Skill|Concept.MeleeSkill]."
				"The [Action Point|Concept.ActionPoints] cost and [Fatigue|Concept.Fatigue] Cost of your primary melee attack is added to the costs of this skill.",
			]
		}]
 	}),
	RF_BetweenTheRibs = ::UPD.getDescription({
 		Fluff = "Striking when an enemy is distracted allows this character to aim for the vulnerable bits!",
 		Requirement = "Dagger",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Damage against [surrounded|Concept.Surrounding] targets is increased by " + ::MSU.Text.colorGreen("5%") + " per character surrounding the target."
			]
		}]
 	}),
	RF_Blitzkrieg = ::UPD.getDescription({
 		Fluff = "It will be over in a flash!",
 		Effects = [{
			Type = ::UPD.EffectType.Active,
			Description = [
				"Unlocks the [Blitzkrieg|Skill+rf_blitzkrieg_skill] skill which allows you and the rest of your company to go first in the next round of combat."
			]
		}]
 	}),
	RF_Bloodbath = ::UPD.getDescription({
 		Fluff = "There\'s something about removing someone\'s head that just makes you want to do it again!",
 		Requirement = "Melee Attack",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"[Fatalities|Concept.Fatality] instantly restore " + ::MSU.Text.colorGreen(3) + " [Action Points|Concept.ActionPoints].",
				"Can trigger multiple times per [turn|Concept.Turn], but only once per attack."
			]
		}]
 	}),
 	RF_Bloodlust = ::UPD.getDescription({
 		Fluff = "When surrounded by carnage, you feel revitalized and right at home!",
 		Requirement = "Melee Attack",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"During your [turn|Concept.Turn], every successful attack reduces current [Fatigue|Concept.Fatigue] by " + ::MSU.Text.colorGreen("5%") + " per stack of [Bleeding|Skill+bleeding_effect] on the target and increases [Fatigue Recovery|Concept.FatigueRecovery] by " + ::MSU.Text.colorGreen("+1") + " for one [turn|Concept.Turn] per stack of [Bleeding|Skill+bleeding_effect] on the target.",
				"[Bleeding|Skill+bleeding_effect] inflicted by the attack, or killing a target, also counts towards the bonus."
			]
		}]
 	}),
	RF_DeathDealer = ::UPD.getDescription({
 		Fluff = "Like wheat before a scythe!",
 		Requirement = "Melee AOE Attack",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Melee [AOE|Concept.AOE] attacks gain " + ::MSU.Text.colorGreen("+10%") + " chance to hit and deal " + ::MSU.Text.colorGreen("10%") + " increased damage."
			]
		}]
 	}),
	RF_Bolster = ::UPD.getDescription({
 		Fluff = "Your battle brothers feel confident when you\'re there backing them up!",
 		Requirement = "Weapon with 6 or more [Reach|Concept.Reach]",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Increase the [Resolve|Concept.Bravery] of adjacent allies by " + ::MSU.Text.colorGreen("5%") + " of your [Melee Skill|Concept.MeleeSkill]. If multiple characters with this perk are present, only the highest bonus applies.",
				"When not engaged in melee, whenever you attack, hit or miss, trigger a Positive Morale Check for adjacent members of your company with a penalty to [Resolve|Concept.Bravery] of " + ::MSU.Text.colorRed("50%") + "."
			]
		}]
 	}),
	RF_BoneBreaker = ::UPD.getDescription({
 		Fluff = "Snap, crunch, crumble. Music to your ears!",
 		Requirement = "Mace",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Attacks that do at least " + ::MSU.Text.colorRed(5) + " damage to [Hitpoints|Concept.Hitpoints] and apply a valid [status effect|Concept.StatusEffect] or are against characters with a valid [status effect|Concept.StatusEffect] have a chance to inflict an [injury|Concept.Injury]. This chance is " + ::MSU.Text.colorGreen("100%") + " for two-handed maces and " + ::MSU.Text.colorGreen("50%") + " for one-handed maces.",
				"If the damage was sufficient to inflict an [injury|Concept.Injury], it inflicts an additional [injury|Concept.Injury].",
				"In a single turn, cannot trigger more than once on the same target.",
				"Valid status effects include: [stunned|Skill+stunned_effect], [netted|Skill+net_effect], [webbed|Skill+web_effect], [rooted|Skill+rooted_effect], [sleeping|Skill+sleeping_effect]."
			]
		}]
 	}),
	RF_Bully = ::UPD.getDescription({
 		Fluff = "Did you say stop?",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Attacks against characters with a lower [Morale|Concept.Morale] than you deal " + ::MSU.Text.colorGreen("10%") + " increased damage per level of [Morale|Concept.Morale] difference."
			]
		}]
 	}),
	RF_Bulwark = ::UPD.getDescription({
 		Fluff = "\'Not much to be afraid of behind a suit of plate!\'",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Gain " + ::MSU.Text.colorGreen("2%") + " of your combined head and body armor durability as [Resolve|Concept.Bravery].",
				"This bonus is doubled against negative morale checks except mental attacks."
			]
		}]
 	}),
	RF_Finesse = ::UPD.getDescription({
 		Fluff = "Years of combat training have given you insight into the most efficient way of carrying yourself on the battlefield.",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"[Fatigue|Concept.Fatigue] cost of skills is reduced by " + ::MSU.Text.colorRed("20%") + "."
			]
		}]
 	}),
	RF_ConcussiveStrikes = ::UPD.getDescription({
 		Fluff = "A strike to the head from this character means goodnight!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Hits to the head with any weapon apply the [Dazed|Skill+dazed_effect] effect for 1 [turn|Concept.Turn]. This duration is increased to 2 [turns|Concept.Turn] for one-handed maces.",
				"Hits to the head with two-handed maces apply the [Stunned|Skill+stunned_effect] for 1 [turn|Concept.Turn], and if the target is immune to being [stunned|Skill+stunned_effect], apply [Dazed|Skill+dazed_effect] for 1 [turn|Concept.Turn]."
			]
		}]
 	}),
	RF_Cull = ::UPD.getDescription({
 		Fluff = "A strike to the head from this character means goodnight!",
 		Requirement = "Axe",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Maximum Damage is increased by " + ::MSU.Text.colorGreen("10%") + " of the Maximum Damage of the currently equipped axe.",
				"Hits to the head will instantly kill a target that has less than " + ::MSU.Text.colorRed("33%") + " [Hitpoints|Concept.Hitpoints] remaining after the hit.",
				"Ignores [Nine Lives|Perk+perk_nine_lives] on the target.",
				"If killed via culling, [decapitates|Concept.Fatality] the target.",
				"Targets who have [Steel Brow|Perk+perk_steel_brow] or are under the effects of [Indomitable|NullEntitySkill+indomitable_effect] are immune to being culled."
			]
		}]
 	}),
	RF_DeepCuts = ::UPD.getDescription({
 		Fluff = "You know the best whetstone techniques to get your cutting edge wickedly sharp!",
 		Requirement = "Cutting Damage",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"During your [turn|Concept.Turn], after a successful attack against a target, all subsequent attacks have a " + ::MSU.Text.colorRed("33%") + " reduced threshold to inflict [injury|Concept.Injury] and will inflict an additional stack of [Bleeding|Skill+bleeding_effect] for " + ::MSU.Text.colorRed(5) + " damage. This damage is increased to " + ::MSU.Text.colorRed(10) + " if any of the attacks inflicted an [injury|Concept.Injury].",
				"The effect expires upon switching your target, moving, swapping an item, waiting or ending a [turn|Concept.Turn], or using any skill except a cutting attack."
			]
		}]
 	}),
 	RF_DeepImpact = ::UPD.getDescription({
 		Fluff = "\'Roll out the barrel, feel it in your bones!\'",
 		Requirement = "Blunt Damage",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"An additional " + ::MSU.Text.colorRed("10%") + " of damage ignores armor.",
				"Attacks now apply the [Hemorrhaging Internally|Skill+rf_internal_hemorrhage_effect] effect that deals " + ::MSU.Text.colorGreen("20%") + " of the damage dealt to [Hitpoints|Concept.Hitpoints] in that attack as damage to the target at the end of their [turn|Concept.Turn]."
			]
		}]
 	}),
	RF_DentArmor = ::UPD.getDescription({
 		Fluff = "\'Can\'t fight if they can\'t walk.\'",
 		Requirement = "Hammer and Blunt Damage",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Successful attacks have a chance to apply the [Dented Armor|Skill+rf_dented_armor_effect] effect for the remainder of the combat.",
				"The chance is " + ::MSU.Text.colorRed("66%") + " for two-handed hammers and " + ::MSU.Text.colorGreen("33%") + " for one-handed hammers.",
				"Only works when attacks hit an armor item with a maximum durability of at least 200.",
				"The affected target, or their allies, can use the [Adjust Armor|Skill+rf_adjust_dented_armor_skill] skill, when not engaged in melee, to remove the effect."
			]
		}]
 	}),
	RF_DiscoveredTalent = ::UPD.getDescription({
 		Fluff = "You don\'t know where it came from, but you\'ve suddenly started excelling at everything you do!",
 		Effects = [{
			Type = ::UPD.EffectType.OneTimeEffect,
			Description = [
				"Gain " + ::MSU.Text.colorGreen(1) + " star in the [talents|Concept.Talent] of all [attributes|Concept.CharacterAttribute].",
				"Then instantly gain a levelup to increase this character\'s [attributes|Concept.CharacterAttribute] with normal rolls with [talents|Concept.Talent].",
			]
		}],
		Footer = ::MSU.Text.colorRed("This perk cannot be refunded.")
 	}),
	RF_Dismantle = ::UPD.getDescription({
 		Fluff = "Strip them of their protection while they still wear it!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Every successful hit applies the [Dismantled Armor|Skill+rf_dismantled_effect] effect which causes the target to receive a stacking " + ::MSU.Text.colorRed("+15%") + " additional damage ignoring armor from all sources for the remainder of the combat."
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
				"The effect is lost upon moving, swapping an item, using any skill except a single-target attack, missing an attack, or waiting or ending your [turn|Concept.Turn]."
			]
		}]
 	}),
	RF_EnGarde = ::UPD.getDescription({
 		Fluff = "You\'ve become so well-practiced with a blade that attacking and defending are done congruously!",
 		Requirement = "Sword",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"When wielding a sword, if you have not moved from your position during your [turn|Concept.Turn], use [Riposte|Skill+riposte] freely at the end of your [turn|Concept.Turn] if your weapon has [Riposte|Skill+riposte].",
				"If your weapon does not have [Riposte|Skill+riposte] and is two-handed, gain the [Rebuke|Skill+rf_rebuke_effect] effect, with an additional chance of " + ::MSU.Text.colorGreen("+10%") + " for returning a missed attack, instead until the start of your next [turn|Concept.Turn].",
				"Does not build any [Fatigue|Concept.Fatigue] or cost any [Action Points|Concept.ActionPoints] but only triggers if you have at least " + ::MSU.Text.colorRed(15) + " [Fatigue|Concept.Fatigue] remaining."
			]
		}]
 	}),
	RF_Entrenched = ::UPD.getDescription({
 		Fluff = "You\'ve learned to fight in formation, trusting in the comrades to your front and sides to keep you safe while you go to work!",
 		Requirement = "Ranged Weapon",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"When standing adjacent to an ally wielding a melee weapon who is not engaged in melee, gain " + ::MSU.Text.colorGreen("+7") + " [Ranged Skill|Concept.RangeSkill], [Ranged Defense|Concept.RangeDefense], and [Resolve|Concept.Bravery]. The bonus increases by " + ::MSU.Text.colorGreen("+2") + " every [turn|Concept.Turn] up to a maximum of " + ::MSU.Text.colorGreen("+15") + " as long as you continue to start your [turn|Concept.Turn] adjacent to any ally wielding a melee weapon who is not engaged in melee.",
				"While entrenched, swapping between two ranged weapons becomes a free action once per [turn|Concept.Turn]."
			]
		}]
 	}),
	RF_ExploitOpening = ::UPD.getDescription({
 		Fluff = "A low shield. A slobby stab. A fake stumble. All are ways that you\'ve learned to tempt your opponent into a fatal false move!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Whenever an opponent misses a Melee attack against you, gain " + ::MSU.Text.colorGreen("+10%") + " chance to hit against them for your next attack.",
				"Unlocks the [Riposte|Skill+riposte] skill on southern curved swords such as the [Shamshir|Item+shamshir], [Saif|Item+saif], and [Scimitar|Item+scimitar]."
			]
		}]
 	}),
	RF_ExudeConfidence = ::UPD.getDescription({
 		Fluff = "With you by their side, your comrades feel they can conquer mountains!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"At the start of your [turn|Concept.Turn], improve the Morale state of adjacent allies by " + ::MSU.Text.colorGreen(1) + " as long as their Morale state is lower than yours."
			]
		}]
 	}),
	RF_EyesUp = ::UPD.getDescription({
 		Fluff = "Rain down arrows upon your enemies from a higher angle, forcing them to divert their attention!",
 		Requirement = "Bow",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Every attack, hit or miss, applies a stacking debuff on the target reducing their [Melee Skill|Concept.MeleeSkill] and [Ranged Skill|Concept.RangeSkill] by " + ::MSU.Text.colorRed("-5") + " and [Melee Defense|Concept.MeleeDefense] by " + ::MSU.Text.colorRed("-3") + " for one [turn|Concept.Turn].",
				"Only applies half a stack if the primary target is wielding a shield. Additionally, applies half a stack to enemies adjacent to the primary target who are not wielding shields. Bucklers do not count as shields for this perk.",
				"Can have a maximum of " + ::MSU.Text.colorGreen(10) + " stacks."
			]
		}]
 	}),
	RF_FailedPotential = ::UPD.getDescription({
 		Fluff = "This character looked promising, but either due to bad luck or simply lack of talent, they have not shown the potential you thought they had. " + ::MSU.Text.colorRed("This perk does nothing."),
		Footer = ::MSU.Text.colorRed("This perk cannot be refunded.")
 	}),
	RF_FamilyPride = ::UPD.getDescription({
 		Fluff = "Death before dishonor!",
 		Effects = [
 			{
				Type = ::UPD.EffectType.Passive,
				Description = [
					"Always start battles at Confident [morale|Concept.Morale].",
					"Morale checks can never drop your [morale|Concept.Morale] below Confident for the first " + ::MSU.Text.colorGreen(5) + " rounds of battle (the entire battle if you have the [Determined+Skill+determined_trait] trait) and below Steady after that."
				]
			},
			{
				Type = ::UPD.EffectType.OneTimeEffect,
				Description = [
					"Removes the [Insecure|Skill+insecure_trait] and [Dastard|Skill+dastard_trait] traits."
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
				"Gain " + ::MSU.Text.colorGreen("+1") + " [Action Point|Concept.ActionPoints]."
			]
		}]
 	}),
	RF_Fencer = ::UPD.getDescription({
 		Fluff = "Master the art of fighting with a nimble sword.",
 		Requirement = "Fencing Sword",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Skills build up " + ::MSU.Text.colorRed("20%") + " less [Fatigue|Concept.Fatigue] and gain " + ::MSU.Text.colorGreen("+10%") + " chance to hit.",
				"When using a one-handed fencing sword, the [Action Point|Concept.ActionPoints] costs of [Sword Thrust|Skill+rf_sword_thrust_skill], [Riposte|Skill+riposte] and [Lunge|Skill+lunge_skill] are reduced by " + ::MSU.Text.colorGreen(1) + ".",
				"When using a two-handed fencing sword, the range of [Lunge|Skill+lunge_skill] is increased by " + ::MSU.Text.colorGreen(1) + " tile."
			]
		}]
 	}),
	RF_FeralRage = ::UPD.getDescription({
 		Fluff = "Like sheep before a wolf!",
 		Requirement = "Melee Attack",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Gain stacking rage during combat. You gain 1 stack for getting hit, 3 for making a kill, 1 for every successful hit against an adjacent target with a skill with a base [Action Point|Concept.ActionPoints] cost of 4 or less and 2 for greater.",
				"You lose 2 rage at the start of every [turn|Concept.Turn].",
				"Each stack of rage increases [Resolve|Concept.Bravery], [Initiative|Concept.Initiative], and Damage by " + ::MSU.Text.colorGreen("+1") + ", lowers [Melee Defense|Concept.MeleeDefense] by " + ::MSU.Text.colorRed("-1") + ", and reduces incoming damage by " + ::MSU.Text.colorGreen("2%") + ".",
				"At 5 stacks, gain immunity to being [Dazed|Skill+dazed_effect] and a " + ::MSU.Text.colorGreen("33%") + " chance to resist physical [status effects|Concept.StatusEffect] such as [staggered|Skill+staggered_effect], [distracted|Skill+distracted_effect] and [withered|Skill+withered_effect].",
				"At 7 stacks, additionally gain immunity to being [Stunned|Skill+stunned_effect].",
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
				"A successful [Aimed Shot|Skill+aimed_shot] will now light the target tile on fire for 2 rounds and trigger an additional morale check for the target and adjacent enemies."
			]
		}]
 	}),
	RF_FluidWeapon = ::UPD.getDescription({
 		Fluff = "A well-balanced sword is like an extension of yourself!",
 		Requirement = "Sword",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"[Initiative|Concept.Initiative] is increased by " + ::MSU.Text.colorGreen("35%") + " of the equipped sword\'s armor ignore damage percentage.",
				"The [Fatigue|Concept.Fatigue] Cost of weapon skills is reduced by " + ::MSU.Text.colorGreen("20%") + " of the equipped sword\'s armor effectiveness."
			]
		}]
 	}),
	RF_FollowUp = ::UPD.getDescription({
 		Fluff = "\'When your buddy\'s hittin\' \'em, you hit \'em too!\'",
 		Requirement = "Melee Attack",
 		Effects = [{
			Type = ::UPD.EffectType.Active,
			Description = [
				"Unlocks the [Follow Up|Skill+rf_follow_up_skill] skill which allows you to attack enemies who are hit by your allies during your allies' [turn|Concept.Turn].",
				"Attacks from Follow Up are non-lethal i.e. they cannot kill the target."
			]
		}]
 	}),
	RF_FormidableApproach = ::UPD.getDescription({
 		Fluff = "Make them think twice about getting close!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Your [Reach|Concept.Reach] is increased by " + ::MSU.Text.colorGreen("+2") + " against enemies in your [Zone of Control|Concept.ZoneOfControl], until they hit you.",
				"After being hit the effect expires, but is reset if the [Zone of Control|Concept.ZoneOfControl] is broken."
			]
		}]
 	}),
	RF_FreshAndFurious = ::UPD.getDescription({
 		Fluff = "The period of vigor at the beginning of the fight is when you do the most damage!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"As long as your current [Fatigue|Concept.Fatigue] is below " + ::MSU.Text.colorRed("30%") + " of [Maximum Fatigue|Concept.MaximumFatigue] after gear, the [Action Point|Concept.ActionPoints] cost of the first skill used every [turn|Concept.Turn] is " + ::MSU.Text.colorGreen("halved") + ".",
				"Does not expire when using a skill with no [Action Point|Concept.ActionPoints] and [Fatigue|Concept.Fatigue] cost."
			]
		}]
 	}),
	RF_FromAllSides = ::UPD.getDescription({
 		Fluff = "You\'ve learned to use the unpredictable swings of your flail to keep your enemies guessing!",
 		Requirement = "Flail",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Successful hits from Flails progressively reduce the target's [Melee Defense|Concept.MeleeDefense] and [Ranged Defense|Concept.RangeDefense] by a stacking " + ::MSU.Text.colorRed(-3) + " for one [turn|Concept.Turn].",
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
				"[Hitpoints|Concept.Hitpoints], [Maximum Fatigue|Concept.MaximumFatigue], and [Initiative|Concept.Initiative] are increased by " + ::MSU.Text.colorGreen("10%") + " of their respective base values."
			]
		}]
 	}),
 	RF_Ghostlike = ::UPD.getDescription({
 		Fluff = "Blink and you\'ll miss me.",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"When the number of adjacent allies is greater than or equal to the number of adjacent enemies, you may ignore [Zone of Control|Concept.ZoneOfControl] for your next movement action."
			]
		}]
 	}),
	RF_HaleAndHearty = ::UPD.getDescription({
 		Fluff = "Years of hard labor have given you a stamina like none other!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Fatigue Recovery is increased by " + ::MSU.Text.colorGreen("5%") + " of your [Maximum Fatigue|Concept.MaximumFatigue] after gear."
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
				"The [Action Point|Concept.ActionPoints] cost of Quick Shot is reduced by " + ::MSU.Text.colorGreen(1) + ".",
				"Each subsequent Quick Shot in a [turn|Concept.Turn] builds " + ::MSU.Text.colorRed("10%") + " more [Fatigue|Concept.Fatigue]."
			]
		}]
 	}),
	RF_HoldSteady = ::UPD.getDescription({
 		Fluff = "Direct your troops to stand their ground!",
 		Effects = [{
			Type = ::UPD.EffectType.Active,
			Description = [
				"Unlocks the [Hold Steady|Skill+rf_hold_steady_skill] skill which allows you and nearby allies to gain increased defenses and resistance against certain [status effects|Concept.StatusEffect], such as [stunned|Skill+stunned_effect], and being knocked back or grabbed."
			]
		}]
 	}),
	RF_Hybridization = ::UPD.getDescription({
 		Fluff = "\'Hatchet, throwing axe, spear, javelin... they all kill just the same!\'",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Gain " + ::MSU.Text.colorGreen("10%") + " of your Base [Ranged Skill|Concept.RangeSkill] as additional [Melee Skill|Concept.MeleeSkill] and [Melee Defense|Concept.MeleeDefense]."
				"Piercing type throwing attacks have a " + ::MSU.Text.colorGreen("50%") + " chance to inflict the \'Arrow to the Knee\' effect.",
				"Cutting type throwing attacks always apply the [Overwhelmed|Skill+overwhelmed_effect] effect.",
				"Blunt type throwing attacks have a " + ::MSU.Text.colorGreen("50%") + " chance to inflict [staggered|Skill+staggered_effect] and if the target is already [staggered|Skill+staggered_effect], " + ::MSU.Text.colorGreen("100%") + " chance to inflict [stunned|Skill+stunned_effect].",
				"[Throwing Spear|Item+throwing_spear] does " + ::MSU.Text.colorGreen("50%") + " increased damage to shields."
			]
		}]
 	}),
	InspiringPresence = ::UPD.getDescription({
 		Fluff = "Standing next to the company\'s banner inspires your men to go beyond their limits!",
 		Requirement = "Banner",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Any member of your company who is adjacent to an enemy, or is adjacent to an ally who is adjacent to an enemy, gains " + ::MSU.Text.colorGreen("+3") + " [Action Points|Concept.ActionPoints] as long as they start their [turn|Concept.Turn] adjacent to you."
			]
		}]
 	}),
	RF_InternalHemorrhage = ::UPD.getDescription({
 		Fluff = "Learn to strike at your target\'s softest spots, causing intense internal bleeding.",
 		Requirement = "Blunt Damage",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Blunt Damage attacks now apply the [Hemorrhaging Internally|Skill+rf_internal_hemorrhage_effect] effect that deals " + ::MSU.Text.colorGreen("20%") + " of the damage dealt to [Hitpoints|Concept.Hitpoints] in that attack as damage to the target at the end of their [turn|Concept.Turn]."
			]
		}]
 	}),
	RF_Intimidate = ::UPD.getDescription({
 		Fluff = "\'Trust me, ye don\'t want to be on the other end of a spike on a pole!\'",
 		Requirement = "Weapon with 6 or more [Reach|Concept.Reach]",
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
			Description = [
				"Unlocks the [Kata Step|Skill+rf_kata_step_skill] skill which, immediately after a successful attack, allows you to move one tile ignoring [Zone of Control|Concept.ZoneOfControl] with reduced [Action Point|Concept.ActionPoints] cost and [Fatigue|Concept.Fatigue] cost of movement.",
				"The target tile for the movement must be adjacent to an enemy.",
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
				"While holding a [net|Item+throwing_net], every successful melee attack against an adjacent target has a chance to net the target without expending your currently held [net|Item+throwing_net]. The chance is equal to the hit chance of the attack.",
				"You cannot use or swap this [net|Item+throwing_net] until the enemy escapes or dies.",
				"The [net effect|Skill+net_effect] can be broken out of with 100% effectiveness",
				"Does not benefit from [Angler|Perk+perk_rf_angler]."
			]
		}]
 	}),
	RF_KingOfAllWeapons = ::UPD.getDescription({
 		Fluff = "One King to rule them all!",
 		Requirement = "Spear",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"When starting your [turn|Concept.Turn] with a Spear equipped, the first [Thrust|Skill+thrust] or [Prong|Skill+prong_skill] during your [turn|Concept.Turn] costs no [Action Points|Concept.ActionPoints] and builds no [Fatigue|Concept.Fatigue], but does " + ::MSU.Text.colorRed("25%") + " reduced Damage.",
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
				"When attacking a target at a range of 2 tiles, gain " + ::MSU.Text.colorRed("+20%") + " chance to hit the head."
			]
		}]
 	}),
	RF_LineBreaker = ::UPD.getDescription({
 		Fluff = "\'Make way for the bad guy!\'",
 		Requirement = "Shield",
 		Effects = [{
			Type = ::UPD.EffectType.Active,
			Description = [
				"Unlocks the [Line Breaker|Skill+rf_line_breaker_skill] skill which allows you to knock back an enemy and take their place, all in one action."
			]
		}]
 	}),
	RF_Poise = ::UPD.getDescription({
 		Fluff = "Specialize in Medium Armor! Not as nimble as some but more lithe than others!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Damage to [Hitpoints|Concept.Hitpoints] is reduced by " + ::MSU.Text.colorRed("30%") + " and to Armor by " + ::MSU.Text.colorRed("20%") + ".",
				"The bonus drops exponentially when wearing head and body armor with a total penalty to [Maximum Fatigue|Concept.MaximumFatigue] above 35.",
				"[Brawny|Perk+perk_brawny] does not affect this perk.",
				"Cannot be picked if you have [Nimble|Perk+perk_nimble]."
			]
		}]
 	}),
	RF_LongReach = ::UPD.getDescription({
 		Fluff = "\'If the target is watchin\' the head of yer pike, they\'re sure not watchin\' their back!\'",
 		Requirement = "Polearm",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Enemies within 2 tiles are considered [surrounded|Concept.Surrounding] by you for the purposes of hit-chance bonus for any allies attacking that target."
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
				"Gain " + ::MSU.Text.colorGreen("10%") + " of your Base [Ranged Skill|Concept.RangeSkill] as additional Minimum and Maximum Damage."
			]
		}]
 	}),
	RF_Menacing = ::UPD.getDescription({
 		Fluff = "Your appearance gives your enemies a bit of doubt!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Lower the [Resolve|Concept.Bravery] of adjacent enemies by " + ::MSU.Text.colorRed("-10") + "."
			]
		}]
 	}),
	RF_Momentum = ::UPD.getDescription({
 		Fluff = "\'Ye\'ve gotta get a running start!\'",
 		Requirement = "Throwing Weapon",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Throwing attacks do " + ::MSU.Text.colorGreen("5%") + " more damage and have their [Action Point|Concept.ActionPoints] cost reduced by " + ::MSU.Text.colorGreen(1) + " per tile moved before throwing."
			]
		}]
 	}),
	RF_MuscleMemory = ::UPD.getDescription({
 		Fluff = "Load.. aim.. fire... repeat!",
 		Requirement = "Crossbow or Handgonne",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The [Action Point|Concept.ActionPoints] Cost of reloading a Handgonne is reduced by " + ::MSU.Text.colorGreen(2) + ".",
				"When using a crossbow, for each point of current [Ranged Skill|Concept.RangeSkill] above 90, damage is increased by " + ::MSU.Text.colorGreen("1%") + " up to a maximum of " + ::MSU.Text.colorGreen("30%") + "."
			]
		}]
 	}),
 	RF_NailedIt = ::UPD.getDescription({
 		Fluff = "\'One javelin to the head will take \'em right out!\'",
 		Requirement = "Ranged attack",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Gain " + ::MSU.Text.colorGreen("+25%") + " chance to hit the head at a distance of 2 tiles. For every tile beyond that, this bonus is reduced by " + ::MSU.Text.colorRed("-5%") + ".",
				"The penalty to hitchance from obstructed line of sight is reduced by " + ::MSU.Text.colorGreen("50%") + " at a distance of 2 tiles."
			]
		}]
 	}),
	RF_OffhandTraining = ::UPD.getDescription({
 		Fluff = "Frequent use of tools with your offhand has given you an enviable level of ambidexterity!",
 		Requirement = "Buckler or Tool",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Once per [turn|Concept.Turn], the first use of the tool in your offhand costs no [Action Points|Concept.ActionPoints].",
				"Once per [turn|Concept.Turn], switching a buckler or tool in your offhand costs no [Action Points|Concept.ActionPoints]. Does not stack with other free item swapping skills e.g. Quick Hands.",
				"When equipped with a net, gain the [Trip Artist|NullEntitySkill+rf_trip_artist_effect] effect."
			]
		}]
 	}),
	RF_Opportunist = ::UPD.getDescription({
 		Fluff = "\'I\'m not lootin\' Captain! Just grabbing my javelin!\'",
 		Requirement = "Throwing Weapon",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The first 2 throwing attacks during a combat have their [Action Point|Concept.ActionPoints] costs " + ::MSU.Text.colorGreen("halved") + ".",
				"Every time you stand over an enemy\'s corpse during your [turn|Concept.Turn], gain " + ::MSU.Text.colorGreen(1) + " ammo and restore " + ::MSU.Text.colorGreen(4) + " [Action Points|Concept.ActionPoints]. Afterward, the next throwing attack has its [Fatigue|Concept.Fatigue] Cost " + ::MSU.Text.colorGreen("halved") + ".",
				"A corpse can only be used once per combat and cannot be used by multiple characters with this perk."
			]
		}]
 	}),
	RF_PatternRecognition = ::UPD.getDescription({
 		Fluff = "Your experience in battle has led to you being able to quickly adapt to an opponent\'s fighting style!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Every time an opponent attacks you or you attack an opponent, gain stacking [Melee Skill|Concept.MeleeSkill] and [Melee Defense|Concept.MeleeDefense] against that opponent for the remainder of the combat.",
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
				"When equipped with a shield, gain " + ::MSU.Text.colorGreen("+1") + " [Reach|Concept.Reach] per adjacent ally also equipped with a shield up to a maximum of " + ::MSU.Text.colorGreen("+2") + ".",
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
				"Attacks from crossbows and firearms have a " + ::MSU.Text.colorGreen("50%") + " chance to inflict [staggered|Skill+staggered_effect] for one [turn|Concept.Turn]."
			]
		}]
 	}),
	RF_Professional = ::UPD.getDescription({
 		Fluff = "You\'re a professional, experienced fighter, able to wield many weapons in many styles!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Gain the [Shield Expert|Perk+perk_shield_expert], [Duelist|Perk+perk_duelist], [Weapon Master|Perk+perk_rf_weapon_master], [Death Dealer|Perk+perk_rf_death_dealer], and [Formidable Approach|Perk+perk_rf_formidable_approach] perks."
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
			]
		}],
		Footer = ::MSU.Text.colorRed("This perk cannot be picked after you have spent a perk point elsewhere. This perk cannot be refunded.")
 	}),
	RF_ProximityThrowingSpecialist = ::UPD.getDescription({
 		Fluff = "\'Don\'t attack until you\'ve seen the whites of their eyes!\'",
 		Requirement = "Ranged attack",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Ranged attacks ignore an additional " + ::MSU.Text.colorGreen("25%") + " of the target\'s armor when attacking at a distance of 2 tiles."
			]
		}]
 	}),
	RF_Onslaught = ::UPD.getDescription({
 		Fluff = "Break their ranks, break their backs, break them all!",
 		Effects = [{
			Type = ::UPD.EffectType.Active,
			Description = [
				"Unlocks the [Onslaught|Skill+rf_onslaught_skill] skill which allows you and nearby members of your company to gain increased [Initiative|Concept.Initiative], [Melee Skill|Concept.MeleeSkill] and the [Line Breaker|Skill+rf_line_breaker_skill] skill for one [turn|Concept.Turn]. The first use of [Line Breaker|Skill+rf+rf_line_breaker_skill] has reduced [Action Point|Concept.ActionPoints] and [Fatigue|Concept.Fatigue] cost."
			]
		}]
 	}),
	RF_Rattle = ::UPD.getDescription({
 		Fluff = "Rattle your enemies to their bones to weaken them!",
 		Requirement = "Blunt Damage",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Every attack, which is either from a mace or does at least " + ::MSU.Text.colorRed(10) + " damage, applies the [Rattled|Skill+rf_rattled_effect] effect for one [turn|Concept.Turn]."
			]
		}]
 	}),
	RF_RealizedPotential = ::UPD.getDescription({
 		Fluff = "From rags to riches! This character has truly come a long way. Who was once a dreg of society is now a full-fledged mercenary. " + ::MSU.Text.colorGreen("All perk points have been refunded and attributes increased.") + ".",
		Footer = ::MSU.Text.colorRed("This perk cannot be refunded.")
 	}),
 	RF_Rebuke = ::UPD.getDescription({
 		Fluff = "Show \'em how it\'s done!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Gain the [Rebuke|Skill+rf_rebuke_effect] effect during combat which grants a " + ::MSU.Text.colorGreen("25%") + " chance to perform a free attack against an adjacent opponent who misses a melee attack against you.",
				"When wielding a shield, the chance is increased by an additional " + ::MSU.Text.colorGreen("+10%") + "."
			]
		}]
 	}),
	RF_RisingStar = ::UPD.getDescription({
 		Fluff = "Captain said take it slow and steady and I could become a legend someday!",
 		Effects = [
	 		{
				Type = ::UPD.EffectType.Passive,
				Description = [
					"[Experience|Concept.Experience] gained is increased by " + ::MSU.Text.colorGreen("20%") + " for the next 5 [levels|Concept.Level] and by " + ::MSU.Text.colorGreen("5%") + " after that."
				]
			},
			{
				Type = ::UPD.EffectType.OneTimeEffect,
				Description = [
					"Gain " + ::MSU.Text.colorGreen(2) + " perk points upon completing your next 5 [levels|Concept.Level] after picking this perk."
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
				"The chance to inflict [fatalities|Concept.Fatality] is increased by " + ::MSU.Text.colorGreen("50%") + ".",
				"[Fatalities|Concept.Fatality] refund " + ::MSU.Text.colorGreen("25%") + " of the Base [Fatigue|Concept.Fatigue] Cost of the skill used.",
				"During your [turn|Concept.Turn], every successful attack that applies [Bleeding|Skill+bleeding_effect], or is against an already [bleeding|Skill+bleeding_effect] target, improves your [Morale|Concept.Morale] by one level up to a maximum of Steady, and [fatalities|Concept.Fatality] instantly set the [Morale|Concept.Morale] to Confident."
			]
		}]
 	}),
	RF_SavageStrength = ::UPD.getDescription({
 		Fluff = "Orcs call me brother!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The [Fatigue|Concept.Fatigue] Cost of weapon skills is reduced by " + ::MSU.Text.colorRed("25%") + "."
			]
		}]
 	}),
	RF_ShieldSergeant = ::UPD.getDescription({
 		Fluff = "Lock and Shield",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Allies with a shield will use [Shieldwall|Skill+shieldwall] for free at the start of each battle.",
				"Allies within 2 tiles have the [Action Point|Concept.ActionPoints] and [Fatigue|Concept.Fatigue] costs of [Shieldwall|Skill+shieldwall] halved. Cannot reduce the [Action Point|Concept.ActionPoints] cost below " + ::MSU.Text.colorRed(2) + ".",
				"If you have the [Shieldwall|Skill+shieldwall] skill available, any ally who starts or ends their [turn|Concept.Turn] adjacent to you will use [Shieldwall|Skill+shieldwall] for free."
				"You will use [Shieldwall|Skill+shieldwall] for free as long as you start or end your [turn|Concept.Turn] adjacent to an ally who has the [Shieldwall|Skill+shieldwall] skill available."
				"Only members of your company are considered allies for this [perk|Concept.Perk]."
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
				"Upon destroying a shield using the [Split Shield|Skill+split_shield] skill, with any weapon, " + ::MSU.Text.colorGreen(4) + " [Action Points|Concept.ActionPoints] are instantly restored.",
			]
		}]
 	}),
	RF_SneakAttack = ::UPD.getDescription({
 		Fluff = "\'If you can see me, you\'re already dead.\'",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"When you enter a tile adjacent to an enemy, your next attack gains " + ::MSU.Text.colorGreen("+2") + " [Reach|Concept.Reach], has " + ::MSU.Text.colorGreen("+20%") + " armor penetration and deals " + ::MSU.Text.colorGreen("25%") + " increased damage."
				"The effect is lost upon switching an item, waiting or ending your [turn|Concept.Turn], or using any skill.",
				"Ranged attacks gain " + ::MSU.Text.colorGreen("+10%") + " armor penetration and " + ::MSU.Text.colorGreen("15%") + " increased damage against targets you have not previously attacked and who have not previously attacked you."
				"When wielding a melee weapon requires a weapon with [Reach|Concept.Reach] of " + ::MSU.Text.colorRed(4) + " or less and a total penalty to [Fatigue|Concept.Fatigue] from head and body armor less than " + ::MSU.Text.colorRed(20) + ".",
			]
		}]
 	}),
	RF_SpearAdvantage = ::UPD.getDescription({
 		Fluff = "Stick \'em with the pointy end.",
 		Requirement = "Spear",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Every successful hit against an opponent increases your [Melee Skill|Concept.MeleeSkill] and [Melee Defense|Concept.MeleeDefense] against that opponent by " + ::MSU.Text.colorGreen("+5") + " up to a maximum of " + ::MSU.Text.colorGreen("+20") + ".",
				"This bonus does not expire on its own but is lost upon taking damage from that opponent."
			]
		}]
 	}),
	RF_StrengthInNumbers = ::UPD.getDescription({
 		Fluff = "\'Yeah, skill doesn\'t mean so much when you\'re surrounded by 10 angry townsfolk with sharp pitchforks!\'",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Gain " + ::MSU.Text.colorGreen("+2") + " [Melee Skill|Concept.MeleeSkill], [Ranged Skill|Concept.RangeSkill], Melee  Defense and [Ranged Defense|Concept.RangeDefense] for each adjacent ally.",
				"Gain " + ::MSU.Text.colorGreen("+1") + " [Resolve|Concept.Bravery] for each ally on the battlefield, up to a maximum of " + ::MSU.Text.colorGreen("+20") + "."
			]
		}]
 	}),
	RF_SurvivalInstinct = ::UPD.getDescription({
 		Fluff = "Your will to live is strong!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Whenever you are attacked, gain a stacking bonus to [Melee Defense|Concept.MeleeDefense] and [Ranged Defense|Concept.RangeDefense] of " + ::MSU.Text.colorGreen("+2") + " on a miss and " + ::MSU.Text.colorGreen("+5") + " on a hit. This can stack up to " + ::MSU.Text.colorGreen("5") + " times for misses and up to " + ::MSU.Text.colorGreen("2") + " times for hits.",
				"At the start of every [turn|Concept.Turn] the bonus is reset except the bonus gained from getting hit which is retained for the remainder of the combat."
			]
		}]
 	}),
	RF_SweepingStrikes = ::UPD.getDescription({
 		Fluff = "Keep your enemies at bay with the sweeping swings of your weapon!",
 		Requirement = "Weapon with a [Reach|Concept.Reach] of 3 or greater"
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Attacks, hit or miss, increase your [Reach|Concept.Reach] by " + ::MSU.Text.colorGreen("+3") + " for AOE attacks, and " + ::MSU.Text.colorGreen("+1") + " for regular attacks until the start of your next [turn|Concept.Turn].",
			]
		}]
 	}),
	RF_SwiftStabs = ::UPD.getDescription({
 		Fluff = "Create an opening, then finish them!",
 		Requirement = "Non-hybrid Dagger"
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"A successful attack with your mainhand dagger reduces the [Action Point|Concept.ActionPoints] cost of all its skills by " + ::MSU.Text.colorGreen("2") + " to a minimum of " + ::MSU.Text.colorGreen("2") + " for the remainder of this [turn|Concept.Turn].",
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
 		Requirement = "Sword"
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"When using a non-fencing sword, the [Action Point|Concept.ActionPoints] costs of sword skills is reduced by " + ::MSU.Text.colorGreen(1) + ".",
				"Allows [Kata Step|Skill+rf_kata_step_skill] to be usable even while holding something, e.g. a shield, in your offhand.",
				"[Kata Step|Skill+rf_kata_step_skill] costs " + ::MSU.Text.colorGreen(2) + " fewer [Action Points|Concept.ActionPoints] and builds " + ::MSU.Text.colorGreen(2) + " less [Fatigue|Concept.Fatigue], both down to a minimum of 0."
			]
		}],
		Footer = ::MSU.Text.colorRed("You can only pick ONE perk from the Swordmaster perk group.")
 	}),
	RF_SwordmasterGrappler = ::UPD.getDescription({
 		Fluff = "You have to fight for your place in this world.",
 		Requirement = "Sword"
 		Effects = [
	 		{
				Type = ::UPD.EffectType.Active,
				Description = [
					"Unlocks the [Kick|Skill+rf_swordmaster_kick_skill] skill which allows you to knock back and [stagger|Skill+staggered_effect] a target."
					"When using a two-handed sword or double-gripping a one-handed sword, the [Action Point|Concept.ActionPoints] cost is reduced by " + ::MSU.Text.colorGreen(1) + " and the [Fatigue|Concept.Fatigue] Cost by " + ::MSU.Text.colorGreen(5) + "."

				]
			},
			{
				Type = ::UPD.EffectType.Active,
				Description = [
					"Unlocks the [Push Through|Skill+rf_swordmaster_push_through_skill] skill which allows you to knock back and stagger a target while moving into their tile in one action."
				]
			},
			{
				Type = ::UPD.EffectType.Active,
				Description = [
					"Unlocks the [Tackle|Skill+rf_swordmaster_tackle_skill] which allows you to exchange positions with and stagger an adjacent target."
				]
			}
		],
		Footer = ::MSU.Text.colorRed("You can only pick ONE perk from the Swordmaster perk group.")
 	}),
	RF_SwordmasterJuggernaut = ::UPD.getDescription({
 		Fluff = "There\'s a fine line between bravery and stupidity.",
 		Requirement = "Two-Handed Sword"
 		Effects = [
	 		{
				Type = ::UPD.EffectType.Passive,
				Description = [
					"Each single-target attack additionally does an attack on a random adjacent enemy to the target with " + ::MSU.Text.colorRed("50%") + " reduced damage."
				]
			},
			{
				Type = ::UPD.EffectType.Active,
				Description = [
					"Unlocks the [Juggernaut Charge|Skill+rf_swordmaster_charge_skill] that allows you to close the gap with your opponents, and attack, all in one action."
				]
			}
		],
		Footer = ::MSU.Text.colorRed("You can only pick ONE perk from the Swordmaster perk group.")
 	}),
	RF_SwordmasterMetzger = ::UPD.getDescription({
 		Fluff = "A sword, too, can take someone\'s head off just fine!",
 		Requirement = "Southern Sword or a Sword/Cleaver Hybrid"
 		Effects = [
	 		{
				Type = ::UPD.EffectType.Passive,
				Description = [
					"Adds the [Decapitate|Skill+decapitate] skill to southern swords.",
					"Grants the [Sanguinary|Perk+perk_rf_sanguinary] and [Bloodbath|Perk+perk_rf_bloodbath] perks for free as long as a valid weapon is equipped.",
					"Attacks inflict [Bleeding|Skill+bleeding_effect] on the target for " + ::MSU.Text.colorRed(10) + " damage."
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
 		Requirement = "Sword"
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The bonuses of [Swordmaster\'s Finesse|Skill+rf_swordmasters_finesse_effect] are doubled."
				"While wielding a fencing type sword an additional " + ::MSU.Text.colorGreen("25%") + " of damage ignores armor."
			]
		}],
		Footer = ::MSU.Text.colorRed("You can only pick ONE perk from the Swordmaster perk group.")
 	}),
	RF_SwordmasterReaper = ::UPD.getDescription({
 		Fluff = "Bring in the harvest!",
 		Requirement = "Sword"
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The [Action Point|Concept.ActionPoints] costs of AOE sword skills is reduced by " + ::MSU.Text.colorGreen(2) + " and the [Fatigue|Concept.Fatigue] Cost by " + ::MSU.Text.colorGreen("10%") + "."
			]
		}],
		Footer = ::MSU.Text.colorRed("You can only pick ONE perk from the Swordmaster perk group.")
 	}),
	RF_SwordmasterVersatileSwordsman = ::UPD.getDescription({
 		Fluff = "King of all trades. Jack of none.",
 		Requirement = "Sword"
 		Effects = [{
			Type = ::UPD.EffectType.Active,
			Description = [
				"Unlocks three stances which can be switched to during combat for a small [Action Point|Concept.ActionPoints] and [Fatigue|Concept.Fatigue] cost to gain different effects that last as long as the stance is kept."
				"The [Half-Swording|Skill+rf_swordmaster_stance_half_swording_skill] stance which allows you to [puncture|Skill+puncture] your opponents.",
				"The [Reverse Grip|Skill+rf_swordmaster_stance_reverse_grip_skill] stance which allows you to use your sword like a mace.",
				"The [Meisterhau|Skill+rf_swordmaster_stance_meisterhau_skill] stance which allows you to move and still benefit from [En Garde|Perk+perk_rf_en_garde]."
			]
		}],
		Footer = ::MSU.Text.colorRed("You can only pick ONE perk from the Swordmaster perk group.")
 	}),
	RF_TakeAim = ::UPD.getDescription({
 		Fluff = "You\'ve learned the value of taking time with your shots when the situation calls for it!",
 		Requirement = "Crossbow or Handgonne",
 		Effects = [{
			Type = ::UPD.EffectType.Active,
			Description = [
				"Unlocks the [Take Aim|Skill+rf_take_aim_skill] skill which allows you to target opponents behind obstacles with a [crossbow|Item+crossbow], or hit more targets with a [handgonne|Item+handgonne]."
			]
		}]
 	}),
	RF_TargetPractice = ::UPD.getDescription({
 		Fluff = "Time in training has allowed you to come up with an efficient way to organize your ammo, while increasing your accuracy!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Swapping quivers or bags of ammo never costs any [Action Points|Concept.ActionPoints].",
				"Ranged attacks gain " + ::MSU.Text.colorGreen("+10%") + " chance to hit against enemies wielding ranged weapons or enemies with none of their allies adjacent to them."
			]
		}]
 	}),
	RF_Tempo = ::UPD.getDescription({
 		Fluff = "By keeping ahead of your opponent, you set the terms of engagement!",
 		Effects = [
	 		{
				Type = ::UPD.EffectType.Passive,
				Description = [
					"Every attack, hit or miss, against a target who acts after you in the current round increases your [Initiative|Concept.Initiative] by " + ::MSU.Text.colorGreen("+15") + ".",
					"The bonus lasts over into your next [turn|Concept.Turn] but only until the first skill used or waiting that [turn|Concept.Turn]."
				]
			},
			{
				Type = ::UPD.EffectType.Passive,
				Description = [
					"When wielding a sword, gain the [Fluid Weapon|NullEntitySkill+rf_fluid_weapon_effect] effect."
				]
			}
		]
 	}),
	RF_TheRushOfBattle = ::UPD.getDescription({
 		Fluff = "\'It\'s not uncommon to make it to the end of the battle not remembering any details, just that you slew many men!\'",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Whenever you are attacked, hit or miss, gain a stacking " + ::MSU.Text.colorGreen("+5") + " [Initiative|Concept.Initiative] and " + ::MSU.Text.colorGreen("+5%") + " reduction to the [Fatigue|Concept.Fatigue] Cost of skills during your next [turn|Concept.Turn], up to a maximum of " + ::MSU.Text.colorGreen("+25") + " and " + ::MSU.Text.colorGreen("+25%") + " respectively."
			]
		}]
 	}),
	RF_ThroughTheGaps = ::UPD.getDescription({
 		Fluff = "Learn to call your strikes and target gaps in your opponents\' armor!",
 		Requirement = "Melee Piercing Attack",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
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
				"[Resolve|Concept.Bravery] is increased by " + ::MSU.Text.colorGreen("50%") + " against negative morale checks.",
				"If [Promised Potential|Perk+perk_rf_promised_potential] is a success, this perk becomes permanent and the perk point is refunded."
			]
		}],
		Footer = ::MSU.Text.colorRed("This perk cannot be refunded.")
 	}),
	RF_TripArtist = ::UPD.getDescription({
 		Fluff = "\'Let me take you on a trip to the floor.\'",
 		Requirement = "Equipped Net",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The first successful melee attack every [turn|Concept.Turn] against an adjacent target will apply the [staggered|Skill+staggered_effect] effect.",
				"When wielding a weapon with a [Reach|Concept.Reach] of less than 4, gain the difference in [Reach|Concept.Reach] up to 4."
			]
		}]
 	}),
	RF_TwoForOne = ::UPD.getDescription({
 		Fluff = "Practice in spear-handling has taught you to strike in the most efficient way possible!",
 		Requirement = "Spear",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The [Action Point|Concept.ActionPoints] cost of [Thrust|Skill+thrust] and [Prong|Skill+prong_skill] is reduced by " + ::MSU.Text.colorGreen(1) + ".",
				"When double-gripping one-handed spears, the range of [Thrust|Skill+thrust] is increased to " + ::MSU.Text.colorGreen(2) + " tiles. When used at this range, it does " + ::MSU.Text.colorRed("20%") + " reduced damage, has no bonus chance to hit, and has " + ::MSU.Text.colorRed("-20%") + " chance to hit per character between you and the target."
			]
		}]
 	}),
	RF_Unstoppable = ::UPD.getDescription({
 		Fluff = "Once you get going, you cannot be stopped!",
 		Requirement = "Melee Attack,"
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"During your [turn|Concept.Turn], every successful attack provides a stacking bonus to [Melee Skill|Concept.MeleeSkill] and [Action Points|Concept.ActionPoints].",
				"Each stack increases [Melee Skill|Concept.MeleeSkill] by " + ::MSU.Text.colorGreen("+5") + ".",
				"Your [Action Points|Concept.ActionPoints] are increased by a total of " + ::MSU.Text.colorGreen("+1") + " at 3 stacks, " + ::MSU.Text.colorGreen("+2") + " at 6 stacks and " + ::MSU.Text.colorGreen("+3") + " at 10 stacks.",
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
				"The effect lasts until your next attack or the end of your [turn|Concept.Turn]."
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
				"At the end of your [turn|Concept.Turn], gain " + ::MSU.Text.colorGreen("half") + " of your remaining [Action Points|Concept.ActionPoints], rounded down, as additional [Action Points|Concept.ActionPoints] during your next [turn|Concept.Turn]."
			]
		}]
 	}),
	RF_VigorousAssault = ::UPD.getDescription({
 		Fluff = "You\'ve learned to use the very momentum of your movement as a weapon unto itself!",
 		Requirement = "Melee or Throwing Attack",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"For every 2 tiles moved, the [Action Point|Concept.ActionPoints] cost of your next attack is reduced by " + ::MSU.Text.colorGreen(1) + " to a minimum of " + ::MSU.Text.colorGreen(1) + ", and the [Fatigue|Concept.Fatigue] Cost is reduced by " + ::MSU.Text.colorGreen("10%") + ".",
				"The bonus is lost upon waiting or ending your [turn|Concept.Turn], using any skill, or swapping your weapon except to or from a throwing weapon."
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
				"While a valid weapon is equipped, grants a [key perk|Misc.WeaponMasterPerks] from the weapon\'s perk group as long as this character has that perk in the perk tree."
			]
		}]
 	}),
	RF_WearThemDown = ::UPD.getDescription({
 		Fluff = "\'It ain\'t hard to dodge \'em when they\'re flailing around like fools...!\'"
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"Successful attacks apply the [Worn Down|Skill+rf_worn_down_effect] effect on the target.",
				"Gain a stacking " + ::MSU.Text.colorGreen("20%") + " chance that an enemy requires two successful rolls to hit you per negative status effect affecting the enemy. Valid status effects include: [worn down|Skill+rf_worn_down_effect], [stunned|Skill+stunned_effect], [dazed|Skill+dazed_effect], [rattled|Skill+rf_rattled_effect], [netted|Skill+net_effect], [sleeping|Skill+sleeping_effect], [staggered|Skill+staggered_effect], [rooted|Skill+rooted_effect], [webbed|Skill+web_effect].",
			]
		}]
 	}),
	RF_WearsItWell = ::UPD.getDescription({
 		Fluff = "Years of carrying heavy loads has given you the capability to carry the burden of your mercenary gear with ease!",
 		Effects = [{
			Type = ::UPD.EffectType.Passive,
			Description = [
				"The penalty to [Maximum Fatigue|Concept.MaximumFatigue] and [Initiative|Concept.Initiative] from equipped items in your head, body, mainhand and offhand slots is reduced by " + ::MSU.Text.colorRed("20%") + ". Stacks with [Brawny|Perk+perk_brawny]."
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

foreach (key, string in ::Const.Strings.PerkDescription)
{
	local parsedString = ::Reforged.Mod.Tooltips.parseString(string);
	::Const.Strings.PerkDescription[key] = parsedString;
}

::Const.Strings.Distance[4] = "far away";
::Const.Strings.Distance[5] = "very far away";
