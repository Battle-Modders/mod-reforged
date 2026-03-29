this.rf_banshee_potion_effect <- ::inherit("scripts/skills/effects/rf_anatomist_potion_effect", {
	m = {
		RerollMoraleChance = 50
	},
	function create()
	{
		this.rf_anatomist_potion_effect.create();
		this.m.ID = "effects.rf_banshee_potion";
		this.m.Name = "Serene Mind";
		// Text generated and edited by LordMidas using Gemini
		this.m.Description = "This character\'s humors are exceptionally stable allowing the mind to reflexively resist fear or grief while being highly attuned to positive emotions. Occasionally, they are observed tilting their head in a vacant trance captivated by a faint ringing in their skull.";
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
