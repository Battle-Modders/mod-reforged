this.rf_rattled_effect <- ::inherit("scripts/skills/skill", {
	m = {
		Stacks = 1,
		DamageReductionPercentage = 10
	},
	function create()
	{
		this.m.ID = "effects.rf_rattled";
		this.m.Name = "Rattled";
		this.m.Description = "This character has been rattled to the bones which makes it harder to swing the weapon properly.";
		this.m.Icon = "ui/perks/rf_rattle.png";
		this.m.IconMini = "rf_rattled_effect_mini";
		this.m.Overlay = "rf_rattled_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getName()
	{
		return this.m.Stacks > 1 ? this.m.Name + " (x" + this.m.Stacks + ")" : this.m.Name;
	}
	
	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "[color=" + ::Const.UI.Color.NegativeValue + "]" + (this.m.Stacks * this.m.DamageReductionPercentage) + "%[/color] reduced damage inflicted"
		});
		
		return tooltip;
	}

	function onRefresh()
	{
		this.m.Stacks++;
	}

	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= 1.0 - (this.m.Stacks * this.m.DamageReductionPercentage * 0.01);
	}
	
	function onTurnEnd()
	{
		this.removeSelf();
	}
});

