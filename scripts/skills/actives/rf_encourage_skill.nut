this.rf_encourage_skill <- ::inherit("scripts/skills/skill", {
	m = {
		// Config
		EncourageBonusFraction = 0.5,		// This percentage of Resolve is added as a bonus for the morale check

		IsSpent = false
	},

	function create()
	{
		this.m.ID = "actives.rf_encourage";
		this.m.Name = "Encourage";
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Encourage an ally to raise their current [Morale.|Concept.Morale] Cannot be used on [fleeing|Concept.Morale] or [stunned|Skill+stunned_effect] allies.");
		this.m.Icon = "ui/perks/perk_28_active.png";	// unused vanilla artwork
		this.m.IconDisabled = "ui/perks/perk_28_active_sw.png";	// unused vanilla artwork
		this.m.Overlay = "perk_28_active";	// unused vanilla artwork
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
		this.m.MaxRange = 2;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();

		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("Trigger a positive [Morale Check|Concept.Morale] for the target with a bonus of %s (%s) of your [Resolve|Concept.Bravery]", ::MSU.Text.colorizePct(this.m.EncourageBonusFraction), ::MSU.Text.colorizeValue(this.getEncourageBonus())))
			},
			{
				id = 15,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of " + ::MSU.Text.colorPositive(this.getMaxRange()) + " tiles"
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Can only be used on characters whose [morale|Concept.Morale] is lower than you per tile of distance they are away")
			}
		]);

		if (this.m.IsSpent)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString("Can only be used once per [turn|Concept.Turn]")
			});
		}

		return ret;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
			return false;

		local target = _targetTile.getEntity();
		if (target.getCurrentProperties().IsStunned || target.getMoraleState() == ::Const.MoraleState.Fleeing || target.getMoraleState() >= ::Const.MoraleState.Confident || target.getMoraleState() >= target.m.MaxMoraleState)
			return false;

		local actor = this.getContainer().getActor();
		return actor.getFaction() == target.getFaction() && actor.getMoraleState() - target.getMoraleState() >= actor.getTile().getDistanceTo(target.getTile());
	}

	function isUsable()
	{
		return !this.m.IsSpent && this.skill.isUsable();
	}

	function onUse( _user, _targetTile )
	{
		_targetTile.getEntity().checkMorale(1, this.getEncourageBonus(), ::Const.MoraleCheckType.Default);
		this.m.IsSpent = true;
		return true;
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsSpent = false;
	}

// New Functions
	function getEncourageBonus()
	{
		local encourageBonus = this.getContainer().getActor().getCurrentProperties().getBravery() * this.m.EncourageBonusFraction;
		return ::Math.max(0, encourageBonus);	// The bonus can never be negative
	}
});
