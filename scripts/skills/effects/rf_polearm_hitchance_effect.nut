this.rf_polearm_hitchance_effect <- ::inherit("scripts/skills/skill", {
	m = {
		HitChanceAdjacentAdd = -15
	},
	function create()
	{
		this.m.ID = "effects.rf_polearm_hitchance";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "";		
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function isEnabled()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.getRangeMax() > 1 && weapon.isItemType(::Const.Items.ItemType.TwoHanded))
		{
			return true;
		}

		return false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity != null && _skill.getMaxRange() > 1 && _skill.isAttack() && !_skill.isRanged() && _skill.m.IsWeaponSkill && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()) && this.isEnabled() && this.getContainer().getActor().isEngagedInMelee())
		{
			_properties.MeleeSkill += this.m.HitChanceAdjacentAdd;
		}
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (_targetTile.IsOccupiedByActor && _skill.getMaxRange() > 1 && _skill.isAttack() && !_skill.isRanged() && _skill.m.IsWeaponSkill && this.isEnabled() && this.getContainer().getActor().isEngagedInMelee())
		{			
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = ::MSU.Text.colorizePercentage(this.m.HitChanceAdjacentAdd) + " Engaged in Melee"
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
				text = "Has " + ::MSU.Text.colorizePercentage(this.m.HitChanceAdjacentAdd) + " chance to hit when engaged in melee"
			});
		}
	}
});
