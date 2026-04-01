this.rf_wail_skill <- ::inherit("scripts/skills/skill", {
	m = {
		// Starts at MaxRange and then is stacked additively
		// for each tile the target is closer to us.
		MoraleCheckDifficultyPerTile = -5
	},
	function create()
	{
		this.m.ID = "actives.rf_wail";
		this.m.Name = "Wail";
		this.m.Description = "Unleash your inner turmoil as an agonizing wail.";
		this.m.Icon = "skills/rf_wail_skill.png";
		this.m.IconDisabled = "skills/rf_wail_skill_sw.png";
		this.m.Overlay = "rf_wail_skill";
		this.m.SoundOnUse = [
			"sounds/enemies/rf_wail_skill_01.wav"
			"sounds/enemies/rf_wail_skill_02.wav"
			"sounds/enemies/rf_wail_skill_03.wav"
			"sounds/enemies/rf_wail_skill_04.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsAttack = true;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
		this.m.MaxLevelDifference = 4;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Terror;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString(format("Trigger a negative [morale check|Concept.Morale] for all enemies within %i tiles, with a stacking penalty of %s [Resolve|Concept.Bravery] for each tile the target is closer to you", this.getMaxRange(), ::MSU.Text.colorizeValue(this.m.MoraleCheckDifficultyPerTile, {AddSign = true})))
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString(format("Targets who lose [morale|Concept.Morale] due to this are afflicted with [Grieving Malaise|Skill+rf_grieving_malaise_effect]"))
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " uses " + this.getName());
		}

		local myTile = _user.getTile();
		local difficulty = this.m.MoraleCheckDifficultyPerTile * this.getMaxRange();

		foreach (actor in ::Tactical.Entities.getHostileActors(_user.getFaction(), myTile, this.getMaxRange()))
		{
			local dist = myTile.getDistanceTo(actor.getTile()) - 1;
			if (actor.checkMorale(-1, difficulty - this.m.MoraleCheckDifficultyPerTile * dist, ::Const.MoraleCheckType.MentalAttack))
			{
				actor.getSkills().add(::new("scripts/skills/effects/rf_grieving_malaise_effect"));
			}
		}
	}
});

