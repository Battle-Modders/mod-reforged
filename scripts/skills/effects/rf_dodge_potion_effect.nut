this.rf_dodge_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {
		MeleeDefenseAdd = 5,
		RangedDefenseAdd = 10
	},
	function create()
	{
		this.m.ID = "effects.rf_dodge_potion";
		this.m.Name = "Phantom Draught";
		this.m.Description = "Thanks to a draught prepared with the essence of spirits, this character finds it easier to quickly move out of the way of incoming strikes."
		this.m.Icon = "skills/rf_dodge_potion_effect.png";
		this.m.IconMini = "rf_dodge_potion_effect_mini";
		this.m.Overlay = "rf_dodge_potion_effect";
		this.m.Type = ::Const.SkillType.StatusEffect | ::Const.SkillType.DrugEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsSerialized = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		if (this.m.MeleeDefenseAdd != 0)
		{
			ret.push({
				id = 11,	type = "text",	icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.MeleeDefenseAdd, {AddSign = true}) + " [Melee Defense|Concept.MeleeDefense]")
			});
		}
		if (this.m.MeleeDefenseAdd != 0)
		{
			ret.push({
				id = 12,	type = "text",	icon = "ui/icons/ranged_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.RangedDefenseAdd, {AddSign = true}) + " [Ranged Defense|Concept.RangeDefense]")
			});
		}
		ret.push({
			id = 7,	type = "hint",	icon = "ui/icons/action_points.png",
			text = "Will be gone after 1 more battle"
		});

		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += this.m.MeleeDefenseAdd;
		_properties.RangedDefense += this.m.RangedDefenseAdd;
	}
});
