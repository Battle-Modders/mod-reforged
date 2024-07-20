this.perk_rf_hip_shooter <- ::inherit("scripts/skills/skill", {
	m = {
		Count = 0,
		FatigueCostIncreasePerCount = 10
	},
	function create()
	{
		this.m.ID = "perk.rf_hip_shooter";
		this.m.Name = ::Const.Strings.PerkName.RF_HipShooter;
		this.m.Description = ::Const.Strings.PerkDescription.RF_HipShooter;
		this.m.Icon = "ui/perks/rf_hip_shooter.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.VeryLast;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.getID() == "actives.quick_shot")
		{
			this.m.Count++;
		}
	}

	function onAfterUpdate(_properties)
	{
		local quickShot = this.getContainer().getSkillByID("actives.quick_shot");
		if (quickShot != null)
		{
			quickShot.m.ActionPointCost -= 1;
			quickShot.m.FatigueCostMult *= 1.0 + (this.m.FatigueCostIncreasePerCount * 0.01 * this.m.Count);
		}
	}

	function onTurnEnd()
	{
		this.m.Count = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Count = 0;
	}
});
