this.rf_arrow_to_the_knee_debuff_effect <- ::inherit("scripts/skills/skill", {
	m = {
		StartingTurnsLeft = 2
		TurnsLeft = 2
		DefenseAdd = -5,
		MovementAPCostAdditional = 2
	},
	function create()
	{
		this.m.ID = "effects.rf_arrow_to_the_knee_debuff";
		this.m.Name = "Took an Arrow to the Knee";		
		this.m.Description = "This character used to move around freely like you, but then he took arrow to the knee.";
		this.m.Icon = "ui/perks/rf_arrow_to_the_knee.png";
		this.m.IconMini = "rf_arrow_to_the_knee_debuff_effect_mini";
		this.m.Overlay = "rf_arrow_to_the_knee_debuff_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::MSU.Text.colorRed(this.m.DefenseAdd) + " Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::MSU.Text.colorRed(this.m.DefenseAdd) + " Ranged Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = ::MSU.Text.colorRed(this.m.MovementAPCostAdditional) + " additional Action Points per tile moved"
			}
		]);

		return tooltip;
	}

	function onRefresh()
	{
		this.m.TurnsLeft = ::Math.max(1, this.m.StartingTurnsLeft + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += this.m.DefenseAdd;
		_properties.RangedDefense += this.m.DefenseAdd;
		_properties.MovementAPCostAdditional += this.m.MovementAPCostAdditional;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft == 0)
		{
			this.removeSelf();
		}
	}
});
