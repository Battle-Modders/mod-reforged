this.rf_hold_steady_effect <- ::inherit("scripts/skills/skill", {
	m = {
		RoundsLeft = 2,
		DefenseAdd = 10,
		BraveryAdd = 10
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

		if (this.m.DefenseAdd != 0)
		{
			ret.extend([
				{
					id = 10,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.DefenseAdd, {AddSign = true}) + " [Melee Defense|Concept.MeleeDefense]")
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.DefenseAdd, {AddSign = true}) + " [Ranged Defense|Concept.RangeDefense]")
				}
			]);
		}

		if (this.m.BraveryAdd != 0)
		{
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.BraveryAdd, {AddSign = true}) + " [Resolve|Concept.Bravery]")
			});
		}

		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Immune to being [Stunned|Skill+stunned_effect], Knocked Back or Grabbed")
		});

		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will expire in " + this.m.RoundsLeft + " [round(s)|Concept.Round]")
		});
		
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += this.m.DefenseAdd;
		_properties.RangedDefense += this.m.DefenseAdd;
		_properties.Bravery += this.m.BraveryAdd;
		_properties.IsImmuneToStun = true;
		_properties.IsImmuneToKnockBackAndGrab = true;
	}

	function onRoundEnd()
	{
		if (--this.m.RoundsLeft == 0) this.removeSelf();
	}
});
