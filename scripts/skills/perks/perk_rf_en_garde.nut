this.perk_rf_en_garde <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_en_garde";
		this.m.Name = ::Const.Strings.PerkName.RF_EnGarde;
		this.m.Description = ::Const.Strings.PerkDescription.RF_EnGarde;
		this.m.Icon = "ui/perks/perk_rf_en_garde.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_en_garde_toggle_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_en_garde_toggle");
	}
});
