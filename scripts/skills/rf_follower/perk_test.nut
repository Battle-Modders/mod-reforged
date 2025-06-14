this.perk_test <- this.inherit("scripts/skills/rf_follower/rf_follower_perk", {
	m = {},
	function create()
	{
		this.rf_follower_perk.create()
		this.m.ID = "perk.test";
		this.m.Name = "Test";
		this.m.Description = "Test Description";
		this.m.Icon = "ui/perks/perk_06.png";
		this.setRequiredPerksForUnlock({
			"generic" : 1
		})
	}
});

