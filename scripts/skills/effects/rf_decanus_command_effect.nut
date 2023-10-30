this.rf_decanus_command_effect <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.rf_decanus_command";
		this.m.Name = "Decanus Command";
		this.m.Description = "This character is in the presence of a Decanus.";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Icon = "skills/rf_decanus_command_effect.png";
		this.m.IconMini = "rf_decanus_command_effect_mini";
		this.m.IsSerialized = false;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = ::Reforged.Mod.Tooltips.parseString("Can use [Shieldwall|Skill+shieldwall] for 0 [Action Points|Concept.ActionPoints]")
		});

		return tooltip;
	}

	function onAfterUpdate( _properties )
	{
		this.m.IsHidden = true;

		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap())
			return;

		local shieldwall = this.getContainer().getSkillByID("actives.shieldwall");
		if (shieldwall == null)
			return;

		local myTile = actor.getTile();
		foreach (ally in ::Tactical.Entities.getAlliedActors(actor.getFaction(), myTile, 4))
		{
			if (ally.getSkills().hasSkill("perk.rf_decanus"))
			{
				this.m.IsHidden = false;
				shieldwall.m.ActionPointCost = 0;
				break;
			}
		}
	}
});
