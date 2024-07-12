this.perk_rf_fruits_of_labor <- ::inherit("scripts/skills/skill", {
	m = {
		Bonus = 10
	},
	function create()
	{
		this.m.ID = "perk.rf_fruits_of_labor";
		this.m.Name = ::Const.Strings.PerkName.RF_FruitsOfLabor;
		this.m.Description = ::Const.Strings.PerkDescription.RF_FruitsOfLabor;
		this.m.Icon = "ui/perks/rf_fruits_of_labor.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate(_properties)
	{
		local baseProperties = this.getContainer().getActor().getBaseProperties();

		local mult = this.m.Bonus * 0.01;

		_properties.Hitpoints += ::Math.floor(mult * baseProperties.Hitpoints);
		_properties.Stamina += ::Math.floor(mult * baseProperties.Stamina);
	}
});
