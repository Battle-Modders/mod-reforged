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
		_properties.StaminaModifierMult[::Const.ItemSlot.Mainhand] *= this.m.WeightMultiplier;
		_properties.StaminaModifierMult[::Const.ItemSlot.Offhand] *= this.m.WeightMultiplier;
		_properties.StaminaModifierMult[::Const.ItemSlot.Body] *= this.m.WeightMultiplier;
		_properties.StaminaModifierMult[::Const.ItemSlot.Head] *= this.m.WeightMultiplier;

		_properties.InitiativeModifierMult[::Const.ItemSlot.Mainhand] *= this.m.WeightMultiplier;
		_properties.InitiativeModifierMult[::Const.ItemSlot.Offhand] *= this.m.WeightMultiplier;
		_properties.InitiativeModifierMult[::Const.ItemSlot.Body] *= this.m.WeightMultiplier;
		_properties.InitiativeModifierMult[::Const.ItemSlot.Head] *= this.m.WeightMultiplier;
	}
});
