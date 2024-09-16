this.perk_rf_fresh_and_furious <- ::inherit("scripts/skills/skill", {
	m = {
		IsUsingFreeSkill = false,
		IsSpent = true,
		RequiresRecover = false,
		FatigueThreshold = 0.3
		IconMiniBackup = ""
	},
	function create()
	{
		this.m.ID = "perk.rf_fresh_and_furious";
		this.m.Name = ::Const.Strings.PerkName.RF_FreshAndFurious;
		this.m.Description = "This character is exceptionally fast when not fatigued.";
		this.m.Icon = "ui/perks/perk_rf_fresh_and_furious.png";
		this.m.IconMini = "perk_rf_fresh_and_furious_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Any;

		this.m.IconMiniBackup = this.m.IconMini;
	}

	function isHidden()
	{
		return this.m.IsSpent;
	}

	function getName()
	{
		return this.m.RequiresRecover ? this.m.Name + " (Disabled)" : this.m.Name;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		if (this.m.RequiresRecover)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Disabled until this character uses [Recover|Skill+recover]"))
			});
		}
		else
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("The next skill costing [Action Points|Concept.ActionPoints] has its [Action Point|Concept.ActionPoints] cost " + ::MSU.Text.colorPositive("halved"))
			});
		}

		// For non-dummy actor we also add the actual fatigue value calculated from the threshold
		if (this.getContainer().getActor().getID() == ::MSU.getDummyPlayer().getID())
		{
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString("Becomes disabled when starting a turn with " + ::MSU.Text.colorizePct(this.m.FatigueThreshold, {InvertColor = true}) + " or more [Fatigue|Concept.Fatigue] built")
			});
		}
		else
		{
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("Becomes disabled when starting a turn with %s (%s) or more [Fatigue|Concept.Fatigue] built", ::MSU.Text.colorizePct(this.m.FatigueThreshold, {InvertColor = true}), ::MSU.Text.colorNegative(::Math.round(this.m.FatigueThreshold * this.getContainer().getActor().getFatigue()))))
			});
		}

		return ret;
	}

	function onAfterUpdate( _properties )
	{
		if (this.m.IsSpent || this.m.RequiresRecover)
			return;

		local actor = this.getContainer().getActor();
		if (!actor.isPreviewing() || actor.getPreviewMovement() != null || actor.getPreviewSkill().getActionPointCost() == 0)
		{
			foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
			{
				if (skill.m.ActionPointCost > 1)
					skill.m.ActionPointCost /= 2;
			}
		}
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		// Sometimes you use a _forFree skill inside the use of a skill that costs AP
		// In that case we don't want to change the value for IsUsingFreeSkill that
		// has already been set by the originally used skill.
		if (_forFree)
			return;

		this.m.IsUsingFreeSkill = _skill.getActionPointCost() == 0;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (!this.m.IsUsingFreeSkill)
			this.m.IsSpent = true;

		if (_skill.getID() == "actives.recover")
			this.m.RequiresRecover = false;
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;

		if (this.getContainer().getActor().getFatigue() < this.m.FatigueThreshold * this.getContainer().getActor().getFatigueMax())
		{
			this.m.Icon = ::Const.Perks.findById(this.getID()).Icon;
			this.m.IconMini = this.m.IconMiniBackup;
		}
		else
		{
			this.m.RequiresRecover = true;
			this.m.Icon = ::Const.Perks.findById(this.getID()).IconDisabled;
			this.m.IconMini = "";
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsSpent = true;
		this.m.RequiresRecover = false;
	}
});
