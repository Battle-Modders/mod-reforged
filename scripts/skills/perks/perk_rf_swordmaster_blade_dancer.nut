this.perk_rf_swordmaster_blade_dancer <- ::inherit("scripts/skills/perks/perk_rf_swordmaster_abstract", {
	m = {
		APCostAdd = -1,
		FatCostMult  = 0.75 // FatigueCostMult is a standard entry in skill so we use a slightly different name
	},
	function create()
	{
		this.perk_rf_swordmaster_abstract.create();
		this.m.ID = "perk.rf_swordmaster_blade_dancer";
		this.m.Name = ::Const.Strings.PerkName.RF_SwordmasterBladeDancer;
		this.m.Description = ::Const.Strings.PerkDescription.RF_SwordmasterBladeDancer;
		this.m.Icon = "ui/perks/rf_swordmaster_blade_dancer.png";
	}

	function getInitiativeBonus()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon == null ? 0 : 100 * (weapon.m.DirectDamageMult + weapon.m.DirectDamageAdd);
	}

	function onUpdate( _properties )
	{
		if (this.isEnabled())
			_properties.Initiative += this.getInitiativeBonus();
	}

	function onAfterUpdate( _properties )
	{
		if (!this.isEnabled())
			return;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (!weapon.isItemType(::Const.Items.ItemType.RF_Fencing))
		{
			foreach (skill in weapon.getSkills())
			{
				if (!skill.isAOE())
				{
					skill.m.ActionPointCost = ::Math.max(0, skill.m.ActionPointCost + this.m.APCostAdd);
					skill.m.FatigueCostMult *= this.m.FatCostMult;
				}
			}
		}

		local kataStep = this.getContainer().getSkillByID("actives.rf_kata_step")
		if (kataStep != null)
		{
			kataStep.m.ActionPointCost = ::Math.max(0, kataStep.m.ActionPointCost - 2);
			kataStep.m.FatigueCost = ::Math.max(0, kataStep.m.FatigueCost - 2);
		}
	}
});
