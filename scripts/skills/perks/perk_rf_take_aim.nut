this.perk_rf_take_aim <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_take_aim";
		this.m.Name = ::Const.Strings.PerkName.RF_TakeAim;
		this.m.Description = ::Const.Strings.PerkDescription.RF_TakeAim;
		this.m.Icon = "ui/perks/rf_take_aim.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_take_aim_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_take_aim");
	}
});
