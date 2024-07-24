this.rf_worn_down_effect <- ::inherit("scripts/skills/skill", {
	m = {
		FatigueCostMult = 1.1,
		InitiativeMult = 0.9
	},
	function create()
	{
		this.m.ID = "effects.rf_worn_down";
		this.m.Name = "Worn Down";
		this.m.Description = "This character is feeling worn down after reciving rather tiring attacks.";
		this.m.Icon = "ui/perks/perk_rf_wear_them_down.png";
		this.m.IconMini = "rf_worn_down_effect_mini";
		this.m.Overlay = "rf_worn_down_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(this.m.FatigueCostMult, {InvertColor = true}) + " more [Fatigue|Concept.Fatigue] built")
		});

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(this.m.InitiativeMult) + " less [Initiative|Concept.Initiative]")
		});

		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.FatigueEffectMult *= this.m.FatigueCostMult;
		_properties.InitiativeMult *= this.m.InitiativeMult;
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}
});
