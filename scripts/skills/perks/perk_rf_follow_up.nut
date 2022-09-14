this.perk_rf_follow_up <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_follow_up";
		this.m.Name = ::Const.Strings.PerkName.RF_FollowUp;
		this.m.Description = ::Const.Strings.PerkDescription.RF_FollowUp;
		this.m.Icon = "ui/perks/rf_follow_up.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	
	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_follow_up_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_follow_up");
	}
});

