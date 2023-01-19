this.rf_hold_steady_effect <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.rf_hold_steady";
		this.m.Name = "Holding Steady";
		this.m.Description = "This character is holding his ground against the enemy's onslaught.";
		this.m.Icon = "ui/perks/rf_steady_formation.png";
		this.m.IconMini = "rf_steady_formation_effect_mini";
		this.m.Overlay = "rf_steady_formation_effect";
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

