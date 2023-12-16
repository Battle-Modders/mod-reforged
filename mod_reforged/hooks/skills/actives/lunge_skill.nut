::Reforged.HooksMod.hook("scripts/skills/actives/lunge_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.HitChanceBonus = -20;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_AttackLunge;
	}

	q.isDuelistValid <- function()
	{
		return this.getBaseValue("ActionPointCost") <= 4;
	}

	q.getTooltip = @(__original) function()
	{
		local tooltip = __original();
		tooltip.insert(tooltip.len() - 1, {
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has " + ::MSU.Text.colorizePercentage(this.m.HitChanceBonus) + " chance to hit"
		});
		return tooltip;
	}

	q.onAdded <- function()
	{
		if (!this.getContainer().getActor().isPlayerControlled())
			this.getContainer().add(this.new("scripts/skills/actives/rf_lunge_charge_dummy_skill"));
	}

	q.onRemoved <- function()
	{
		this.getContainer().removeByID("actives.rf_lunge_charge_dummy");
	}

	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);
		if (_skill == this)
		{
			if (!this.getContainer().getActor().isPlayerControlled()) this.m.HitChanceBonus = 0;

			_properties.MeleeSkill += this.m.HitChanceBonus;
		}
	}

	q.getDestinationTile <- function( _targetTile, _originTile = null )
	{
		if (_originTile == null)
			_originTile = this.getContainer().getActor().getTile();

		local myTile = this.getContainer().getActor().getTile();

		local function isTileEmpty( _tile )
		{
			// myTile is always considered empty because if _originTile is not the same as myTile
			// then we are calculating usability of Lunge from a different tile after having moved from myTile
			return _tile.IsEmpty || _tile.isSameTileAs(myTile);
		}

		local destTiles = [];

		for (local i = 0; i < 6; i++)
		{
			if (!_targetTile.hasNextTile(i)) continue;

			local destTile = _targetTile.getNextTile(i);

			if (!isTileEmpty(destTile) || destTile.getDistanceTo(_originTile) > this.m.MaxRange - 1 || ::Math.abs(_targetTile.Level - destTile.Level) > 1)
				continue;

			// If a destination tile is adjacent to us, always choose that first
			if (this.m.MaxRange == 2 || destTile.getDistanceTo(_originTile) == 1)
			{
				if (::Math.abs(_originTile.Level - destTile.Level) <= 1) return destTile;
			}
			else
			{
				// Destination tiles at a distance of 2 can only be chosen if they have an adjacent empty tile that is adjacent to _originTile
				// i.e. we have a clear path to the Destination tile AND along the path we never change height elevation more than once.
				for (local j = 0; j < 6; j++)
				{
					if (!destTile.hasNextTile(j)) continue;

					local adjacentTile = destTile.getNextTile(j);
					if (isTileEmpty(adjacentTile) && _originTile.getDistanceTo(adjacentTile) == 1 && ::Math.abs(_originTile.Level - adjacentTile.Level) + ::Math.abs(adjacentTile.Level - destTile.Level) <= 1)
						destTiles.push(destTile);
				}				
			}
		}

		// No valid destination tile at a distance of 1. So, therefore, choose 
		// the first valid clockwise destination tile at a distance of 2.
		if (destTiles.len() != 0)
			return destTiles[0];
	}

	q.onVerifyTarget = @() function( _originTile, _targetTile )
	{
		return this.skill.onVerifyTarget(_originTile, _targetTile) && this.getDestinationTile(_targetTile, _originTile) != null;
	}

	q.onUse = @() function( _user, _targetTile )
	{
		local destTile = this.getDestinationTile(_targetTile);

		if (destTile == null) return false;

		this.getContainer().setBusy(true);
		local tag = {
			Skill = this,
			User = _user,
			OldTile = _user.getTile(),
			TargetTile = _targetTile,
			OnRepelled = this.onRepelled
		};
		_user.spawnTerrainDropdownEffect(_user.getTile());
		::Tactical.getNavigator().teleport(_user, destTile, this.onTeleportDone.bindenv(this), tag, false, 3.0);
		return true;
	}
});
