this.perk_rf_passing_step <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Sword,
		RequiredDamageType = ::Const.Damage.DamageType.Cutting,
		RequireOffhandFree = true, // Require equipping two-handed weapon, or having off-hand free
	},
	function create()
	{
		this.m.ID = "perk.rf_passing_step";
		this.m.Name = ::Const.Strings.PerkName.RF_PassingStep;
		this.m.Description = ::Const.Strings.PerkDescription.RF_PassingStep;
		this.m.Icon = "ui/perks/perk_rf_passing_step.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAdded()
	{
		local passingStep = ::new("scripts/skills/actives/rf_passing_step_skill");
		passingStep.m.RequiredDamageType = this.m.RequiredDamageType;
		passingStep.m.RequiredWeaponType = this.m.RequiredWeaponType;
		passingStep.m.RequireOffhandFree = this.m.RequireOffhandFree;
		this.getContainer().add(passingStep);
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_passing_step");
	}
});
