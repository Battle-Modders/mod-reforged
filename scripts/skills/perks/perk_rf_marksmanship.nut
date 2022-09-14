this.perk_rf_marksmanship <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_marksmanship";
		this.m.Name = ::Const.Strings.PerkName.RF_Marksmanship;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Marksmanship;
		this.m.Icon = "ui/perks/rf_marksmanship.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate(_properties)
	{
		if (this.getContainer().getActor().isArmedWithRangedWeapon())
		{
			local bonus = ::Math.floor(this.getContainer().getActor().getBaseProperties().getRangedSkill() * 0.1);
			_properties.DamageRegularMin += bonus;
			_properties.DamageRegularMax += bonus;
		}
	}
});
