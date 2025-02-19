this.rf_renowned_swordmaster_background <- ::inherit("scripts/skills/backgrounds/swordmaster_background", {
	m = {},
	function create()
	{
		this.swordmaster_background.create();
		this.m.ID = "background.rf_renowned_swordmaster";
		this.m.Name = "Renowned Swordmaster";
		this.m.ExcludedTalents = [
			::Const.Attributes.RangedSkill,
			::Const.Attributes.RangedDefense
		];
		this.m.Titles = [
			"the Legend",
			"the Singing Blade",
			"the Master"
		];
		this.m.HairColors = ::Const.HairColors.Young;
		this.m.Level = ::Math.rand(3, 5);
		this.m.IsCombatBackground = true;
	}

	function onChangeAttributes()
	{
		return {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				12,
				10
			],
			Stamina = [
				10,
				5
			],
			MeleeSkill = [
				25,
				20
			],
			RangedSkill = [
				-5,
				-5
			],
			MeleeDefense = [
				10,
				15
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				20,
				10
			]
		};
	}
});

