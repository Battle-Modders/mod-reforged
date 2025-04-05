this.perk_rf_swordmaster_blade_dancer <- ::inherit("scripts/skills/perks/perk_rf_swordmaster_abstract", {
	m = {
		WeaponSkillAPCostModifier = -1,
		WeaponSkillFatigueCostMult  = 0.75,
		PassingStepAPCostModifier = -2,
		PassingStepFatigueCostModifier = -2
	},
	function create()
	{
		this.perk_rf_swordmaster_abstract.create();
		this.m.ID = "perk.rf_swordmaster_blade_dancer";
		this.m.Name = ::Const.Strings.PerkName.RF_SwordmasterBladeDancer;
		this.m.Description = ::Const.Strings.PerkDescription.RF_SwordmasterBladeDancer;
		this.m.Icon = "ui/perks/perk_rf_swordmaster_blade_dancer.png";
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
					skill.m.ActionPointCost = ::Math.max(0, skill.m.ActionPointCost + this.m.WeaponSkillAPCostModifier);
					skill.m.FatigueCostMult *= this.m.WeaponSkillFatigueCostMult;
				}
			}
		}

		local passingStep = this.getContainer().getSkillByID("actives.rf_passing_step")
		if (passingStep != null)
		{
			passingStep.m.ActionPointCost += this.m.PassingStepAPCostModifier;
			passingStep.m.FatigueCost += this.m.PassingStepFatigueCostModifier;
			passingStep.m.RequireOffhandFree = false;
		}
	}
});
