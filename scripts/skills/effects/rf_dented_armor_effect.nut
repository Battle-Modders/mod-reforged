this.rf_dented_armor_effect <- ::inherit("scripts/skills/skill", {
	m = {
		ActionPointMalus = 2
	},
	function create()
	{
		this.m.ID = "effects.rf_dented_armor";
		this.m.Name = "Dented Armor";
		this.m.Description = "This character\'s armor has been dented severely, restricting mobility.";
		this.m.Icon = "ui/perks/rf_dent_armor.png";
		this.m.IconMini = "rf_dented_armor_effect_mini";
		this.m.Overlay = "rf_dented_armor_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = "[color=" + ::Const.UI.Color.NegativeValue + "]-" + this.m.ActionPointMalus + "[/color] Action Points"
		});

		return tooltip;
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
		_properties.ActionPoints -= 2;
	}
});
