this.rf_naked <- ::inherit("scripts/skills/skill", {
	m = {
		BraveryMult = 0.5,
		ExcludedBackgrounds = [ // Filenames instead of IDs
			"wildman_background",
			"barbarian_background"
		]
	},
	function create()
	{
		this.m.ID = "special.rf_naked";
		this.m.Name = "Naked";
		this.m.Description = "This character\'s private parts are fully exposed, making it a rather nervous situation to be in.";
		this.m.Icon = "skills/rf_naked.png";
		this.m.Type = ::Const.SkillType.Special | ::Const.SkillType.StatusEffect;
		this.m.IsSerialized = false;
	}

	function isHidden()
	{
		return !this.isEnabled();
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		if (this.m.BraveryMult != 1.0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMultWithText(this.m.BraveryMult) + " [Resolve|Concept.Bravery]" + (::Tactical.isActive() ? "" : " during battle"))
			});
		}

		if (this.m.ExcludedBackgrounds.len() != 0)
		{
			local excluded = this.m.ExcludedBackgrounds.map(function( _filename) {
				local obj = ::new("scripts/skills/backgrounds/" + _filename);
				return {
					id = 20,
					type = "text",
					icon = obj.getIconColored(),
					text = obj.m.Name
				};
			});

			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The following backgrounds are unaffected: ",
				children = excluded
			});
		}

		return ret;
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (this.m.ExcludedBackgrounds.find(_skill.ClassName) != null)
		{
			_tooltip.push({
				id = 100,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Suffers no penalties from " + ::Reforged.NestedTooltips.getNestedSkillName(this))
			});
		}
	}

	function onUpdate( _properties )
	{
		if (this.isEnabled() && ::Tactical.isActive())
		{
			_properties.BraveryMult *= this.m.BraveryMult;
		}
	}

	function isEnabled()
	{
		local actor = this.getContainer().getActor();

		if (!::MSU.isNull(actor.getBodyItem()))
			return false;

		if (::MSU.isKindOf(actor, "player"))
		{
			// Background can be null during deserialization of game, so we need a null check for that
			return !::MSU.isNull(actor.getBackground()) && this.m.ExcludedBackgrounds.find(actor.getBackground().ClassName) == null;
		}

		return true;
	}
});
