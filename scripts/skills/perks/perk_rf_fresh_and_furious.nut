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
		this.m.Icon = "ui/perks/rf_fresh_and_furious.png";
		this.m.IconMini = "rf_fresh_and_furious_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;

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

		// For non-dummy actor we also add the actual fatigue value calculated from the threshold
		if (this.getContainer().getActor().getID() == ::MSU.getDummyPlayer().getID())
		{
			tooltip.push({
				id = 12,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString("Becomes disabled when starting a turn with " + ::MSU.Text.colorizeFraction(this.m.FatigueThreshold, {InvertColor = true}) + " or more [Fatigue|Concept.Fatigue] built")
			});
		}
		else
		{
			tooltip.push({
				id = 12,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("Becomes disabled when starting a turn with %s (%s) or more [Fatigue|Concept.Fatigue] built", ::MSU.Text.colorizeFraction(this.m.FatigueThreshold, {InvertColor = true}), ::MSU.Text.colorRed(::Math.round(this.m.FatigueThreshold * this.getContainer().getActor().getFatigue()))))
			});
		}

		return tooltip;
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
		// Sometimes you use a non-free skill which uses a free skill inside its onUse function
		// In this case, we want to ensure that if IsUsingFreeSkill is false, we don't set it to true
		if (!this.m.IsUsingFreeSkill) return;
		this.m.IsUsingFreeSkill = _forFree || _skill.getActionPointCost() == 0;
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
