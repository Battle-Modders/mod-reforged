this.perk_rf_hybridization <- ::inherit("scripts/skills/skill", {
	m = {
		Bonus = 10
	},
	function create()
	{
		this.m.ID = "perk.rf_hybridization";
		this.m.Name = ::Const.Strings.PerkName.RF_Hybridization;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Hybridization;
		this.m.Icon = "ui/perks/rf_hybridization.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local bonus = ::Math.floor(this.getContainer().getActor().getBaseProperties().getRangedSkill() * this.m.Bonus * 0.01);

		_properties.MeleeSkill += bonus;
		_properties.MeleeDefense += bonus;
	}
});

