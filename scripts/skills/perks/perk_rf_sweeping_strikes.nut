this.perk_rf_sweeping_strikes <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		IsInEffect = false,
		ReachBonus = 3,
		TargetsAffected = []
	},
	function create()
	{
		this.m.ID = "perk.rf_sweeping_strikes";
		this.m.Name = ::Const.Strings.PerkName.RF_SweepingStrikes;
		this.m.Description = "This character is swinging his weapon in large sweeping motions, making it harder to approach him.";
		this.m.Icon = "ui/perks/rf_sweeping_strikes.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return !this.m.IsInEffect;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/reach.png",
			text = ::MSU.Text.colorizeValue(this.m.ReachBonus) + " Reach"
		});

		local enemyList = [];
		foreach (entity in this.m.TargetsAffected)
		{
			if (!::MSU.isNull(entity) && entity.isAlive())
			{
				enemyList.push({
					id = 10,
					type = "text",
					icon = "ui/orientation/" + entity.getOverlayImage() + ".png",
					text = entity.getName()
				});
			}
		}

		if (enemyList.len() != 0)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/reach.png",
				text = ::MSU.Text.colorizeValue(this.m.ReachBonus) + " Reach against attacks from:"
				children = enemyList
			});
		}

		return tooltip;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled) return true;

		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || weapon.getReach() < 3)
		{
			return false;
		}

		return true;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.isAttack() && !_skill.isRanged() && _skill.isAOE() && _targetEntity != null)
		{
			this.m.IsInEffect = true;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity.isAlive() && _skill.isAttack() && !_skill.isRanged() && _skill.isAOE())
		{
			this.m.TargetsAffected.push(::MSU.asWeakTableRef(_targetEntity));
		}
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		if (_skill.isAttack() && !_skill.isRanged() && _skill.isAOE())
		{
			this.m.TargetsAffected.push(::MSU.asWeakTableRef(_targetEntity));
		}
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (this.m.IsInEffect)
		{
			foreach (entity in this.m.TargetsAffected)
			{
				if (::MSU.isEqual(_attacker, entity))
				{
					_properties.Reach += this.m.ReachBonus;
				}
			}
		}
	}

	function onUpdate( _properties )
	{
		if (this.m.IsInEffect)
			_properties.Reach += this.m.ReachBonus;
	}

	function onTurnStart()
	{
		this.m.IsInEffect = false;
		this.m.TargetsAffected.clear();
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished()
		this.m.IsInEffect = false;
		this.m.TargetsAffected.clear();
	}
});
