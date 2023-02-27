// Example of a perk that reduces penalty to Maximum Fatigue from Head armor by 20%
// and penalty to Initiative from Body armor by 50%

this.perk_rf_example <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_example";
		this.m.Name = ::Const.Strings.PerkName.RF_Angler;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Angler;
		this.m.Icon = "ui/perks/rf_angler.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local headItem = actor.getHeadItem();
		local bodyItem = actor.getBodyItem();

		if (headItem != null)
		{
			_properties.Stamina -= headItem.getStaminaModifier() * 0.2; // subtract because it is negative
		}

		if (bodyItem != null)
		{
			_properties.Initiative -= bodyItem.getStaminaModifier() * 0.5; // subtract because it is negative
		}
	}
});
