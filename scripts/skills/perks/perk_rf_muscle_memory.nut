this.perk_rf_muscle_memory <- ::inherit("scripts/skills/skill", {
	m = {
		// Public
		CrossbowRedution = 1,
		HeavyCrossbowReduction = 2,
		HandgonneReduction = 3,

		// Const
		MinimumAPCost = 1
	},
	function create()
	{
		this.m.ID = "perk.rf_muscle_memory";
		this.m.Name = ::Const.Strings.PerkName.RF_MuscleMemory;
		this.m.Description = ::Const.Strings.PerkDescription.RF_MuscleMemory;
		this.m.Icon = "ui/perks/rf_muscle_memory.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate(_properties)
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null) return;

		if (weapon.isWeaponType(::Const.Items.WeaponType.Crossbow))
		{
			local reloadCrossbowSkill = this.getContainer().getSkillByID("actives.reload_bolt");
			if (reloadCrossbowSkill != null)
			{
				// This differentiation is flawed and should be eventually replaced with some sort of Heavy-Tag on the crossbows
				if (reloadCrossbowSkill.m.ActionPointCost <= 5)	// We are looking at a normal crossbow
				{
					reloadCrossbowSkill.m.ActionPointCost -= this.m.CrossbowRedution;
				}
				else	// We are looking at a heavy crossbow
				{
					reloadCrossbowSkill.m.ActionPointCost -= this.m.HeavyCrossbowReduction;
				}
				reloadCrossbowSkill.m.ActionPointCost = ::Math.max(this.m.MinimumAPCost, reloadCrossbowSkill.m.ActionPointCost);
			}
		}
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Firearm))
		{
			local reloadHandgonneSkill = this.getContainer().getSkillByID("actives.reload_handgonne");
			if (reloadHandgonneSkill != null)
			{
				reloadHandgonneSkill.m.ActionPointCost -= this.m.HandgonneReduction;
				reloadHandgonneSkill.m.ActionPointCost = ::Math.max(this.m.MinimumAPCost, reloadHandgonneSkill.m.ActionPointCost);
			}
		}
	}
});
