if (!::Hooks.hasMod("mod_swifter"))
{
	return;
}

::Reforged.QueueBucket.Late.push(function() {
	::Reforged.HooksMod.hook("scripts/entity/tactical/actor", function(q) {
		// Slow down based on VirtualSpeed so that render animations of ghost, spider etc. don't run at faster speeds.
		q.moveSpriteOffset = @(__native) { function moveSpriteOffset( _name, _from, _to, _duration, _startAtTime )
		{
			return __native(_name, _from, _to, _duration * ::Time.getVirtualSpeed(), _startAtTime);
		}}.moveSpriteOffset;

		// Speed up based on VirtualSpeed. Hopefully solves crashes with Kraken tentacles.
		q.riseFromGround = @(__original) { function riseFromGround( _speedMult = 1.0 )
		{
			__original(_speedMult * ::Time.getVirtualSpeed());
		}}.riseFromGround;

		// Speed up based on VirtualSpeed. Hopefully solves crashes with Kraken tentacles.
		q.sinkIntoGround = @(__original) { function sinkIntoGround( _speedMult = 1.0 )
		{
			__original(_speedMult * ::Time.getVirtualSpeed());
		}}.sinkIntoGround;
	});
});

// Speed up based on VirtualSpeed.
local teleport_6 = ::TacticalNavigator["__sqrat_ol_ teleport_6"];
::TacticalNavigator["__sqrat_ol_ teleport_6"] <- { function teleport( _user, _targetTile, _func, _data, _bool, _speedMult )
{
	teleport_6(_user, _targetTile, _func, _data, _bool, _speedMult * ::Time.getVirtualSpeed());
}}.teleport;
