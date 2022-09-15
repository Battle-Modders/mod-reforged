this.perk_rf_swordmaster_blade_dancer <- ::inherit("scripts/skills/perks/perk_rf_swordmaster_abstract", {
	m = {},
	function create()
	{
		this.perk_rf_swordmaster_abstract.create();
		this.m.ID = "perk.rf_swordmaster_blade_dancer";
		this.m.Name = ::Const.Strings.PerkName.RF_SwordmasterBladeDancer;
		this.m.Description = ::Const.Strings.PerkDescription.RF_SwordmasterBladeDancer;
		this.m.Icon = "ui/perks/rf_swordmaster_blade_dancer.png";
	}

	function onAfterUpdate( _properties )
	{
		if (!this.isEnabled()) return;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (!weapon.isItemType(::Const.Items.WeaponType.RF_Fencing))
		{
			foreach (skill in weapon.getSkills())
			{
				skill.m.ActionPointCost = ::Math.max(0, skill.m.ActionPointCost - 1);
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
