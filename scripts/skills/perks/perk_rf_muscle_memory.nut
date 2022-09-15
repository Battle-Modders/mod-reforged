this.perk_rf_muscle_memory <- ::inherit("scripts/skills/skill", {
	m = {},
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
		local reloadBolt = this.getContainer().getSkillByID("actives.reload_bolt");
		if (reloadBolt != null && reloadBolt.m.ActionPointCost > 4)
		{
			reloadBolt.m.ActionPointCost -= 1;
		}

		local reloadHandgonne = this.getContainer().getSkillByID("actives.reload_handgonne");
		if (reloadHandgonne != null && reloadHandgonne.m.ActionPointCost > 2)
		{
			reloadHandgonne.m.ActionPointCost -= 2;
		}
	}
});
