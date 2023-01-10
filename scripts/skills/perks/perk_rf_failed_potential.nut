this.perk_rf_failed_potential <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_failed_potential";
		this.m.Name = ::Const.Strings.PerkName.RF_FailedPotential;
		this.m.Description = ::Const.Strings.PerkDescription.RF_FailedPotential;
		this.m.Icon = "ui/perks/rf_failed_potential.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.IsRefundable = false;
	}
});
