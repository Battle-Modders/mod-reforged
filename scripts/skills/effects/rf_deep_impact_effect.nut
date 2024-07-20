this.rf_deep_impact_effect <- ::inherit("scripts/skills/skill", {
	m = {
		DamageTotalMult = 1.0, // Needs to be set externally when the effect is added
		DamageTotalMultMin = 0.5
	},
	function create()
	{
		this.m.ID = "effects.rf_deep_impact";
		this.m.Name = "Deep Impact";
		this.m.Description = "This character has received a very heavy blow, significantly reducing their combat effectiveness.";
		this.m.Icon = "ui/perks/rf_deep_impact.png";
		this.m.Overlay = "rf_deep_impact_effect";
		this.m.IconMini = "rf_deep_impact_mini";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function setDamageTotalMult( _d )
	{
		this.m.DamageTotalMult = ::Math.maxf(this.m.DamageTotalMultMin, _d);
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		if (this.getContainer().getActor().getID() == ::MSU.getDummyPlayer().getID())
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::Reforged.Mod.Tooltips.parseString("Damage dealt is reduced by a percentage equal to the ratio of the [Hitpoints|Concept.Hitpoints] damage received to current [Hitpoints,|Concept.Hitpoints] up to a maximum of " + ::MSU.Text.colorizeMult(this.m.DamageTotalMultMin))
			});
		}
		else
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::MSU.Text.colorizeMult(::Math.round(this.m.DamageTotalMult * 100) / 100.0) + " less Damage dealt "
			});
		}

		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= this.m.DamageTotalMult;
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}
});
