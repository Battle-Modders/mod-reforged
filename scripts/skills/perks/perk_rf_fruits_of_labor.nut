this.perk_rf_fruits_of_labor <- ::inherit("scripts/skills/skill", {
	m = {
		BonusPct = 0.1
	},
	function create()
	{
		this.m.ID = "perk.rf_fruits_of_labor";
		this.m.Name = ::Const.Strings.PerkName.RF_FruitsOfLabor;
		this.m.Description = ::Const.Strings.PerkDescription.RF_FruitsOfLabor;
		this.m.Icon = "ui/perks/perk_rf_fruits_of_labor.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onUpdate(_properties)
	{
		local baseProperties = this.getContainer().getActor().getBaseProperties();

		_properties.Hitpoints += ::Math.round(baseProperties.Hitpoints * this.m.BonusPct);
		_properties.Stamina += ::Math.round(baseProperties.Stamina * this.m.BonusPct);
	}
});
