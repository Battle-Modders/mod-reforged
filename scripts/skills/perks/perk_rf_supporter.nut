this.perk_rf_supporter <- this.inherit("scripts/skills/skill", {
	m = {
		// Config
		MinDistanceAPRecovery = 1,
		ActionPointsRecovered = 2,

		// Private
		IsSpent = false
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
	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.m.IsSpent || _targetEntity == null)
		{
			return;
		}

		local actor = this.getContainer().getActor();
		if (actor.getFaction() == _targetEntity.getFaction() && actor.getID() != _targetEntity.getID())
		{
			if (actor.getTile().getDistanceTo(_targetTile) <= this.m.MinDistanceAPRecovery)
			{
				local recoveredActionPoints = ::Math.min(actor.getActionPointsMax() - actor.getActionPoints(), this.m.ActionPointsRecovered);
				if (recoveredActionPoints != 0)
				{
					actor.setActionPoints(actor.getActionPoints() + recoveredActionPoints);
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " recovers " + ::MSU.Text.colorGreen(recoveredActionPoints) + " Action Point(s)");
				}

				this.m.IsSpent = true;
			}
		}
	}
});
