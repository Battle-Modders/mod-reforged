this.rf_reach <- ::inherit("scripts/skills/skill", {
	m = {
		CurrBonus = 0,
		HitEnemies = []
	},
	function create()
	{
		this.m.ID = "special.rf_reach";
		this.m.Name = "Reach";
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Reach is a depiction of how far a character\'s attacks can reach, making melee combat easier against targets with shorter reach.\n\n[Melee skill|Concept.MeleeSkill] is increased when attacking opponents with shorter reach, and reduced against opponents with longer reach, by " + ::MSU.Text.colorGreen(::Reforged.Reach.BonusPerReach) + " per difference in reach. It only applies when attacking a target adjacent to you or up to 2 tiles away with nothing between you and the target.\n\nAfter a successful hit, the target\'s reach advantage is lost until the attacker waits or ends their turn.\n\nReach grants no [Melee Skill|Concept.MeleeSkill] when attacking an opponent who has a shield. Characters who are rooted or have no Zone of Control have no Reach.");
		this.m.Icon = "skills/rf_reach_effect.png";
		this.m.Type = ::Const.SkillType.Special | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.VeryLast + 100;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return !this.getContainer().getActor().getCurrentProperties().IsAffectedByReach;
	}

	function getName()
	{
		return this.m.Name + " (" + this.getContainer().getActor().getCurrentProperties().getReach() + ")";
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/reach.png",
			text = "Current Reach: " + this.getContainer().getActor().getCurrentProperties().getReach()
		});
		return tooltip;
	}

	function getNestedTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.m.Name
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	function onUpdate( _properties )
	{
		if (!this.getContainer().getActor().hasZoneOfControl() || _properties.IsRooted)
		{
			_properties.ReachMult = 0.0;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.m.CurrBonus = 0;

		if (_skill.isRanged() || !_properties.IsAffectedByReach || _targetEntity == null || !_targetEntity.getCurrentProperties().IsAffectedByReach || !::Reforged.Reach.hasLineOfSight(this.getContainer().getActor(), _targetEntity))
			return;

		local diff = _properties.getReach() - _targetEntity.getSkills().buildPropertiesForDefense(this.getContainer().getActor(), _skill).getReach();

		if (diff == 0 || (diff > 0 && _targetEntity.isArmedWithShield()) || (diff < 0 && this.m.HitEnemies.find(_targetEntity.getID()) != null))
			return;

		this.m.CurrBonus = ::Math.floor(::Reforged.Reach.BonusPerReach * diff);
		_properties.MeleeSkill += this.m.CurrBonus;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_skill.isRanged() && _targetEntity.isAlive() && ::Reforged.Reach.hasLineOfSight(this.getContainer().getActor(), _targetEntity) && this.m.HitEnemies.find(_targetEntity.getID()) == null)
		{
			this.m.HitEnemies.push(_targetEntity.getID());
		}
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		::MSU.Array.removeByValue(this.m.HitEnemies, _targetEntity.getID());
	}

	function onTurnStart()
	{
		this.m.HitEnemies.clear();
	}

	function onTurnEnd()
	{
		this.m.HitEnemies.clear();
	}

	function onWaitTurn()
	{
		this.m.HitEnemies.clear();
	}

	function onPayForItemAction( _skill, _items )
	{
		this.m.HitEnemies.clear();
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.HitEnemies.clear();
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (this.m.CurrBonus != 0)
		{
			_tooltip.push({
				icon = this.m.CurrBonus > 0 ? "ui/tooltips/positive.png" : "ui/tooltips/negative.png",
				text = ::MSU.Text.colorizePercentage(this.m.CurrBonus, {AddSign = false}) + (this.m.CurrBonus > 0 ? " Reach Advantage" : " Reach Disadvantage")
			});
		}
	}
});
