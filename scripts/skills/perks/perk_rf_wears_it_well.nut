this.perk_rf_wears_it_well <- ::inherit("scripts/skills/skill", {
	m = {
		FatPenReduction = 20
	},
	function create()
	{
		this.m.ID = "perk.rf_wears_it_well";
		this.m.Name = ::Const.Strings.PerkName.RF_WearsItWell;
		this.m.Description = ::Const.Strings.PerkDescription.RF_WearsItWell;
		this.m.Icon = "ui/perks/perk_rf_wears_it_well.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onUpdate(_properties)
	{
		local actor = this.getContainer().getActor();
		local fat = actor.getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);

		local mainhand = actor.getMainhandItem();
		if (mainhand != null)
		{
			fat += mainhand.getStaminaModifier();
		}

		local offhand = actor.getOffhandItem();
		if (offhand != null)
		{
			fat += offhand.getStaminaModifier();
		}

		_properties.Stamina -= fat * this.m.FatPenReduction * 0.01;
	}
});
