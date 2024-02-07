this.perk_rf_momentum <- ::inherit("scripts/skills/skill", {
	m = {
		// Public
		MeleeSkillAsRangedSkill = 0.15,
		BonusPerTile = 0.10,

		// Private
		PrevTile = null,
		TilesMovedThisTurn = 0,
		BeforeSkillExecutedTile = null
	},
	function create()
	{
		this.m.ID = "perk.rf_momentum";
		this.m.Name = ::Const.Strings.PerkName.RF_Momentum;
		this.m.Description = "A throw is really just a swing with extra steps.";
		this.m.Icon = "ui/perks/rf_momentum.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return !this.isEnabled();
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "Has " + ::MSU.Text.colorizePercentage(this.getHitchanceBonus()) + " chance to hit"
		});

		local damageBonus = this.getDamageBonus();
		if (damageBonus > 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "The next Throwing attack does " + ::MSU.Text.colorizeValue(damageBonus, {AddPercent = true}) + " more damage"
			});

			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("Will expire upon waiting or ending the turn, using any skill, or swapping any item except to/from a throwing weapon")
			});
		}

		return tooltip;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		_properties.RangedSkill += this.getHitchanceBonus();

		if (_skill.isAttack() && _skill.isRanged() && _skill.m.IsWeaponSkill && this.m.TilesMovedThisTurn > 0 && this.isEnabled())
		{
			_properties.RangedDamageMult *= 1.0 + this.getDamageBonus() * 0.01;
		}
	}

	function onWaitTurn()
	{
		this.m.TilesMovedThisTurn = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.TilesMovedThisTurn = 0;
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.BeforeSkillExecutedTile = this.getContainer().getActor().getTile();
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.m.BeforeSkillExecutedTile != null && this.getContainer().getActor().getTile().isSameTileAs(this.m.BeforeSkillExecutedTile))
		{
			this.m.TilesMovedThisTurn = 0;
		}
	}

	function onTurnEnd()
	{
		this.m.TilesMovedThisTurn = 0;
	}

	function onMovementStarted( _tile, _numTiles )
	{
		this.m.PrevTile = _tile;
	}

	function onMovementFinished( _tile )
	{
		this.m.TilesMovedThisTurn += _tile.getDistanceTo(this.m.PrevTile);
	}

// MSU Functions
	function onQueryTooltip( _skill, _tooltip )
	{
		if (_skill.isRanged() && _skill.m.IsWeaponSkill)
		{
			local weapon = this.getContainer().getActor().getMainhandItem();
			if (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Throwing))
			{
				_tooltip.push({
					id = 10,
					type = "text",
					icon = "ui/icons/hitchance.png",
					text = "Has " + ::MSU.Text.colorizePercentage(this.getHitchanceBonus()) + " chance to hit due to " + this.getName()
				});
			}
		}
	}

// New Functions
	function isEnabled()
	{
		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Throwing))
		{
			return false;
		}

		return true;
	}

	function getHitchanceBonus()
	{
		return ::Math.floor(this.m.MeleeSkillAsRangedSkill * this.getContainer().getActor().getCurrentProperties().getMeleeSkill());
	}

	function getDamageBonus()
	{
		return ::Math.floor(this.m.TilesMovedThisTurn * this.m.BonusPerTile * this.getContainer().getActor().getCurrentProperties().getMeleeSkill());
	}
});
