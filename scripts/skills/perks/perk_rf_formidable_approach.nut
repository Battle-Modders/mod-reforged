this.perk_rf_formidable_approach <- ::inherit("scripts/skills/skill", {
	m = {
		BonusPerReachAdvantage = 2,
		Enemies = []
	},
	function create()
	{
		this.m.ID = "perk.rf_formidable_approach";
		this.m.Name = ::Const.Strings.PerkName.RF_FormidableApproach;
		this.m.Description = ::Const.Strings.PerkDescription.RF_FormidableApproach;
		this.m.Icon = "ui/perks/perk_rf_formidable_approach.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function registerEnemy( _actor )
	{
		if (this.getContainer().getActor().hasZoneOfControl() && this.m.Enemies.find(_actor.getID()) == null)
			this.m.Enemies.push(_actor.getID());
	}

	function unregisterEnemy( _actor )
	{
		::MSU.Array.removeByValue(this.m.Enemies, _actor.getID());
	}

	function hasEnemy( _actor )
	{
		return this.m.Enemies.find(_actor.getID()) != null;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && !_skill.isRanged() && _targetEntity != null && this.hasEnemy(_targetEntity))
		{
			_properties.BonusPerReachAdvantage += this.m.BonusPerReachAdvantage;
		}
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (!_skill.isRanged() && this.hasEnemy(_attacker))
		{
			_properties.BonusPerReachAdvantage += this.m.BonusPerReachAdvantage;
		}
	}

	function onUpdate( _properties )
	{
		_properties.Reach += 1;
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (!_skill.isAttack() || _skill.isRanged() || !_targetTile.IsOccupiedByActor || !this.hasEnemy(_targetTile.getEntity()))
			return;

		local defenderPerk = _targetTile.getEntity().getSkills().getSkillByID("perk.rf_formidable_approach");
		if (defenderPerk == null || !defenderPerk.hasEnemy(this.getContainer().getActor()))
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = this.getName()
			});
		}
	}

	function onGetHitFactorsAsTarget( _skill, _targetTile, _tooltip )
	{
		if (!_skill.isAttack() || _skill.isRanged() || !this.hasEnemy(_skill.getContainer().getActor()))
			return;

		local attackerPerk = _skill.getContainer().getSkillByID("perk.rf_formidable_approach");
		if (attackerPerk == null || !attackerPerk.hasEnemy(this.getContainer().getActor()))
		{
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = this.getName()
			});
		}
	}

	function onSkillsUpdated()
	{
		local properties = this.getContainer().getActor().getCurrentProperties();
		if (properties.IsStunned || properties.IsRooted || !this.getContainer().getActor().hasZoneOfControl())
		{
			this.m.Enemies.clear();
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Enemies.clear();
	}
});
