this.rf_old_swordmaster_background <- ::inherit("scripts/skills/backgrounds/swordmaster_background", {
	m = {},
	function create()
	{
		this.swordmaster_background.create();
		this.m.ID = "background.rf_old_swordmaster";
		this.m.Name = "Old Swordmaster";
		this.m.Icon = "ui/backgrounds/rf_old_swordmaster_background.png";
		this.m.ExcludedTalents = [
			::Const.Attributes.RangedSkill,
			::Const.Attributes.RangedDefense
		];
		this.m.Excluded.extend([
			"trait.fat"
		]);
		this.m.BeardChance = 100;
	}
});

