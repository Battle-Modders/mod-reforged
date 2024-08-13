

// The purpose of this skill is to inform the player that a sling can also be used to sling pots from your bag over the battle field
// By giving it a dummy skill that skill will show up in our nested tooltip

this.rf_sling_item_dummy_skill <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rf_sling_item_dummy";
		this.m.Name = "Sling Item";
		this.m.Description = "Propel utility items from your bag, e.g. bombs, pots and flasks, using your sling."
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsHidden = true;	 // This skill should never show up anywhere except as a nested tooltip

		// These values will show up on the nested tooltip. These will stop being correct as soon as we introduce indiviual costs for the different pots
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 25;
	}

	function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range equal to the range of your equipped sling"
		});
		return ret;
	}
});
