::Reforged.HooksMod.hook("scripts/skills/actives/flurry_skill", function(q) {
	q.m.NumAttacks <- 6;

	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("An unpredictable melee blunt attack that strikes six times, distributing the hits evenly among all adjacent enemies.");
	}}.create;

	// Overwrite, because Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		return this.skill.getDefaultTooltip();
	}}.getTooltip;

	// Rewrite the vanilla function so that the user will always perform the full number of attacks
	// and won't waste scheduled attacks for entities that die during the flurry.
	q.onUse = @() { function onUse( _user, _targetTile )
	{
		::Sound.play(::MSU.Array.rand(this.m.SoundOnHit), 1.0, _targetTile.Pos);
		::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " unleashes a flurry of blows around it");
		local ownTile = _user.getTile();

		local tag = {
			User = _user,
			TargetEntities = ::MSU.Tile.getNeighbors(ownTile).filter(@(_, _t) _t.IsOccupiedByActor && ::Math.abs(_t.Level - ownTile.Level) <= 1 && !_user.isAlliedWith(_t.getEntity())).map(@(_t) _t.getEntity()),
			CurrentIndex = 0,
			NumAttacks = this.m.NumAttacks,
			Callback = this.RF_doFlurry.bindenv(this)
		};

		this.getContainer().setBusy(true);
		this.RF_doFlurry(tag);
		return true;
	}}.onUse;

	// New function. Used as callback from onUse.
	// Performs an attack and schedules the next attack on the next valid clockwise tile.
	q.RF_doFlurry <- { function doFlurry( _tag )
	{
		if (!_tag.User.isAlive())
			return;

		local targetEntity = _tag.TargetEntities[_tag.CurrentIndex];
		if (!targetEntity.isAlive() || !targetEntity.isAttackable())
		{
			// The array will shrink due to removal, so decrement the index so our order stays correct.
			_tag.TargetEntities.remove(_tag.CurrentIndex--);
		}
		else
		{
			this.spawnAttackEffect(targetEntity.getTile(), ::Const.Tactical.AttackEffectChop);
			this.attackEntity(_tag.User, targetEntity);
			_tag.NumAttacks--;
		}

		if (_tag.NumAttacks == 0 || _tag.TargetEntities.len() == 0)
		{
			this.getContainer().setBusy(false);
		}
		else
		{
			if (++_tag.CurrentIndex >= _tag.TargetEntities.len())
			{
				_tag.CurrentIndex = 0;
			}
			::Time.scheduleEvent(::TimeUnit.Virtual, 200, _tag.Callback, _tag);
		}
	}}.doFlurry;
});
