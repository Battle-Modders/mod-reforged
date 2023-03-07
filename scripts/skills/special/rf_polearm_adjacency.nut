this.rf_polearm_adjacency <- ::inherit("scripts/skills/skill", {
	m = {
		MalusPerAlly = 5,
		MalusPerEnemy = 10,
		AlliesIgnored = 1,		// Amount of allies that this effect will ignore until applying its penalty
		IgnoreAllyPenalty = false,		// To allow us to offer this feature as a perk effect
	},
	function create()
	{
		this.m.ID = "special.rf_polearm_adjacency";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Type = ::Const.SkillType.Special;
		this.m.IsActive = false;
		this.m.IsHidden = true;
		this.m.IsSerialized = false;
	}

	function isEnabled()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.getRangeMax() > 1 && weapon.isItemType(::Const.Items.ItemType.MeleeWeapon))
		{
			return true;
		}

		return false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		_properties.MeleeSkill -= this.calculatePenaltyForSkill( _skill );
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		local penalty = this.calculatePenaltyForSkill(_skill);
		if (penalty > 0)
		{
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = ::MSU.Text.colorizePercentage(-penalty) + " Crowded"
			});
		}
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		local penalty = this.calculatePenaltyForSkill(_skill);
		if (penalty > 0)
		{
			_tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has reduced chance to hit when standing next to others. " + ::MSU.Text.colorizePercentage(-this.m.MalusPerAlly) + " per adjacent ally (except the first one) " + ::MSU.Text.colorizePercentage(-this.m.MalusPerEnemy) + " per adjacent enemy"
			});
		}
	}

	// Returns the actual penalty that the adjeceny mechanic will apply given a skill
	function calculatePenaltyForSkill( _skill )
	{
		if (_skill.getMaxRange() == 1 || !_skill.isAttack() || _skill.isRanged() || !_skill.m.IsWeaponSkill )
		{
			return 0;
		}

		return calculatePenalty();
	}

	// Returns the raw penalty that the adjeceny mechanic would apply to melee skill
	function calculatePenalty()
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || !this.isEnabled()) return 0;

		local penalty = 0;
		local countedAllies = 0;	// For the purposes of the 'AlliesIgnored' feature of this effect
		for (local direction = 0; direction < 6; direction++)
		{
			if (actor.getTile().hasNextTile(direction) == false) continue;
			local nextTile = actor.getTile().getNextTile(direction);
			if (nextTile.IsOccupiedByActor == false) continue;
			if (nextTile.getEntity().isAlliedWith(actor))
			{
				if (this.m.IgnoreAllyPenalty) continue;
				countedAllies++
				if (countedAllies <= this.m.AlliesIgnored) continue;	// We may ignore the penalty from the first bunch of allies
				penalty += this.m.MalusPerAlly;
			}
			else
			{
				penalty += this.m.MalusPerEnemy;
			}
		}

		return penalty;
	}
});
