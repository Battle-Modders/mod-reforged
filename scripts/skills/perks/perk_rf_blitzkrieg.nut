this.perk_rf_blitzkrieg <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_blitzkrieg";
		this.m.Name = ::Const.Strings.PerkName.RF_Blitzkrieg;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Blitzkrieg;
		this.m.Icon = "ui/perks/perk_rf_blitzkrieg.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_blitzkrieg_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_blitzkrieg");
	}
});
