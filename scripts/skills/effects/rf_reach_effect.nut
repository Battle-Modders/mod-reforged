this.rf_reach_effect <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.rf_reach";
		this.m.Name = "Reach";
		this.m.Description = "Reach is a depiction of how far this character\'s attacks can reach, making melee combat easier against targets with shorter reach. In combat, every point of Reach increases Melee Skill and Melee Defense by " + ::MSU.Text.colorizeValue(::Reforged.Reach.BonusPerReach) + ". Attackers with longer weapons will, therefore, have an advantage against those with shorter ones. Note: Reach grants no Melee Skill when attacking an opponent who has a shield and a character without Zone of Control has no Reach.";
		this.m.Icon = "skills/rf_reach_effect.png";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.VeryLast + 100;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getName()
	{
		return this.getContainer().getActor().isPlayerControlled() ? this.m.Name : this.m.Name + " (" + this.getContainer().getActor().getCurrentProperties().getReach() + ")";
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

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		::Reforged.Reach.CurrAttackerBonus = 0;
		::Reforged.Reach.CurrDefenderBonus = 0;
		if (_skill.isRanged() || _targetEntity == null || _targetEntity.isArmedWithShield() || !::Reforged.Reach.hasLineOfSight(this.getContainer().getActor(), _targetEntity))
			return;

		if (!this.getContainer().getActor().hasZoneOfControl())
			_properties.ReachMult *= 0;

		::Reforged.Reach.CurrAttackerBonus = ::Math.floor(::Reforged.Reach.BonusPerReach * _properties.getReach());
		_properties.MeleeSkill += ::Reforged.Reach.CurrAttackerBonus;
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (_skill.isRanged() || !::Reforged.Reach.hasLineOfSight(_attacker, this.getContainer().getActor()))
			return;

		::Reforged.Reach.CurrDefenderBonus = ::Math.floor(::Reforged.Reach.BonusPerReach * _properties.getReach());
		_properties.MeleeDefense += ::Reforged.Reach.CurrDefenderBonus;
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (!_targetTile.IsOccupiedByActor || _targetTile.getEntity().getID() == this.getContainer().getActor().getID())
			return;

		local diff = ::Reforged.Reach.CurrAttackerBonus - ::Reforged.Reach.CurrDefenderBonus;
		if (diff != 0)
		{
			_tooltip.push({
				icon = diff > 0 ? "ui/tooltips/positive.png" : "ui/tooltips/negative.png",
				text = ::MSU.Text.colorizePercentage(diff) + (diff > 0 ? " Reach Advantage" : " Reach Disadvantage")
			});
		}
	}
});
