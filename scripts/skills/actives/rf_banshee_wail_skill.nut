this.rf_banshee_wail_skill <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rf_banshee_wail";
		this.m.Name = "Wail";
		this.m.Description = "Unleash your inner turmoil as an agonizing wail.";
		// this.m.Icon = "skills/rf_banshee_wail_skill.png";
		// this.m.IconDisabled = "skills/rf_banshee_wail_skill_sw.png";
		// this.m.Overlay = "rf_banshee_wail_skill";
		this.m.Icon = "skills/active_41.png";
		this.m.IconDisabled = "skills/active_41.png";
		this.m.Overlay = "active_41";
		this.m.SoundOnUse = [
			"sounds/enemies/rf_banshee_wail_skill_01.wav"
			"sounds/enemies/rf_banshee_wail_skill_02.wav"
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
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Trigger a negative [morale check|Concept.Morale] for all enemies within " + this.getMaxRange() + " tiles, causing those who lose [morale|Concept.Morale] to be afflicted with [Grieving Malaise|Skill+rf_grieving_malaise_effect]")
		});
		return ret;
	}

	function onUse( _user, _targetTile )
	{
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " uses " + this.getName());
		}

		foreach (actor in ::Tactical.Entities.getHostileActors(_user.getFaction(), _user.getTile(), 6))
		{
			if (actor.checkMorale(-1, 0, ::Const.MoraleCheckType.MentalAttack))
			{
				actor.getSkills().add(::new("scripts/skills/effects/rf_grieving_malaise_effect"));
			}
		}
	}
});

