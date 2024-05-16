this.rf_encourage_skill <- this.inherit("scripts/skills/skill", {
	m = {
		// Config
		EncourageBonusFraction = 0.1		// This percentage of Resolve is added as a bonus for the morale check
	},

	function create()
	{
		this.m.ID = "actives.rf_encourage";
		this.m.Name = "Encourage";
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Encourage an ally to raise their current [Morale|Concept.Morale]. A character can only be encouraged once per [round|Concept.Round]. Cannot be used on [fleeing|Concept.Morale] or [stunned|Skill+stunned_effect] allies.");
		this.m.Icon = "ui/perks/perk_28_active.png";	// unused vanilla artwork
		this.m.IconDisabled = "ui/perks/perk_28_active_sw.png";	// unused vanilla artwork
		this.m.Overlay = "rf_encourage_skill";
		this.m.SoundOnUse = [
			"sounds/combat/inspire_01.wav",		// unused vanilla sound. It is a bit too long and overblown but will do for now
			"sounds/combat/inspire_02.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 3;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Reforged.Mod.Tooltips.parseString("Trigger a positive [Morale Check|Concept.Morale] with a bonus of " + ::MSU.Text.colorizeFraction(this.m.EncourageBonusFraction) + " (" + ::MSU.Text.colorizeValue(this.getEncourageBonus()) + ") of your [Resolve|Concept.Bravery] on the target")
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of " + ::MSU.Text.colorGreen(this.getMaxRange()) + " tiles"
			}
		]);

		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();
		local actor = this.getContainer().getActor();
		return actor.getFaction() == target.getFaction() && target.getMoraleState() < actor.getMoraleState() && this.__canBeEncouraged(target);
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();

		target.checkMorale(1, this.getEncourageBonus(), ::Const.MoraleCheckType.Default);
		this.__markEntityWithRound(target);

		return true;
	}

// New Functions
	function getEncourageBonus()
	{
		local encourageBonus = this.getContainer().getActor().getCurrentProperties().getBravery() * this.m.EncourageBonusFraction;
		return ::Math.max(0, encourageBonus);	// The bonus can never be negative
	}

	function __canBeEncouraged( _targetEntity )
	{
		// The MaxMoraleState part might be confusing for the player because it's not mentioned in the tooltip but it's just logical
		if (_targetEntity.getCurrentProperties().IsStunned || _targetEntity.getMoraleState() >= _targetEntity.m.MaxMoraleState)
			return false;

		return this.__getRoundOfMarkedEntity(_targetEntity) < ::Time.getRound();
	}

	// Write the current round number in a tactical manager flag that consists of the id of an entity and the id of this skill
	function __markEntityWithRound( _targetEntity )
	{
		::Tactical.Entities.getFlags().set(_targetEntity.getID() + this.getID() + "MarkedWithRoundNumber", ::Time.getRound());
	}

	// Return the round number imprinted into a tactical manager flag for that entity; Returns 0 if no flag exists yet for it
	function __getRoundOfMarkedEntity( _targetEntity )
	{
		if (::Tactical.Entities.getFlags().has(_targetEntity.getID() + this.getID() + "MarkedWithRoundNumber"))
		{
			return ::Tactical.Entities.getFlags().get(_targetEntity.getID() + this.getID() + "MarkedWithRoundNumber");
		}

		return 0;
	}
});
