::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_throwing", function(q) {
	// Private
	q.m.IsSpent <- false;	// Is quickswitching spent this turn?
	q.m.PrevTile <- null;
	q.m.TilesMovedThisTurn <- 0;
	q.m.BeforeSkillExecutedTile <- null;

	q.onWaitTurn = @(__original) function()
	{
		__original();
		this.m.TilesMovedThisTurn = 0;
	}

	q.onCombatFinished = @(__original) function()
	{
		__original();
		this.m.TilesMovedThisTurn = 0;
	}

	q.onBeforeAnySkillExecuted = @(__original) function( _skill, _targetTile, _targetEntity, _forFree )
	{
		__original(_skill, _targetTile, _targetEntity, _forFree);
		this.m.BeforeSkillExecutedTile = this.getContainer().getActor().getTile();
	}

	q.onAnySkillExecuted = @(__original) function( _skill, _targetTile, _targetEntity, _forFree )
	{
		__original(_skill, _targetTile, _targetEntity, _forFree);
		if (this.m.BeforeSkillExecutedTile != null && this.getContainer().getActor().getTile().isSameTileAs(this.m.BeforeSkillExecutedTile))
		{
			this.m.TilesMovedThisTurn = 0;
		}
	}

	q.onAfterUpdate = @(__original) function( _properties )
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

	q.onPayForItemAction = @(__original) function( _skill, _items )
	{
		__original(_skill, _items);

		if (_skill == this)
		{
			this.m.IsSpent = true;
		}

		this.m.TilesMovedThisTurn = 0;
	}

	q.onTurnStart = @(__original) function()
	{
		this.m.IsSpent = false;
	}

	q.onTurnEnd = @(__original) function()
	{
		__original();
		this.m.TilesMovedThisTurn = 0;
	}

	q.onMovementStarted = @(__original) function( _tile, _numTiles )
	{
		__original(_tile, _numTiles);
		this.m.PrevTile = _tile;
	}

	q.onMovementFinished = @(__original) function( _tile )
	{
		__original(_tile);
		this.m.TilesMovedThisTurn += _tile.getDistanceTo(this.m.PrevTile);
	}

// MSU Functions
	q.onAffordablePreview = @() function( _skill, _movementTile )
	{
		if (!this.isEnabled()) return;

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

	q.getItemActionCost = @() function( _items )
	{
		if (this.m.IsSpent) return null;

		local sourceItem = _items[0];
		local targetItem = _items.len() > 1 ? _items[1] : null;

		if (sourceItem == null)		// Fix for when other mods break convention and have the first item in the array be the destination item (e.g. Extra Keybinds)
		{
			sourceItem = targetItem;
			targetItem = null;
		}

		if (sourceItem.isItemType(::Const.Items.ItemType.Weapon) && sourceItem.isWeaponType(::Const.Items.WeaponType.Throwing))
		{
			if (targetItem == null)	// Either the target is an empty slot
			{
				return 0;
			}

			if (targetItem.isItemType(::Const.Items.ItemType.Weapon) && targetItem.isWeaponType(::Const.Items.WeaponType.Throwing))
			{
				if (sourceItem.m.Ammo == 0 || targetItem.m.Ammo == 0)	// Or either of the two throwing weapons is empty
				{
					return 0;
				}
			}
		}

		return null;
	}

	q.onPayForItemAction <- function( _skill, _items )
	{
		if (_skill == this)
		{
			this.m.IsSpent = true;
		}
	}

// New Functions
	q.isEnabled <- function()
	{
		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Throwing))
		{
			return false;
		}

		return true;
	}
});
