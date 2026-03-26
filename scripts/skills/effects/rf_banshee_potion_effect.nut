this.rf_banshee_potion_effect <- ::inherit("scripts/skills/effects/rf_anatomist_potion_effect", {
	m = {
		RerollMoraleChance = 50
	},
	function create()
	{
		this.rf_anatomist_potion_effect.create();
		this.m.ID = "effects.rf_banshee_potion";
		this.m.Name = "Serene Mind";
		this.m.Description = "This character\'s mind has been mutated, making them far more resistant against negative emotions while strengthening positive ones.";
		this.m.Icon = "skills/rf_banshee_potion_effect.png";
		this.m.Overlay = "rf_banshee_potion_effect";
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.RerollMoraleChance, {AddSign = true, AddPercent = true}) + " chance to reroll failed [morale checks|Concept.Morale]")
			}
		]);
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.RerollMoraleChance += 50;
	}
});
