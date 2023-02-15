this.rf_reach <- ::inherit("scripts/skills/skill", {
	m = {
		CurrBonus = 0,
		HitEnemies = []
	},
	function create()
	{
		this.m.ID = "special.rf_reach";
		this.m.Name = "Reach";
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Reach is a depiction of how far a character\'s attacks can reach, making melee combat easier against targets with shorter reach.\n\n[Melee skill|Concept.MeleeSkill] is increased when attacking opponents with shorter reach, and reduced against opponents with longer reach, by " + ::MSU.Text.colorGreen(::Reforged.Reach.BonusPerReach) + " per difference in reach. It only applies when attacking a target adjacent to you or up to 2 tiles away with nothing between you and the target.\n\nAfter a successful hit, the target\'s reach advantage is lost until the attacker waits or ends their turn.\n\nReach grants no [Melee Skill|Concept.MeleeSkill] when attacking an opponent who has a shield. Characters who are rooted or have no [Zone of Control|Concept.ZoneOfControl] have no Reach.");
		this.m.Icon = "skills/rf_reach_effect.png";
		this.m.Type = ::Const.SkillType.Special | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.VeryLast + 100;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getName()
	{
		local ret = this.m.Name;
		if (this.getContainer().getActor().getCurrentProperties().IsAffectedByReach)
			ret += " (" + this.getContainer().getActor().getCurrentProperties().getReach() + ")";
		else
			ret += " (Irrelevant)";

		return ret;
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
		// Midas -- We need to switch the CurrentProperties with _properties because effects such as stunned_effect, when added,
		// change the IsStunned attribute to true in _properties, but it isn't yet updated for CurrentProperties as _properties
		// becomes CurrentProperties at the end of the current skill_container update. This causes `hasZoneOfControl` to
		// return true because it uses CurrentProperties to check for IsStunned.
		// This switcheroo is better than checking for _properties.IsStunned because we want to use hasZoneOfControl to
		// be able to check for all (potentially new modded) conditions which may remove zone of control. Secondly, without the switcheroo
		// when the stunned effect is removed, the ReachMult will still remain 0 as while _properties.IsStunned will be false,
		// for CurrentProperties it will still be true, causing hasZoneOfControl to return false.
		local actor = this.getContainer().getActor();
		local currentProperties = actor.getCurrentProperties();
		actor.m.CurrentProperties = _properties;
		if (!this.getContainer().getActor().hasZoneOfControl() || _properties.IsRooted)
		{
			_properties.ReachMult = 0.0;
		}
		actor.m.CurrentProperties = currentProperties;
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
