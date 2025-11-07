::Reforged.HooksMod.hook("scripts/skills/actives/lunge_skill", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.HitChanceBonus = -20;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_AttackLunge;
	}}.create;

	q.isDuelistValid <- { function isDuelistValid()
	{
		return this.getBaseValue("ActionPointCost") <= 4;
	}}.isDuelistValid;

	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		ret.insert(ret.len() - 1, {
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has " + ::MSU.Text.colorizeValue(this.m.HitChanceBonus, {AddSign = true, AddPercent = true}) + " chance to hit"
		});
		return ret;
	}}.getTooltip;

	q.onAnySkillUsed = @(__original) { function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);
		if (_skill == this)
		{
			if (!this.getContainer().getActor().isPlayerControlled()) this.m.HitChanceBonus = 0;

			_properties.MeleeSkill += this.m.HitChanceBonus;
		}
	}}.onAnySkillUsed;

	q.getDestinationTile <- { function getDestinationTile( _targetTile, _originTile = null )
	{
		local myTile = this.getContainer().getActor().getTile();

		if (_originTile == null)
			_originTile = myTile;

		local function isTileEmpty( _tile )
		{
			// myTile is always considered empty because if _originTile is not the same as myTile
			// then we are calculating usability of Lunge from a different tile after having moved from myTile
			return _tile.IsEmpty || _tile.isSameTileAs(myTile);
		}

		// Destination has to be 1 tile closer than MaxRange because MaxRange targets an actor and we have to land next to him
		local maxDist = this.m.MaxRange - 1;
		local destTiles = [];

		foreach (destTile in ::MSU.Tile.getNeighbors(_targetTile).filter(@(_, _t) isTileEmpty(_t) && _t.getDistanceTo(_originTile) <= maxDist && ::Math.abs(_targetTile.Level - _t.Level) <= 1))
		{
			// If a destination tile is adjacent to us, always choose that first
			if (this.m.MaxRange == 2 || destTile.getDistanceTo(_originTile) == 1)
			{
				if (::Math.abs(_originTile.Level - destTile.Level) <= 1)
					return destTile;
			}
			else
			{
				// Destination tiles at a distance of 2 can only be chosen if they have an adjacent empty tile that is adjacent to _originTile
				// i.e. we have a clear path to the Destination tile AND along the path we never change height elevation more than once.
				if (::MSU.Tile.getNeighbors(destTile).filter(@(_, _t) isTileEmpty(_t) && _t.getDistanceTo(_originTile) == 1 && ::Math.abs(_originTile.Level - _t.Level) + ::Math.abs(_t.Level - destTile.Level) <= 1).len() != 0)
				{
					destTiles.push(destTile);
				}
			}
		}

		// No valid destination tile at a distance of 1. So, therefore, choose
		// the first valid clockwise destination tile at a distance of 2.
		if (destTiles.len() != 0)
			return destTiles[0];
	}}.getDestinationTile;

	q.onVerifyTarget = @() { function onVerifyTarget( _originTile, _targetTile )
	{
		return this.skill.onVerifyTarget(_originTile, _targetTile) && this.getDestinationTile(_targetTile, _originTile) != null;
	}}.onVerifyTarget;

	q.onUse = @() { function onUse( _user, _targetTile )
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
	}}.onUse;
});
