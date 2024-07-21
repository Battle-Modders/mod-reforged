this.perk_rf_swordmaster_grappler <- ::inherit("scripts/skills/perks/perk_rf_swordmaster_abstract", {
	m = {},
	function create()
	{
		this.perk_rf_swordmaster_abstract.create();
		this.m.ID = "perk.rf_swordmaster_grappler";
		this.m.Name = ::Const.Strings.PerkName.RF_SwordmasterGrappler;
		this.m.Description = ::Const.Strings.PerkDescription.RF_SwordmasterGrappler;
		this.m.Icon = "ui/perks/perk_rf_swordmaster_grappler.png";
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_swordmaster_tackle_skill"));
		this.getContainer().add(::new("scripts/skills/actives/rf_swordmaster_kick_skill"));
		this.getContainer().add(::new("scripts/skills/actives/rf_swordmaster_push_through_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_swordmaster_tackle");
		this.getContainer().removeByID("actives.rf_swordmaster_kick");
		this.getContainer().removeByID("actives.rf_swordmaster_push_through");
	}
});
