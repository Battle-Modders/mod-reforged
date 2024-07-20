this.perk_rf_muscle_memory <- ::inherit("scripts/skills/skill", {
	m = {
		MaxBonus = 30
	},
	function create()
	{
		this.m.ID = "perk.rf_muscle_memory";
		this.m.Name = ::Const.Strings.PerkName.RF_MuscleMemory;
		this.m.Description = ::Const.Strings.PerkDescription.RF_MuscleMemory;
		this.m.Icon = "ui/perks/rf_muscle_memory.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Last;
	}

	function onAfterUpdate(_properties)
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Crossbow))
		{
			_properties.RangedDamageMult *= 1.0 + ::Math.minf(this.m.MaxBonus * 0.01, ::Math.maxf(0, (_properties.RangedSkill - 90) * 0.01));
		}
		else
		{
			local reloadHandgonne = this.getContainer().getSkillByID("actives.reload_handgonne");
			if (reloadHandgonne != null && reloadHandgonne.m.ActionPointCost > 1)
			{
				reloadHandgonne.m.ActionPointCost -= 2;
			}
		}
	}
});
