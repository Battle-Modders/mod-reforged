this.perk_rf_ghostlike <- ::inherit("scripts/skills/skill", {
	m = {
		IgnoresZOC = false
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
		return !this.m.IgnoresZOC;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The next movement will ignore [Zone of Control|Concept.ZoneOfControl]")
		});

		return tooltip;
	}

	function onUpdate( _properties )
	{
		if (this.m.IgnoresZOC) _properties.IsImmuneToZoneOfControl = true;
	}

	function updateSpent()
	{
		local actor = this.getContainer().getActor();
		local numAllies = ::Tactical.Entities.getAlliedActors(actor.getFaction(), actor.getTile(), 1, true).len();
		local numEnemies = ::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1, true).len();

		this.m.IgnoresZOC = numAllies >= numEnemies;
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
		this.m.IgnoresZOC = false;
	}
});
