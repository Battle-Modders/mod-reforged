this.rf_rattled_effect <- ::inherit("scripts/skills/skill", {
	m = {
		ReachModifier = -2
	},
	function create()
	{
		this.m.ID = "effects.rf_rattled";
		this.m.Name = "Rattled";
		this.m.Description = "This character has been rattled to the bones making it harder to fight effectively.";
		this.m.Icon = "ui/perks/perk_rf_rattle.png";
		this.m.IconMini = "rf_rattled_effect_mini";
		this.m.Overlay = "rf_rattled_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}
	
	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/reach.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.ReachModifier) + " [Reach|Concept.Reach]")
		});
		
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.Reach += this.m.ReachModifier;
	}
	
	function onTurnEnd()
	{
		this.removeSelf();
	}
});

