this.perk_rf_vanquisher <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_vanquisher";
		this.m.Name = ::Const.Strings.PerkName.RF_Vanquisher;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Vanquisher;
		this.m.Icon = "ui/perks/rf_vanquisher.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_gain_ground_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_gain_ground");
	}
});
