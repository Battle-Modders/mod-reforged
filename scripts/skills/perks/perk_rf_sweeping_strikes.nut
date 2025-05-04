this.perk_rf_sweeping_strikes <- ::inherit("scripts/skills/skill", {
	m = {
		IsInEffect = false,
		ReachBonus = 3,
		TargetsAffected = []
	},
	function create()
	{
		this.m.ID = "perk.rf_sweeping_strikes";
		this.m.Name = ::Const.Strings.PerkName.RF_SweepingStrikes;
		this.m.Description = "This character is swinging his weapon in large sweeping motions, making it harder to approach him.";
		this.m.Icon = "ui/perks/perk_rf_sweeping_strikes.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isHidden()
	{
		return !this.m.IsInEffect;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/rf_reach.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.ReachBonus, {AddSign = true}) + " [Reach|Concept.Reach]")
		});

		local enemyList = [];
		foreach (entity in this.m.TargetsAffected)
		{
			if (!::MSU.isNull(entity) && entity.isAlive())
			{
				enemyList.push({
					id = 11,
					type = "text",
					icon = "ui/orientation/" + entity.getOverlayImage() + ".png",
					text = entity.getName()
				});
			}
		}

		if (enemyList.len() != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/rf_reach.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.ReachBonus, {AddSign = true}) + " [Reach|Concept.Reach] against attacks from:")
				children = enemyList
			});
		}

		return ret;
	}

	function onAnySkillExecutedFully( _skill, _targetTile, _targetEntity, _forFree )
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
			this.addTarget(_targetEntity);
		}
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		if (_skill.isAttack() && !_skill.isRanged() && _skill.isAOE())
		{
			this.addTarget(_targetEntity);
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

	function addTarget( _entity )
	{
		foreach (e in this.m.TargetsAffected)
		{
			if (::MSU.isEqual(e, _entity))
				return;
		}
		this.m.TargetsAffected.push(::MSU.asWeakTableRef(_entity));
	}
});
