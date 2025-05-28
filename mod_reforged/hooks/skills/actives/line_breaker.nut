::Reforged.HooksMod.hook("scripts/skills/actives/line_breaker", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Shove them out of your way and move forward, breaking their ranks.";
	}}.create;

	// Vanilla does not have a tooltip function for this skill.
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.getDefaultUtilityTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Pushes back the target and moves you into their position"
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Inflicts " + ::MSU.Text.colorNegative("10") + " extra [fatigue|Concept.Fatigue]")
		});
		return ret;
	}}.getTooltip;

	// Fixes vanilla issue where Line Breaker cannot push characters off ledges
	q.findTileToKnockBackTo = @() { function findTileToKnockBackTo( _userTile, _targetTile )
	{
		local getValidTileInDir = function( _dir )
		{
			if (_targetTile.hasNextTile(_dir))
			{
				local tile = _targetTile.getNextTile(_dir);
				if (tile.IsEmpty && (tile.Level <= _targetTile.Level || tile.Level - _targetTile.Level == 1))
				{
					return tile;
				}
			}

			return null;
		}

		local dir = _userTile.getDirectionTo(_targetTile);
		local knockToTile = getValidTileInDir(dir);

		if (knockToTile != null) return knockToTile;

		local altdir = dir - 1 >= 0 ? dir - 1 : 5;
		knockToTile = getValidTileInDir(altdir);

		if (knockToTile != null) return knockToTile;

		altdir = dir + 1 <= 5 ? dir + 1 : 0;
		knockToTile = getValidTileInDir(altdir);
		
		if (knockToTile != null) return knockToTile;

		return null;
	}}.findTileToKnockBackTo;

	// We delay the onFollow of this skill by another 100ms because otherwise the entity doesn't follow through with this function properly when at very high speeds using some faster combat speed mods
	q.onFollow = @(__original) { function onFollow( _tag )
	{
		if (::Time.getVirtualSpeed() > 2)
		{
			::Time.scheduleEvent(::TimeUnit.Virtual, 100, __original, _tag);
		}
		else
		{
			__original(_tag);
		}
	}}.onFollow;
});
