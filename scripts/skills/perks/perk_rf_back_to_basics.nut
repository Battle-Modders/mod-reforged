this.perk_rf_back_to_basics <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_back_to_basics";
		this.m.Name = ::Const.Strings.PerkName.RF_BackToBasics;
		this.m.Description = ::Const.Strings.PerkDescription.RF_BackToBasics;
		this.m.Icon = "ui/perks/perk_rf_back_to_basics.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsRefundable = false;
	}

	function onAdded()
	{
		if (this.m.IsNew)
		{
			local actor = this.getContainer().getActor();
			if (::MSU.isKindOf(actor, "player"))
			{
				// One perk tier is added after this function due to picking the perk.
				// So if we want to set it to 2, we set it to 1
				actor.setPerkTier(1);
				actor.m.PerkPoints += 2;
			}
		}
	}
});
