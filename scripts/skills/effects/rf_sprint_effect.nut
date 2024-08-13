this.rf_sprint_effect <- ::inherit("scripts/skills/skill", {
	m = {
		FatigueMult = 1.5
	},
	function create()
	{
		this.m.ID = "effects.rf_sprint";
		this.m.Name = "Sprinting";
		this.m.Description = "This character is running fast.";
		this.m.Icon = "skills/rf_sprint_effect.png";
		this.m.IconMini = "rf_sprint_effect_mini";
		this.m.Overlay = "rf_sprint_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive(-1) + " [Action Points|Concept.ActionPoints] spent per tile traveled")
		});

		if (this.m.FatigueMult != 1.0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(this.m.FatigueMult, {InvertColor = true, AddSign = true}) + " [Fatigue|Concept.Fatigue] built per tile traveled")
			});
		}

		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will expire upon using any skill or [waiting|Concept.Wait] or ending the [turn|Concept.Turn]")
		});

		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.MovementAPCostAdditional -= 1;
		_properties.MovementFatigueCostMult *= this.m.FatigueMult;
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.removeSelf();
	}

	function onWaitTurn()
	{
		this.removeSelf();
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}
});
