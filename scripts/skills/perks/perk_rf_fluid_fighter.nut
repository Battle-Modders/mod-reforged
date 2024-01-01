this.perk_rf_fluid_fighter <- ::inherit("scripts/skills/skill", {
	m = {
		HasProcced = false,
		ProccedSkillID = "",

		// Config
		ActionPointDiscount = 1,
		MinimumReduction = 2,
	},

	function create()
	{
		this.m.ID = "perk.rf_fluid_fighter";
		this.m.Name = ::Const.Strings.PerkName.RF_FluidFighter;
		this.m.Description = ::Const.Strings.PerkDescription.RF_FluidFighter;
		// this.m.Icon = "ui/perks/rf_fluid_fighter.png";		// Todo: create icon for this
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk + 5;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onNewRound()
	{
		this.reset();
	}

	function onCombatFinished()
	{
		this.reset();
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (!this.m.HasProcced && _skill.getActionPointCost())
		{
			this.m.HasProcced = true;
			this.m.ProccedSkillID = _skill.getID();
		}
	}

	function onAfterUpdate( _properties )
	{
		if (this.HasProcced)
		{
			foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
			{
				if (skill.getID() != this.m.ProccedSkillID)
				{
					skill.m.ActionPointCost -= ::Math.max(this.m.MinimumReduction, skill.m.ActionPointCost - this.m.ActionPointDiscount);
				}
			}
		}
	}

	// TODO: make this function work
	function onAffordablePreview( _skill, _movementTile )
	{
		if (_skill != null && _skill.getActionPointCost() != 0 && _skill.getFatigueCost() != 0)
		{
			foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
			{
				this.modifyPreviewField(skill, "ActionPointCost", 0, false);
			}
		}
	}

// New Functions
	function reset()
	{
		this.m.HasProcced = false;
		this.m.ProccedSkillID = "";
	}
});
