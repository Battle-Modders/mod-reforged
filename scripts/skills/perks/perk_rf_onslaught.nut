this.perk_rf_onslaught <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_onslaught";
		this.m.Name = ::Const.Strings.PerkName.RF_Onslaught;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Onslaught;
		this.m.Icon = "ui/perks/rf_onslaught.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_onslaught_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_onslaught");
	}
});
