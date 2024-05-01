this.pg_special_rf_leadership <- ::inherit(::DynamicPerks.Class.SpecialPerkGroup, {
	m = {},
	function create()
	{
		this.special_perk_group.create();
		this.m.ID = "pg.special.rf_leadership";
		this.m.Name = "Leadership";
		this.m.Icon = "ui/perk_groups/rf_leadership.png";
		this.m.FlavorText = [
			"is a natural born leader",
			"has an aura of leadership",
			"seems like a capable leader"
		];
		this.m.Chance = 3;
		this.m.Trees = {
			"default": [
				["perk.rf_supporter"],
				["perk.rally_the_troops"],
				["perk.fortified_mind"],
				["perk.mastery.polearm"],
				["perk.rf_command"],
				[],
				["perk.inspiring_presence"]
			]
		};
	}
});
