this.perk_rf_fresh_and_furious <- ::inherit("scripts/skills/skill", {
	m = {
		IsUsingFreeSkill = false,
		IsSpent = true,
		RequiresRecover = false,
		FatigueThreshold = 0.3
	},
	function create()
	{
		this.m.ID = "perk.rf_fresh_and_furious";
		this.m.Name = ::Const.Strings.PerkName.RF_FreshAndFurious;
		this.m.Description = "This character is exceptionally fast when not fatigued.";
		this.m.Icon = "ui/perks/rf_fresh_and_furious.png";
		this.m.IconMini = "rf_fresh_and_furious_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.IsSpent || !this.isEnabled();
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		if (this.m.RequiresRecover)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorRed("Disabled until this character uses [Recover|Skill+recover]"))
			});
		}
		else
		{
			tooltip.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("The next non-free skill used has its [Action Point|Concept.ActionPoints] cost " + ::MSU.Text.colorGreen("halved"))
			});
		}

		tooltip.push({
			id = 12,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Becomes disabled when starting a turn with " + ::MSU.Text.colorizeFraction(this.m.FatigueThreshold) + " or more [Fatigue|Concept.Fatigue] built")
		});

		return tooltip;
	}

	function isEnabled()
	{
		return this.getContainer().getActor().getFatigue() < this.m.FatigueThreshold * this.getContainer().getActor().getFatigueMax();
	}

	function onAfterUpdate( _properties )
	{
		if (!this.m.IsSpent && !this.m.RequiresRecover)
		{
			foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
			{
				// ::Math.round to round up the subtraction because we want to emulate the behavior of _properties.IsSkillUseHalfCost
				// whereby it rounds down the cost (due to integer division) after halving it.
				skill.m.ActionPointCost -= ::Math.max(0, ::Math.min(skill.m.ActionPointCost - 1, ::Math.round(skill.m.ActionPointCost / 2.0)));
			}
		}
	}

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

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		// Sometimes you use a non-free skill which uses a free skill inside its onUse function
		// In this case, we want to ensure that if IsUsingFreeSkill is false, we don't set it to true
		if (!this.m.IsUsingFreeSkill) return;
		this.m.IsUsingFreeSkill = _forFree || (_skill.getActionPointCost() == 0 && _skill.getFatigueCost() == 0);
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.IsSpent = !this.m.IsUsingFreeSkill;

		if (_skill.getID() == "actives.recover")
			this.m.RequiresRecover = false;
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;

		if (this.isEnabled())
		{
			this.m.Icon = ::Const.Perks.findById(this.getID()).Icon;
		}
		else
		{
			this.m.RequiresRecover = true;
			this.m.Icon = ::Const.Perks.findById(this.getID()).IconDisabled;
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsSpent = true;
		this.m.RequiresRecover = false;
	}
});
