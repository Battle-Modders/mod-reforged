::Reforged.ImmersiveDamage <- {
	MinDamageMult = 0.4,
	MaxDamageMult = 1.0,
	MinHitChance = 35,
	MaxHitChance = 70,
	ChanceCriticalFailure = 0,
	ChanceFullDamage = 20,
	// In the Fluff the string "targetName" is replaced by the name of the target entity when printing to combat log
	GoodnessThresholds = [
		{
			Threshold = 1.0,
			FluffMelee = [
				" swung perfectly",
				" got a perfect hit",
				" struck true"
			],
			FluffRanged = [
				" hit the mark perfectly",
				" landed a perfect shot"
			]
		},
		{
			Threshold = 0.8,
			FluffMelee = [
				"\'s attack was impressive but not quite perfect",
				" almost got a perfect hit"
			],
			FluffRanged = [
				" almost hit the bullseye",
				" almost got the perfect shot"
			]
		},
		{
			Threshold = 0.6,
			FluffMelee = [
				" managed to get a decent hit in",
				" managed a glancing hit"
			],
			FluffRanged = [
				" made a decent shot",
				"\'s shot was nothing to be ashamed of",
			]
		},
		{
			Threshold = 0.4,
			FluffMelee = [
				" could not get a good angle on the attack",
				"\'s attack manages to scrape targetName"
			],
			FluffRanged = [
				" could not get enough power in the shot"
			]
		},
		{
			Threshold = 0.2,
			FluffMelee = [
				"\'s attack was clumsy",
				" just barely managed to get a hit"
			],
			FluffRanged = [
				" almost missed targetName"
			]
		},
		{
			Threshold = 0,
			FluffMelee = [
				"\'s swing was poorly directed",
				"\'s attack was pathetic"
			],
			FluffRanged = [
				"\'s shot was poorly aimed",
				"\'s shot barely grazed targetName"
			]
		}
	],

	function addThreshold( _threshold, _fluffMelee, _fluffRanged )
	{
		this.GoodnessThresholds.push({
			Threshold = _threshold,
			FluffMelee = _fluffMelee,
			FluffRanged = _fluffRanged
		});

		this.GoodnessThresholds.sort(@(a, b) -1 * (a.Threshold <=> b.Threshold));
	}
};
