this.perk_rf_momentum <- ::inherit("scripts/skills/skill", {
	m = {
		BonusPerTile = 5,
		PrevTile = null,		
		TilesMovedThisTurn = 0,
		BeforeSkillExecutedTile = null
	},
	function create()
	{
		this.m.ID = "perk.rf_momentum";
		this.m.Name = ::Const.Strings.PerkName.RF_Momentum;
		this.m.Description = "A running start goes a long way to throwing better!";
		this.m.Icon = "ui/perks/rf_momentum.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.TilesMovedThisTurn == 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = "The next Throwing attack costs [color=" + ::Const.UI.Color.PositiveValue + "]-" + this.m.TilesMovedThisTurn + "[/color] Action Points"
		});

		local damageBonus = this.getBonus();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "The next Throwing attack does [color=" + ::Const.UI.Color.PositiveValue + "]" + damageBonus + "%[/color] more damage"
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::MSU.Text.colorRed("Will expire upon waiting or ending the turn, using any skill, or swapping any item except to/from a throwing weapon")
		});
		
		return tooltip;
	}

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

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && _skill.isRanged() && _skill.m.IsWeaponSkill && this.m.TilesMovedThisTurn > 0 && this.isEnabled())
		{
			_properties.RangedDamageMult *= 1.0 + this.getBonus() * 0.01;
		}
	}

	function onAfterUpdate( _properties )
	{
		if (!this.isEnabled())
			return;

		local actor = this.getContainer().getActor();
		local tilesMoved = this.m.TilesMovedThisTurn;
		if (actor.isPreviewing())
		{
			if (actor.getPreviewSkill() != null)
				return;

			tilesMoved += actor.getPreviewMovement().End.getDistanceTo(actor.getTile());
		}

		if (tilesMoved > 0)
		{
			foreach (skill in this.getContainer().getActor().getMainhandItem().getSkills())
			{
				if (skill.isAttack() && skill.isRanged())
				{
					skill.m.ActionPointCost -= ::Math.max(0, ::Math.min(skill.m.ActionPointCost - 1, this.m.TilesMovedThisTurn));
				}
			}
		}
	}

	function getBonus()
	{
		return this.m.TilesMovedThisTurn * this.m.BonusPerTile;
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

	function onPayForItemAction( _skill, _items )
	{
		foreach (item in _items)
		{
			if (item != null && item.isItemType(::Const.Items.ItemType.Weapon) && item.isWeaponType(::Const.Items.WeaponType.Throwing))
			{
				return;
			}
		}
		
		this.m.TilesMovedThisTurn = 0;
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
});
