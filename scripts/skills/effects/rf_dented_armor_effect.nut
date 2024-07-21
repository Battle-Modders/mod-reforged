this.rf_dented_armor_effect <- ::inherit("scripts/skills/skill", {
	m = {
		MeleeSkillMult = 0.9,
		RangedSkillMult = 0.9,
		DamageTotalMult = 0.8
	},
	function create()
	{
		this.m.ID = "effects.rf_dented_armor";
		this.m.Name = "Dented Armor";
		this.m.Description = "This character\'s armor has been dented severely, restricting mobility.";
		this.m.Icon = "ui/perks/perk_rf_dent_armor.png";
		this.m.IconMini = "rf_dented_armor_effect_mini";
		this.m.Overlay = "rf_dented_armor_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		if (this.m.MeleeSkillMult != 1.0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(this.m.MeleeSkillMult) + " less [Melee Skill|Concept.MeleeSkill]")
			});
		}

		if (this.m.RangedSkillMult != 1.0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(this.m.RangedSkillMult) + " less [Ranged Skill|Concept.RangeSkill]")
			});
		}

		if (this.m.DamageTotalMult != 1.0)
		{
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(this.m.DamageTotalMult) + " less damage dealt")
			});
		}

		return ret;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_adjust_dented_armor_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_adjust_dented_armor");
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkillMult *= this.m.MeleeSkillMult;
		_properties.RangedSkillMult *= this.m.RangedSkillMult;
		_properties.DamageTotalMult *= this.m.DamageTotalMult;
	}
});
