this.rf_grave_chill_effect <- ::inherit("scripts/skills/skill", {
	m = {
		MaxTurns = 2,
		TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.rf_grave_chill";
		this.m.Name = "Grave Chill";
		this.m.Description = "This character feels a chill running up their spine, making it very hard to take any physical action.";
		this.m.Icon = "skills/rf_grave_chill_effect.png";
		this.m.IconMini = "rf_grave_chill_effect_mini";
		this.m.Overlay = "rf_grave_chill_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		local mult = this.getMalusMult();
		if (mult != 1.0)
		{
			local actor = this.getContainer().getActor();
			if (::MSU.isEqual(actor, ::MSU.getDummyPlayer()))
			{
				ret.extend([
					{
						id = 10,
						type = "text",
						icon = "ui/icons/melee_skill.png",
						text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(mult) + " [Melee Skill|Concept.MeleeSkill]")
					},
					{
						id = 11,
						type = "text",
						icon = "ui/icons/melee_skill.png",
						text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(mult) + " [Melee Defense|Concept.MeleeDefense]")
					},
					{
						id = 12,
						type = "text",
						icon = "ui/icons/melee_skill.png",
						text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(mult) + " [Ranged Skill|Concept.RangeSkill]")
					},
					{
						id = 13,
						type = "text",
						icon = "ui/icons/melee_skill.png",
						text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(mult) + " [Ranged Defense|Concept.RangeDefense]")
					}
				]);
			}
			else
			{
				local p = actor.getCurrentProperties();
				local mskill = p.getMeleeSkill();
				local mdef = p.getMeleeDefense();
				local rskill = p.getRangedSkill();
				local rdef = p.getRangedDefense();
				ret.extend([
					{
						id = 10,
						type = "text",
						icon = "ui/icons/melee_skill.png",
						text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(mskill - mskill / mult, {AddSign = true}) + " [Melee Skill|Concept.MeleeSkill]")
					},
					{
						id = 11,
						type = "text",
						icon = "ui/icons/melee_skill.png",
						text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(mdef - mdef / mult) + " [Melee Defense|Concept.MeleeDefense]")
					},
					{
						id = 12,
						type = "text",
						icon = "ui/icons/melee_skill.png",
						text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(rskill - rskill / mult) + " [Ranged Skill|Concept.RangeSkill]")
					},
					{
						id = 13,
						type = "text",
						icon = "ui/icons/melee_skill.png",
						text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(rdef - rdef / mult) + " [Ranged Defense|Concept.RangeDefense]")
					}
				]);
			}
		}

		local moveAP = this.getMovementAPCostAdditional();
		if (moveAP != 0)
		{
			ret.push({
				id = 14,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(moveAP, {AddSign = true, InvertColor = true}) + " [Action Points|Concept.ActionPoints] per tile moved")
			});
		}

		ret.push({
			id = 15,
			type = "text",
			icon = "ui/icons/damage_regular.png",
			text = ::Reforged.Mod.Tooltips.parseString("This effect reduces in intensity with each passing [turn|Concept.Turn]")
		});

		return ret;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		local statusResisted = actor.getCurrentProperties().IsResistantToAnyStatuses ? ::Math.rand(1, 100) <= 50 : false;
		statusResisted = statusResisted || actor.getCurrentProperties().IsResistantToPhysicalStatuses ? ::Math.rand(1, 100) <= 33 : false;

		if (statusResisted)
		{
			if (!actor.isHiddenToPlayer())
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " resists being chilled thanks to his unnatural physiology");
			}

			this.removeSelf();
		}
		else
		{
			this.m.TurnsLeft = ::Math.max(1, this.m.MaxTurns + actor.getCurrentProperties().NegativeStatusEffectDuration);
		}
	}

	function onRefresh()
	{
		this.m.TurnsLeft = ::Math.max(this.m.TurnsLeft, this.m.MaxTurns + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
	}

	function onUpdate( _properties )
	{
		local mult = this.getMalusMult();
		_properties.MeleeSkill *= mult;
		_properties.MeleeDefense *= mult;
		_properties.RangedSkill *= mult;
		_properties.RangedDefense *= mult;
		_properties.MovementAPCostAdditional += this.getMovementAPCostAdditional();
	}

	function onTurnStart()
	{
		if (--this.m.TurnsLeft)
		{
			this.removeSelf();
		}
	}

	function getMalusMult()
	{
		return 1.0 - this.m.TurnsLeft * 0.15;
	}

	function getMovementAPCostAdditional()
	{
		return this.m.TurnsLeft;
	}
});
