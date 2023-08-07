this.rf_under_cover_effect <- ::inherit("scripts/skills/skill", {
	m = {
		RangedDefenseBonus = 10,
		CoveringAlly = null
	},
	function create()
	{
		this.m.ID = "effects.rf_under_cover";
		this.m.Name = "Under Cover";
		this.m.Description = "This character is currently hiding next to an ally from enemy ranged attacks. This effect is removed when they wait or end their turn engaged in melee or not adjacent to that ally.";
		this.m.Icon = "ui/perks/rf_phalanx.png";
		this.m.IconMini = "";	// Todo, add mini icon for better visibility
		this.m.Overlay = "active_15";	// For now we use the same overlay icon as ShieldWall has.
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function init( _coveringAlly, _rangedDefenseBonus = 10 )
	{
		this.m.CoveringAlly = ::MSU.asWeakTableRef(_coveringAlly);
		this.m.RangedDefenseBonus = _rangedDefenseBonus;
		return this;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = ::MSU.Text.colorizeValue(this.m.RangedDefenseBonus) + " Ranged Defense"
		});

		if (this.m.CoveringAlly != null)
		{
			tooltip.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Covered by: " + this.m.CoveringAlly.getName()
			});
		}

		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.RangedDefense += this.m.RangedDefenseBonus;
	}

	function onWaitTurn()
	{
		local actor = this.getContainer().getActor();
		if (this.m.CoveringAlly == null || actor.isEngagedInMelee() || (actor.getTile().getDistanceTo(this.m.CoveringAlly.getTile()) > 1))
		{
			this.removeSelf();
		}
	}

	function onTurnEnd()
	{
		local actor = this.getContainer().getActor();
		if (this.m.CoveringAlly == null || actor.isEngagedInMelee() || (actor.getTile().getDistanceTo(this.m.CoveringAlly.getTile()) > 1))
		{
			this.removeSelf();
		}
	}
});
