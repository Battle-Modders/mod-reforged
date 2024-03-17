this.rf_inspire_skill <- this.inherit("scripts/skills/skill", {
	m = {
		// Config
		InspireBonusFraction = 0.1,		// This percentage of Resolve is added as a bonus for the morale check

		// Const
		InspireFlag = "RF_InspireSkillFlag"
	},

	function create()
	{
		this.m.ID = "actives.rf_inspire";
		this.m.Name = "Inspire";
		this.m.Description = "Inspire an ally to raise their current Morale. The same target can only be inspired once per turn. Cannot be used on fleeing or stunned allies.";
		this.m.Icon = "skills/rf_inspire_skill.png";	// TODO: make
		this.m.IconDisabled = "skills/rf_inspire_skill_sw.png";	// TODO: make
		this.m.Overlay = "rf_inspire_skill";
		this.m.SoundOnUse = [];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
		// this.m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_Inspire;	// Todo Implement
	}

	function getTooltip()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();

		tooltip.extend([
			{
				id = 8,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Trigger a positive morale check with a bonus of " + ::MSU.Text.colorizeFraction(this.m.InspireBonusFraction) + " (" + ::MSU.Text.colorizeValue(this.getInspireBonus()) + ") of your Resolve on the target."
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of " + ::MSU.Text.colorGreen(this.getMaxRange()) + " tiles"
			}
		]);

		return tooltip;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) return false;

		local target = _targetTile.getEntity();

		if (this.getContainer().getActor().getFaction() != target.getFaction()) return false;
		if (target.getCurrentProperties().IsStunned) return false;

		if (target.getMoraleState() >= ::Const.MoraleState.Confident) return false;
		if (target.getMoraleState() >= target.m.MaxMoraleState) return false;	// This might be confusing for the player because it's not mentioned in the tooltip but it's just logical

		return this.__canBeInspired(target);
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		target.checkMorale(1, this.getInspireBonus(), ::Const.MoraleCheckType.Default, "status_effect_56");	// TODO replace status effect

		::Tactical.Entities.getFlags().set(target.getID() + this.m.InspireFlag, ::Time.getRound());	// We use entity flags to keep track of this skills usage instead of a dummy skill

		// this.spawnIcon("rf_inspire_skill", _targetTile);	// TODO decide on whether to spawn this?
		return true;
	}

// New Functions
	function getInspireBonus()
	{
		local inspireBonus = this.getContainer().getActor().getCurrentProperties().getBravery() * this.m.InspireBonusFraction;
		return ::Math.max(0, inspireBonus);	// The bonus can never be negative
	}

	function __canBeInspired( _targetEntity )
	{
		return (this.__getLastInspiredRound(_targetEntity) < ::Time.getRound());
	}

	function __getLastInspiredRound( _targetEntity )
	{
		if (::Tactical.Entities.getFlags().has(_targetEntity.getID() + this.m.InspireFlag))
		{
			return ::Tactical.Entities.getFlags().get(_targetEntity.getID() + this.m.InspireFlag);
		}

		return 0;
	}
});
