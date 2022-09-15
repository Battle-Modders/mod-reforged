this.perk_rf_hale_and_hearty <- ::inherit("scripts/skills/skill", {
	m = {
		FatigueRecoveryBonusPercentage = 5
	},
	function create()
	{
		this.m.ID = "perk.rf_hale_and_hearty";
		this.m.Name = ::Const.Strings.PerkName.RF_HaleAndHearty;
		this.m.Description = ::Const.Strings.PerkDescription.RF_HaleAndHearty;
		this.m.Icon = "ui/perks/rf_hale_and_hearty.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate(_properties)
	{
		_properties.FatigueRecoveryRate += ::Math.floor(0.01 * this.m.FatigueRecoveryBonusPercentage * this.getContainer().getActor().getFatigueMax());
	}
});
