this.perk_rf_push_forward <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_push_forward";
		this.m.Name = ::Const.Strings.PerkName.RF_PushForward;
		this.m.Description = ::Const.Strings.PerkDescription.RF_PushForward;
		this.m.Icon = "ui/perks/rf_push_forward.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_push_forward_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_push_forward");
	}
});
