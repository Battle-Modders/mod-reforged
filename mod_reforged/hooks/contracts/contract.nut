::Reforged.HooksMod.hook("scripts/contracts/contract", function(q)
{
	// This is a close copy of how vanilla calculates their distance duration in getDaysRequiredToTravel
	q.getSecondsRequiredToTravel <- function( _numTiles, _speed, _onRoadOnly = false )
	{
		_speed *= ::Const.World.MovementSettings.GlobalMult;
		if (_onRoadOnly) _speed *= ::Const.World.MovementSettings.RoadMult;
		return _numTiles * 170.0 / _speed;
	}

	q.getUICharacterImage = @(__original) function( _index = 0 )
	{
		if ((!("Characters" in this.m.ActiveScreen) || !this.m.ActiveScreen.Characters.len()) &&
			(!("Banner" in this.m.ActiveScreen) || _index == 0) &&
			"ShowEmployer" in this.m.ActiveScreen &&
			this.m.ActiveScreen.ShowEmployer &&
			_index != 0 &&
			"Destination" in this.m &&
			this.m.Destination != null &&
			!this.m.Destination.isNull() &&
			this.m.Destination.isLocation() &&
			this.m.Destination.isLocationType(::Const.World.LocationType.Settlement) &&
			this.m.Destination.isDiscovered()
		)
		{
			return {
				Image = this.m.Destination.getImagePath(),
				IsProcedural = false
			};
		}
		else
		{
			return __original(_index);
		}
	}
});
