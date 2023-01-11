this.perk_rf_back_to_basics <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_back_to_basics";
		this.m.Name = ::Const.Strings.PerkName.RF_BackToBasics;
		this.m.Description = ::Const.Strings.PerkDescription.RF_BackToBasics;
		this.m.Icon = "ui/perks/rf_back_to_basics.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.IsRefundable = false;
	}

	function onAdded()
	{
		if (this.m.IsNew)
		{
			this.getContainer().getActor().getBackground().getPerkTree().setPerkTier(2);
			this.getContainer().getActor().m.PerkPoints += 2;
		}
	}
});
