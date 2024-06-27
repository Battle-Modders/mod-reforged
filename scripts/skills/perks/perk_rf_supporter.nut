this.perk_rf_supporter <- this.inherit("scripts/skills/skill", {
	m = {
		// Config
		MinDistanceAPRecovery = 1,
		ActionPointsRecovered = 2,

		// Private
		IsSpent = false,
		WillRecoverActionPoints = false // conditionally flipped in onBeforeAnySkillExecuted to recover AP in onAnySkillExecuted
	},

	function create()
	{
		this.m.ID = "perk.rf_supporter";
		this.m.Name = ::Const.Strings.PerkName.RF_Supporter;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Supporter;
		this.m.Icon = "ui/perks/rf_supporter.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_encourage_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_encourage");
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

// MSU Functions
	// Implement Action Point recovery after using a skill on adjacent allies
	// We measure the tile distance in onBeforeAnySkillExecuted because some skills e.g. Rotation
	// may cause the actor to not be placed on map, causing tile distance to crash during onAnySkillExecuted.
	// We then recover the AP in onAnySkillExecuted so the AP is recovered after spending AP on skill use.
	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.m.IsSpent || _targetEntity == null)
			return;

		local actor = this.getContainer().getActor();
		if (actor.getFaction() != _targetEntity.getFaction() || actor.getID() == _targetEntity.getID() || !actor.isPlacedOnMap() || actor.getTile().getDistanceTo(_targetTile) > this.m.MinDistanceAPRecovery)
			return;

		this.m.WillRecoverActionPoints = true;
		this.m.IsSpent = true;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.m.WillRecoverActionPoints)
		{
			this.m.WillRecoverActionPoints = false;

			local actor = this.getContainer().getActor();
			local recoveredActionPoints = ::Math.min(actor.getActionPointsMax() - actor.getActionPoints(), this.m.ActionPointsRecovered);
			actor.setActionPoints(actor.getActionPoints() + recoveredActionPoints);
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " recovers " + ::MSU.Text.colorGreen(recoveredActionPoints) + " Action Point(s)");
		}
	}
});
