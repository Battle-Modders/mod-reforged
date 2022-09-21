this.rf_hold_the_line_effect <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.rf_hold_the_line";
		this.m.Name = "Pushing Forward";
		this.m.Description = "This character is holding his ground against the enemy's onslaught.";
		this.m.Icon = "ui/perks/rf_hold_the_line.png";
		this.m.IconMini = "rf_hold_the_line_effect_mini";
		this.m.Overlay = "rf_hold_the_line_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
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
				text = ::MSU.Text.colorizeValue(10) + " Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::MSU.Text.colorizeValue(10) + " Ranged Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to being Stunned, Knocked Back or Grabbed"
			}
		]);
		
		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += 10;
		_properties.RangedDefense += 10;
		_properties.IsImmuneToStun = true;
		_properties.IsImmuneToKnockBackAndGrab = true;
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}
});

