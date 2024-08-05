this.perk_rf_line_breaker <- ::inherit("scripts/skills/skill", {
	m = {
		KnockBackMeleeSkillBonus = 15
	},
	function create()
	{
		this.m.ID = "perk.rf_line_breaker";
		this.m.Name = ::Const.Strings.PerkName.RF_LineBreaker;
		this.m.Description = ::Const.Strings.PerkDescription.RF_LineBreaker;
		this.m.Icon = "ui/perks/perk_rf_line_breaker.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_line_breaker_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_line_breaker");
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill.getID() == "actives.knock_back" && _targetEntity.isAlive() && !_targetEntity.isDying())
		{
			local effect = ::new("scripts/skills/effects/staggered_effect");
			_targetEntity.getSkills().add(effect);
			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " has staggered " + ::Const.UI.getColorizedEntityName(_targetEntity) + " for " + effect.m.TurnsLeft + " turns");
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.getID() == "actives.knock_back")
		{
			_properties.MeleeSkill += this.m.KnockBackMeleeSkillBonus;
		}
	}

// MSU Functions
	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (_skill.getID() == "actives.knock_back")
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = ::MSU.Text.colorizeValue(this.m.KnockBackMeleeSkillBonus, {AddPercent = true}) + " " + this.getName()
			});
		}
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (_skill.getID() == "actives.knock_back")
		{
			_tooltip.push({
				id = 100,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Will [stagger|Skill+staggered_effect] the target if successfully knocked back")
			});
		}
	}
});
