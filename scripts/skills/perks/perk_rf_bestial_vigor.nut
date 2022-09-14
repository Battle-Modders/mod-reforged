this.perk_rf_bestial_vigor <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_bestial_vigor";
		this.m.Name = ::Const.Strings.PerkName.RF_BestialVigor;
		this.m.Description = ::Const.Strings.PerkDescription.RF_BestialVigor;
		this.m.Icon = "ui/perks/rf_bestial_vigor.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_bestial_vigor_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_bestial_vigor");
	}
});
