this.perk_rf_combo <- ::inherit("scripts/skills/skill", {
	m = {
		UsedSkillID = "",
		UsedSkillName = "",
		IsUsingValidSkill = false // Set during onBeforeAnySkillExecuted to check if during onAnySkillExecuted we should activate the perk's effect
	},
	function create()
	{
		this.m.ID = "perk.rf_combo";
		this.m.Name = ::Const.Strings.PerkName.RF_Combo;
		this.m.Description = "The good old one-two!";
		this.m.Icon = "ui/perks/rf_combo.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Any;
	}

	function isHidden()
	{
		return this.m.UsedSkillID == "";
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = ::Reforged.Mod.Tooltips.parseString("The [Action Point|Concept.ActionPointCost] cost of all skills except " + this.m.UsedSkillName + " is reduced by " + ::MSU.Text.colorPositive("1"))
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will expire upon using [Wait|Concept.Wait] or ending your [turn|Concept.Turn]")
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
		if (this.m.IsUsingValidSkill)
		{
			this.m.UsedSkillID = _skill.getID();
			this.m.UsedSkillName = _skill.getName();
		}
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local usedSkillID = this.m.UsedSkillID;
		if (actor.isPreviewing() && actor.getPreviewSkill() != null)
		{
			usedSkillID = actor.getPreviewSkill().getID();
		}

		if (usedSkillID != "")
		{
			foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
			{
				if (skill.getID() != usedSkillID && skill.m.ActionPointCost > 3)
				{
					skill.m.ActionPointCost -= 1;
				}
			}
		}
	}

	function onWaitTurn()
	{
		this.m.UsedSkillID = "";
	}

	function onTurnEnd()
	{
		this.m.UsedSkillID = "";
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.UsedSkillID = "";
	}
});
