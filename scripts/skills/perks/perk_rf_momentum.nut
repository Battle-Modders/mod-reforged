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
		this.m.Icon = "ui/perks/perk_rf_momentum.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
	}

	function isHidden()
	{
		return this.m.TilesMovedThisTurn == 0;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = ::Reforged.Mod.Tooltips.parseString("The next Throwing attack costs " + ::MSU.Text.colorPositive("-" + this.m.TilesMovedThisTurn) + " [Action Points|Concept.ActionPoints]")
		});

		local damageBonus = this.getBonus();

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/damage_dealt.png",
			text = "The next Throwing attack does " + ::MSU.Text.colorPositive(damageBonus + "%") + " more damage"
		});

		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will expire upon [waiting|Concept.Wait] or ending the [turn|Concept.Turn], using any skill, or swapping any item except to/from a throwing weapon")
		});
		
		return ret;
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
		if (this.isEnabled() && this.m.TilesMovedThisTurn > 0)
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

	function onAffordablePreview( _skill, _movementTile )
	{
		if (!this.isEnabled()) return;

		if (_skill != null)
		{
			foreach (skill in this.getContainer().getActor().getMainhandItem().getSkills())
			{
				if (skill.isAttack() && skill.isRanged())
				{
					this.modifyPreviewField(skill, "ActionPointCost", 0, false);
				}
			}
		}

		if (_movementTile != null)
		{
			local bonus = this.m.TilesMovedThisTurn + _movementTile.getDistanceTo(this.getContainer().getActor().getTile());
			foreach (skill in this.getContainer().getActor().getMainhandItem().getSkills())
			{
				if (skill.isAttack() && skill.isRanged())
				{
					this.modifyPreviewField(skill, "ActionPointCost", ::Math.min(skill.m.ActionPointCost - 1, bonus) * -1, false);
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
