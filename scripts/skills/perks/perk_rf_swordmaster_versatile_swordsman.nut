this.perk_rf_swordmaster_versatile_swordsman <- ::inherit("scripts/skills/perks/perk_rf_swordmaster_abstract", {
	m = {},
	function create()
	{
		this.perk_rf_swordmaster_abstract.create();
		this.m.ID = "perk.rf_swordmaster_versatile_swordsman";
		this.m.Name = ::Const.Strings.PerkName.RF_SwordmasterVersatileSwordsman;
		this.m.Description = ::Const.Strings.PerkDescription.RF_SwordmasterVersatileSwordsman;
		this.m.Icon = "ui/perks/rf_swordmaster_versatile_swordsman.png";
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_swordmaster_stance_half_swording_skill"));
		this.getContainer().add(::new("scripts/skills/actives/rf_swordmaster_stance_reverse_grip_skill"));
		this.getContainer().add(::new("scripts/skills/actives/rf_swordmaster_stance_meisterhau_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_swordmaster_stance_half_swording");
		this.getContainer().removeByID("actives.rf_swordmaster_stance_reverse_grip");
		this.getContainer().removeByID("actives.rf_swordmaster_stance_meisterhau");
	}
});
