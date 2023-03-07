this.rf_polearm_adjacency <- ::inherit("scripts/skills/skill", {
	m = {
		TotalMalus = 0,
		MalusPerAlly = 5,
		MalusPerEnemy = 10
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
		if (weapon != null && weapon.getRangeMax() > 1)
		{
			return true;
		}

		return false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.m.TotalMalus = 0;

		if (_targetEntity == null || _skill.getMaxRange() == 1 || !_skill.isAttack() || _skill.isRanged() || !_skill.m.IsWeaponSkill || !this.isEnabled() || !::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
		{
			return;
		}

		local user = this.getContainer().getActor();
		if (!user.isPlacedOnMap())
			return;

		foreach (faction in ::Tactical.Entities.getAllInstances())
		{
			foreach (actor in faction)
			{
				if (actor.isPlacedOnMap() && actor.getTile().getDistanceTo(user.getTile()) == 1)
				{
					this.m.TotalMalus += actor.isAlliedWith(user) ? this.m.MalusPerAlly : this.m.MalusPerEnemy;
				}
			}
		}

		_properties.MeleeSkill -= this.m.TotalMalus;
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (this.m.TotalMalus > 0)
		{
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = ::MSU.Text.colorizePercentage(-this.m.TotalMalus) + " Crowded"
			});
		}
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (_skill.isAttack() && !_skill.isRanged() && _skill.getMaxRange() > 1 && _skill.m.IsWeaponSkill && this.isEnabled())
		{
			_tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has reduced chance to hit when standing next to others. " + ::MSU.Text.colorizePercentage(-this.m.MalusPerAlly) + " per adjacent ally and " + ::MSU.Text.colorizePercentage(-this.m.MalusPerAlly) + " per adjacent enemy"
			});
		}
	}
});
