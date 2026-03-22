::Reforged.Math <- {
	// Returns a random integer between _min and _max
	// If there is any _luck present then you have the chance for one or more rerolls returning only the value closest to _target
	function luckyRoll( _min, _max, _target, _luck = 0 )
	{
		local _randomNumber = ::Math.rand(_min, _max);
		for (; _luck > 0; _luck -= 100)
		{
			if (::Math.rand(1, 100) <= _luck)
			{
				_randomNumber = this.__getCloser(_randomNumber, ::Math.rand(_min, _max), _target);
			}
		}
		return _randomNumber;
	}

	// A negative _decimalPlaceOffset will result in an equal amounts of 0's left of the decimal place.
	// ceil(1234, -2) = 1300; ceil(1234, -1) = 1240; ceil(1234.5678, 2) = 1234.57;
	function ceil( _value, _decimalPlaceOffset = 0 )
	{
		_value *= ::Math.pow(10, _decimalPlaceOffset);
		_value = ::Math.ceil(_value);
		_value *= ::Math.pow(10, -_decimalPlaceOffset);
		return _value;
	}

	function __getCloser( _oldValue, _newValue, _target )
	{
		local oldDistance = ::Math.abs(_oldValue - _target);
		local newDistance = ::Math.abs(_newValue - _target);
		return (newDistance < oldDistance) ? _newValue : _oldValue;
	}

	// Uses values passed in vargv to seed the random number generator, then returns ::Math.rand(_min, _max)
	// also resets the random seed before returning.
	function randWithSeed( _min, _max, ... )
	{
		if (vargv.len() == 0)
			throw "must pass at least one seed argument";

		vargv.insert(0, this);
		::Reforged.Math.seedRandom.acall(vargv);

		local ret = ::Math.rand(_min, _max);
		// + vargv[0] so that calls to this function in the same frame with different seeds
		// don't always set the random seed to the same value
		::Math.seedRandom(::Time.getVirtualTimeF() + vargv[1]);
		return ret;
	}

	// Uses values passed in vargv to generate a seed as number and passes it to ::Math.seedRandom
	function seedRandom( ... )
	{
		if (vargv.len() == 0)
			throw "must pass at least one seed argument";

		if ("Assets" in ::World && !::MSU.isNull(::World.Assets))
		{
			vargv.push(::World.Assets.getCampaignID());
			vargv.push(::World.Assets.getSeedString());
			vargv.push(::World.Assets.getName());
		}

		local seed = 0;
		foreach (s in vargv)
		{
			switch (typeof s)
			{
				case "string":
					seed += ::toHash(s);
					break;

				case "bool":
					s = s ? 2 : 1; // 2:1 instead of 1:0 so that false also produces some difference in seed
				case "integer":
				case "float":
					seed += s * 10000;
					break;

				default:
					throw ::MSU.Exception.InvalidType(s);
			}
		}

		::Math.seedRandom(seed);
	}

	// Uses values passed in vargv to generate a seed as string and passes it to ::Math.seedRandomString
	function seedRandomString( ... )
	{
		if (vargv.len() == 0)
			throw "must pass at least one seed argument";

		if ("Assets" in ::World && !::MSU.isNull(::World.Assets))
		{
			vargv.push(::World.Assets.getCampaignID().tostring());
			vargv.push(::World.Assets.getSeedString());
			vargv.push(::World.Assets.getName());
		}

		local seed = "";
		foreach (s in vargv)
		{
			switch (typeof s)
			{
				case "string":
					seed += s;
					break;

				case "integer":
				case "float":
					seed += s.tostring();
					break;

				case "bool":
					seed += s ? "true" : "false";
					break;

				default:
					throw ::MSU.Exception.InvalidType(s);
			}
		}

		::Math.seedRandomString(seed);
	}

	// Returns the value of y at _x where the linear relationship
	// is defined by two given points (_x1, _y1) and (_x2, _y2)
	function lerp( _x, _x1, _y1, _x2, _y2 )
	{
		local m = (_y2 - _y1) / (_x2 - _x1).tofloat();
		local c = _y1 - m * _x1;
		return m * _x + c;
	}

	// Returns the value of y at _x along a path specified with
	// multiple points in the _points array where each point is
	// a len 2 array [x, y]. The path is linearly interpolated
	// between consecutive points.
	// The points in _points must be in increasing order of x.
	function multilerp( _x, _points )
	{
		local p1 = _points[0];
		local p2;

		// Use the two points between which _x lies.
		// If _x is greater than the last point's x then the last 2 points will be used.
		// If _x is smaller than the first point's x then the first 2 points will be used.
		for (local i = 1; i < _points.len(); i++)
		{
			p2 = _points[i];
			if (_x <= p2[0])
			{
				break;
			}
			p1 = p2;
		}

		return lerp(_x, p1[0], p1[1], p2[0], p2[1]);
	}

	// The return has the same type as that of _value
	function clamp( _value, _min, _max )
	{
		// Swap _min and _max if the user gave the values in wrong order.
		if (_min > _max)
		{
			local max = _max;
			_max = _min;
			_min = max;
		}

		local ret = _value < _min ? _min : (_value > _max ? _max : _value);
		return typeof _value == "integer" ? ret.tointeger() : ret.tofloat();
	}
}
