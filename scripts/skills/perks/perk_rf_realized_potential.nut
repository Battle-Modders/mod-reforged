this.perk_rf_realized_potential <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_realized_potential";
		this.m.Name = ::Const.Strings.PerkName.RF_RealizedPotential;
		this.m.Description = ::Const.Strings.PerkDescription.RF_RealizedPotential;
		this.m.Icon = "ui/perks/rf_realized_potential.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsRefundable = false;
	}
});
