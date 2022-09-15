this.perk_rf_swordmaster_reaper <- ::inherit("scripts/skills/perks/perk_rf_swordmaster_abstract", {
	m = {
		ActionPointCostReduction = 2,
		FatigueCostMultReduction = 0.1
	},
	function create()
	{
		this.perk_rf_swordmaster_abstract.create();
		this.m.ID = "perk.rf_swordmaster_reaper";
		this.m.Name = ::Const.Strings.PerkName.RF_SwordmasterReaper;
		this.m.Description = ::Const.Strings.PerkDescription.RF_SwordmasterReaper;
		this.m.Icon = "ui/perks/rf_swordmaster_reaper.png";
	}

	function onAfterUpdate( _properties )
	{
		if (!this.isEnabled()) return;

		foreach (skill in this.getContainer().getActor().getMainhandItem().getSkills())
		{
			if (skill.isAttack() && skill.isAOE() && !skill.isRanged())
			{
				skill.m.ActionPointCost = ::Math.max(1, skill.m.ActionPointCost - this.m.ActionPointCostReduction);
				skill.m.FatigueCostMult *= 1 - this.m.FatigueCostMultReduction;
			}
		}
	}
});
