this.perk_rf_ghostlike <- ::inherit("scripts/skills/skill", {
	m = {
		IsSpent = true
	},
	function create()
	{
		this.m.ID = "perk.rf_ghostlike";
		this.m.Name = ::Const.Strings.PerkName.RF_Ghostlike;
		this.m.Description = "Blink and you\'ll miss me.";
		this.m.Icon = "ui/perks/rf_ghostlike.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.IsSpent;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "The next movement will ignore Zone of Control"
		});

		return tooltip;
	}

	function onUpdate( _properties )
	{
		if (!this.m.IsSpent) _properties.IsImmuneToZoneOfControl = true;
	}

	function updateSpent()
	{
		local actor = this.getContainer().getActor();
		local numAllies = ::Tactical.Entities.getAlliedActors(actor, actor.getTile(), 1, true);
		local numEnemies = ::Tactical.Entities.getHostileActors(actor, actor.getTile(), 1, true);

		if (numAllies >= numEnemies)
		{
			this.m.IsSpent = false;
		}
	}

	function onTurnStart()
	{
		this.updateSpent();
	}

	function onResumeTurn()
	{
		this.updateSpent();
	}

	function onMovementFinished( _tile )
	{
		this.updateSpent();
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsSpent = true;
	}
});
