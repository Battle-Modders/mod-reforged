this.perk_rf_inspire <- this.inherit("scripts/skills/skill", {
	m = {
		// Config
		MinDistanceAPRecovery = 1,
		ActionPointsRecovered = 2,

		// Temp
		IsSpent = false,
	},

	function create()
	{
		this.m.ID = "perk.rf_inspire";
		this.m.Name = ::Const.Strings.PerkName.RF_Inspire;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Inspire;
		this.m.Icon = "ui/perks/rf_inspire.png";	// TODO
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		if (this.m.IsSpent) return true;

		return this.skill.isHidden();
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_inspire_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_inspire");
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

// MSU Functions
	// Implement Action Point recovery when targeting adjacent allies
	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.m.IsSpent) return;

		local actor = this.getContainer().getActor();
		if (actor.getFaction() == _targetEntity.getFaction())
		{
			local dist = actor.getTile().getDistanceTo(_targetTile);
			if (dist <= this.m.MinDistanceAPRecovery)
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
