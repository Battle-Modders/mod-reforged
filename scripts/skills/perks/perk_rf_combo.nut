this.perk_rf_combo <- ::inherit("scripts/skills/skill", {
	m = {
		UsedSkillID = "",
		UsedSkillName = ""
	},
	function create()
	{
		this.m.ID = "perk.rf_combo";
		this.m.Name = ::Const.Strings.PerkName.RF_Combo;
		this.m.Description = "The good old one-two!";
		this.m.Icon = "ui/perks/rf_combo.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
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
			text = ::Reforged.Mod.Tooltips.parseString("The [Action Point|Concept.ActionPointCost] cost of all skills except " + this.m.UsedSkillName + " is reduced by " + ::MSU.Text.colorGreen("1"))
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will expire upon using Wait or ending your [turn|Concept.Turn]")
		});
		return ret;
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (!_forFree && _skill.getActionPointCost() != 0)
		{
			this.m.UsedSkillID = _skill.getID();
			this.m.UsedSkillName = _skill.getName();
		}
	}

	function onAfterUpdate( _properties )
	{
		if (this.m.UsedSkillID == "")
			return;

		foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
		{
			if (skill.getID() != this.m.UsedSkillID && skill.m.ActionPointCost > 3)
			{
				skill.m.ActionPointCost -= 1;
			}
		}
	}

	function onAfterUpdatePreview( _properties, _previewedSkill, _previewedMovement )
	{
		local usedSkillID = "";
		if (_previewedMovement != null)
		{
			usedSkillID = this.m.UsedSkillID;
		}
		else if (_previewedSkill.getActionPointCost() != 0)
		{
			usedSkillID = _previewedSkill.getID();
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
