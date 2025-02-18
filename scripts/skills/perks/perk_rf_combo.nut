this.perk_rf_combo <- ::inherit("scripts/skills/skill", {
	m = {
		ActionPointCostModifier = -1,
		ActionPointCostMin = 3,
		IsInEffect = false,
		IsUsingValidSkill = false // Set during onBeforeAnySkillExecuted to check if during onAnySkillExecuted we should activate the perk's effect
	},
	function create()
	{
		this.m.ID = "perk.rf_combo";
		this.m.Name = ::Const.Strings.PerkName.RF_Combo;
		this.m.Description = "The good old one-two!";
		this.m.Icon = "ui/perks/perk_rf_combo.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isHidden()
	{
		return !this.m.IsInEffect;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		local minimumString = this.m.ActionPointCostMin == 0 ? "" : " to a minimum of " + this.m.ActionPointCostMin;
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = ::Reforged.Mod.Tooltips.parseString(format("Skills cost %s [Action Point(s)|Concept.ActionPoints]%s", ::MSU.Text.colorizeValue(this.m.ActionPointCostModifier, {InvertColor = true, AddSign = true}), minimumString))
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will expire upon using a skill [waiting|Concept.Wait] or ending your [turn|Concept.Turn]")
		});
		return ret;
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		// We do this in onBeforeAnySkillExecuted because some skills remove themselves after executing them
		// or some other effects may be triggered which may change the skill's ActionPointCost after execution
		// and in both these cases getActionPointCost() will not give us the intended value in onAnySkillExecuted
		this.m.IsUsingValidSkill = !_forFree && _skill.getActionPointCost() != 0;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.m.IsInEffect)
		{
			this.m.IsInEffect = false;
		}
		else if (this.m.IsUsingValidSkill)
		{
			this.m.IsInEffect = true;
		}
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local applyEffect = this.m.IsInEffect;

		// When previewing a skill while already in effect, we want to show the effect will be lost
		// If not already in effect, we want to show that the effect will be available after the previewed skill is used
		if (actor.isPreviewing() && actor.getPreviewSkill() != null)
		{
			applyEffect = !this.m.IsInEffect && actor.getPreviewSkill().getActionPointCost() != 0;
		}

		if (applyEffect)
		{
			foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
			{
				if (skill.m.ActionPointCost > this.m.ActionPointCostMin)
				{
					skill.m.ActionPointCost += this.m.ActionPointCostModifier;
				}
			}
		}
	}

	function onWaitTurn()
	{
		this.m.IsInEffect = false;
	}

	function onTurnEnd()
	{
		this.m.IsInEffect = false;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsInEffect = false;
	}
});
