// Part of this effect's functionality is in fire_handgonne_skill
this.rf_take_aim_effect <- ::inherit("scripts/skills/skill", {
	m = {
		DiversionMaxLevelDifference = null,
		FireHandgonneSkill = null // WeakTableRef to allow us to hook the getAffectedTiles function
	},
	function create()
	{
		this.m.ID = "effects.rf_take_aim";
		this.m.Name = "Taking Aim";
		this.m.Description = "This character is expending significant effort into taking a better aim.";
		this.m.Icon = "skills/rf_take_aim_effect.png";
		this.m.IconMini = "rf_take_aim_effect_mini";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "For the next ranged attack:"
		});

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Crossbows ignore any hitchance penalty from obstacles, and the shot cannot go astray"
		});

		tooltip.push({
			id = 7,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Handgonnes have their Maximum Range increased by 1 and if used at shorter range, have their area of effect increased by 1 instead"
		});

		return tooltip;
	}

	function isEnabled()
	{
		local skill = this.getContainer().getSkillByID("actives.rf_take_aim");
		return skill != null && skill.isEnabled();
	}

	function onUpdate( _properties )
	{
		if (this.isEnabled())
		{
			_properties.RangedAttackBlockedChanceMult = 0;
		}
	}

	function onAfterUpdate(_properties)
	{
		local fireHandgonne = this.getContainer().getSkillByID("actives.fire_handgonne");
		if (fireHandgonne != null)
		{
			fireHandgonne.m.MaxRange += 1;
		}
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.DiversionMaxLevelDifference = null;
		
		if (_skill.isAttack() && _skill.isRanged())
		{
			local weapon = this.getContainer().getActor().getMainhandItem();
			if (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Crossbow))
			{
				this.m.DiversionMaxLevelDifference = ::Const.Combat.DiversionMaxLevelDifference;
				::Const.Combat.DiversionMaxLevelDifference = -100;
			}
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.m.DiversionMaxLevelDifference != null)
		{
			::Const.Combat.DiversionMaxLevelDifference = this.m.DiversionMaxLevelDifference;
		}
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.removeSelf();
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.removeSelf();
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}
});
