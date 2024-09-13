this.rf_hold_steady_effect <- ::inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1
	},
	function create()
	{
		this.m.ID = "effects.rf_hold_steady";
		this.m.Name = "Holding Steady";
		this.m.Description = "This character is holding his ground against the enemy's onslaught.";
		this.m.Icon = "ui/perks/perk_rf_hold_steady.png";
		this.m.IconMini = "rf_hold_steady_effect_mini";
		this.m.Overlay = "rf_hold_steady_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(10, {AddSign = true}) + " [Melee Defense|Concept.MeleeDefense]")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(10, {AddSign = true}) + " [Ranged Defense|Concept.RangeDefense]")
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Immune to being [Stunned|Skill+stunned_effect], Knocked Back or Grabbed")
			}
		]);
		
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += 10;
		_properties.RangedDefense += 10;
		_properties.IsImmuneToStun = true;
		_properties.IsImmuneToKnockBackAndGrab = true;
	}

	function onTurnStart()
	{
		if (--this.m.TurnsLeft == 0) this.removeSelf();
	}
});
