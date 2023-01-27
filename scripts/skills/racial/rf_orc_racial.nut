this.rf_orc_racial <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.rf_orc";
		this.m.Name = "Orc Racial";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.Type = ::Const.SkillType.Racial;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/traits/iron_jaw_trait"));
	}
});
