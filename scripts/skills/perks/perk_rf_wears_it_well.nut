this.perk_rf_wears_it_well <- ::inherit("scripts/skills/skill", {
	m = {
		WeightMultiplier = 0.8
	},
	function create()
	{
		this.m.ID = "perk.rf_wears_it_well";
		this.m.Name = ::Const.Strings.PerkName.RF_WearsItWell;
		this.m.Description = ::Const.Strings.PerkDescription.RF_WearsItWell;
		this.m.Icon = "ui/perks/rf_wears_it_well.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate(_properties)
	{
		_properties.WeightMult[::Const.ItemSlot.Mainhand] *= this.m.WeightMultiplier;
		_properties.WeightMult[::Const.ItemSlot.Offhan] *= this.m.WeightMultiplier;
		_properties.WeightMult[::Const.ItemSlot.Body] *= this.m.WeightMultiplier;
		_properties.WeightMult[::Const.ItemSlot.Head] *= this.m.WeightMultiplier;
	}
});
