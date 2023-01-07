this.perk_rf_formidable_approach <- ::inherit("scripts/skills/skill", {
	m = {
		ReachBonus = 2,
		Enemies = []
	},
	function create()
	{
		this.m.ID = "perk.rf_formidable_approach";
		this.m.Name = ::Const.Strings.PerkName.RF_FormidableApproach;
		this.m.Description = ::Const.Strings.PerkDescription.RF_FormidableApproach;
		this.m.Icon = "ui/perks/rf_formidable_approach.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function registerEnemy( _actor )
	{
		if (this.getContainer().getActor().hasZoneOfControl() && this.m.Enemies.find(_actor.getID() == null))
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
			_properties.Reach += this.m.ReachBonus;
		}
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (!_skill.isRanged() && this.hasEnemy(_attacker))
		{
			_properties.Reach += this.m.ReachBonus;
		}
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (!_skill.isAttack() || _skill.isRanged() || !_targetTile.IsOccupiedByActor || !this.hasEnemy(_targetTile.getEntity()))
			return;

		local defenderPerk = _targetTile.getEntity().getSkills().hasSkill("perk.rf_formidable_approach");
		if (defenderPerk == null || !defenderPerk.hasEnemy(this.getContainer().getActor()))
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = ::MSU.colorGreen(this.getName())
			});
		}
	}

	function onGetHitFactorsAsTarget( _skill, _targetTile, _tooltip )
	{
		if (!_skill.isAttack() || _skill.isRanged() || !this.hasEnemy(_skill.getContainer().getActor()))
			return;

		local attackerPerk = _skill.getContainer().hasSkill("perk.rf_formidable_approach");
		if (attackerPerk == null || !attackerPerk.hasEnemy(this.getContainer().getActor()))
		{
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = ::MSU.colorRed(this.getName())
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
