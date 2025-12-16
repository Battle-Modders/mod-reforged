this.rf_draugr_restless_effect <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.rf_draugr_restless";
		this.m.Name = "Restless";
		this.m.Description = "This Barrowkin has become restless, moving faster and striking with relentless fury.";
		this.m.Icon = "skills/rf_draugr_restless_effect.png";
		// this.m.IconMini = "rf_draugr_restless_effect_mini";
		this.m.Overlay = "rf_draugr_restless_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		local mult = this.getMeleeSkillMult();

		if (mult != 1.0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(mult) + " [Melee Skill|Concept.MeleeSkill]")
			});
		}

		mult = this.getInitiativeMult();
		if (mult != 1.0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(mult) + " [Initiative|Concept.Initiative]")
			});
		}

		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Gain [$ $|Perk+perk_overwhelm]")
		});

		return ret;
	}

	function onAdded()
	{
		this.getContainer().add(::Reforged.new("scripts/skills/perks/perk_overwhelm", function(o) {
			o.m.IsSerialized = false;
			o.m.IsRefundable = false;
		}));
	}

	function onRemoved()
	{
		this.getContainer().removeByIDByStack("perk.overwhelm", false);
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkillMult *= this.getMeleeSkillMult();
		_properties.InitiativeMult *= this.getInitiativeMult();
	}

	function getMeleeSkillMult()
	{
		return 1.1;
	}

	function getInitiativeMult()
	{
		return 1.5;
	}
});
