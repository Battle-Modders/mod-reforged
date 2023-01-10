this.rf_rattled_effect <- ::inherit("scripts/skills/skill", {
	m = {
		DefenseAdd = -10
	},
	function create()
	{
		this.m.ID = "effects.rf_rattled";
		this.m.Name = "Rattled";
		this.m.Description = "This character has been rattled to the bones making it harder to defend against further attacks.";
		this.m.Icon = "ui/perks/rf_rattle.png";
		this.m.IconMini = "rf_rattled_effect_mini";
		this.m.Overlay = "rf_rattled_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}
	
	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = ::MSU.Text.colorizeValue(this.m.DefenseAdd) + " Melee Defense"
		});
		
		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += this.m.DefenseAdd;
	}
	
	function onTurnEnd()
	{
		this.removeSelf();
	}
});

