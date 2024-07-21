this.perk_rf_hold_steady <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_hold_steady";
		this.m.Name = ::Const.Strings.PerkName.RF_HoldSteady;
		this.m.Description = ::Const.Strings.PerkDescription.RF_HoldSteady;
		this.m.Icon = "ui/perks/perk_rf_hold_steady.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_hold_steady_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_hold_steady");
	}
});
