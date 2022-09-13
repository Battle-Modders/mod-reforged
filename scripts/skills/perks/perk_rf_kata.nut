this.perk_rf_kata <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false
	},
	function create()
	{
		this.m.ID = "perk.rf_kata";
		this.m.Name = ::Const.Strings.PerkName.RF_Kata;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Kata;
		this.m.Icon = "ui/perks/rf_kata.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local kataStep = ::new("scripts/skills/actives/rf_kata_step_skill");
		kataStep.m.IsForceEnabled = this.m.IsForceEnabled;
		this.getContainer().add(kataStep);
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_kata_step");
	}
});
