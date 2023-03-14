this.perk_rf_rebuke <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_rebuke";
		this.m.Name = ::Const.Strings.PerkName.RF_Rebuke;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Rebuke;
		this.m.Icon = "ui/perks/rf_rebuke.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onCombatStarted()
	{
		this.getContainer().add(::new("scripts/skills/effects/rf_rebuke_effect"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("effects.rf_rebuke");
	}
});
