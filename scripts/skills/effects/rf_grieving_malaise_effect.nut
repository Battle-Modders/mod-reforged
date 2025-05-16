this.rf_grieving_malaise_effect <- ::inherit("scripts/skills/skill", {
	m = {
		RF_InitiativeMult = 0.5,
		RF_FatigueEffectMult = 1.2
	},
	function create()
	{
		this.m.ID = "effects.rf_grieving_malaise";
		this.m.Name = "Grieving Malaise";
		this.m.Description = "This character has been afflicted with feelings of deep-rooted agonizing grief.";
		this.m.Icon = "skills/rf_grieving_malaise_effect.png";
		this.m.IconMini = "rf_grieving_malaise_effect_mini";
		this.m.Overlay = "rf_grieving_malaise_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		local initiativeMult = this.RF_getInitiatveMult();
		if (initiativeMult != 1.0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(initiativeMult) + " [Initiative|Concept.Initiative]")
			});
		}

		local fatigueEffectMult = this.RF_getFatigueEffectMult();
		if (fatigueEffectMult != 1.0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Reforged.Mod.Tooltips.parseString("Build " + ::MSU.Text.colorizeMultWithText(fatigueEffectMult, {InvertColor = true}) + " [Fatigue|Concept.Fatigue]")
			});
		}

		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = ::Reforged.Mod.Tooltips.parseString("Has a chance to be removed at the start of every [turn|Concept.Turn] upon a successful [morale check|Concept.Morale]")
		});

		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.InitiativeMult *= this.RF_getInitiatveMult();
		_properties.FatigueEffectMult *= this.RF_getFatigueEffectMult();
	}

	function onTurnStart()
	{
		if (this.getContainer().getActor().checkMorale(0, ::Const.Morale.RallyBaseDifficulty))
		{
			this.removeSelf();
		}
	}

	function RF_getInitiatveMult()
	{
		return this.m.RF_InitiativeMult;
	}

	function RF_getFatigueEffectMult()
	{
		return this.m.RF_FatigueEffectMult;
	}
});
