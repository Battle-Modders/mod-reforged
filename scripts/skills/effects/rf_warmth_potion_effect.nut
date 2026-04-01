this.rf_warmth_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {
		ActionPointsAdd = 1
	},
	function create()
	{
		this.m.ID = "effects.rf_warmth_potion";
		this.m.Name = "Fireblood Tonic";
		this.m.Description = "Energy radiates from the within this character thanks to having ingested a fiery concoction.";
		this.m.Icon = "skills/rf_warmth_potion_effect.png";
		this.m.IconMini = "rf_warmth_potion_effect_mini";
		this.m.Overlay = "rf_warmth_potion_effect";
		this.m.Type = ::Const.SkillType.StatusEffect | ::Const.SkillType.DrugEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsSerialized = true;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		if (this.m.ActionPointsAdd != 0)
		{
			ret.push({
				id = 11,	type = "text",	icon = "ui/icons/action_points.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.ActionPointsAdd, {AddSign = true}) + " [Action Points|Concept.ActionPoints]")
			});
		}

		ret.push({
			id = 12,	type = "text",	icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Immune to natural and unnatural cold effects like [$ $|Skill+chilled_effect] and [$ $|Skill+rf_numbness_effect]")
		});

		ret.push({
			id = 7,	type = "hint",	icon = "ui/icons/action_points.png",
			text = "Will be gone after 1 more battle"
		});

		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.ActionPoints += this.m.ActionPointsAdd;
	}
});
