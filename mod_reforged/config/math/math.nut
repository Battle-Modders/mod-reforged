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

	// Standard Linear Interpolation. Returns a value between _a and _b based on percentage progress _t (0.0 to 1.0).
	// Example: lerp(10, 20, 0.5) returns 15 (50% progress).
	function lerp( _a, _b, _t )
	{
		return _a + (_b - _a) * _t;
	}

	// Linear Interpolation by X. Returns y at _x on the line defined by (_x1, _y1) and (_x2, _y2).
	// Useful for scaling values based on ranges, e.g. mapping Days to Strength.
	// Example: lerpX(5, 0, 10, 10, 20) returns 15 (At x=5, halfway between 0 and 10, y is halfway between 10 and 20).
	function lerpX( _x, _x1, _y1, _x2, _y2 )
	{
		if (_x1 == _x2) return _y1;
		return this.lerp(_y1, _y2, (_x - _x1) / (_x2 - _x1).tofloat());
	}

	function lerpXClamp( _x, _x1, _y1, _x2, _y2 )
	{
		return this.clamp(this.lerpX(_x, _x1, _y1, _x2, _y2), _y1, _y2);
	}

	// Piecewise Linear Interpolation. Returns y at _x based on an array of [x, y] points sorted in ascending x.
	// Useful for complex scaling requirements that change at specific thresholds.
	// Example: lerpSequence(50, [[0, 0], [40, 10], [100, 100]]) returns 25 (Interpolates between [40, 10] and [100, 100]).
	function lerpXSeq( _x, _points )
	{
		local i = 0;
		local count = _points.len() - 2;

		while (i < count && _x > _points[i + 1][0])
		{
			i++;
		}

		local p1 = _points[i];
		local p2 = _points[i + 1];
		return this.lerp(_x, p1[0], p1[1], p2[0], p2[1]);
	}

	// Power Interpolation. Returns a value between _a and _b based on percentage progress _t (0.0 to 1.0) raised to _exponent.
	// _exponent > 1.0 eases in (starts slow), _exponent < 1.0 eases out (starts fast).
	// Example: perp(0, 100, 0.5, 2.0) returns 25 (0.5^2 = 0.25 progress).
	function perp( _a, _b, _t, _exponent = 1.0 )
	{
		return _a + (_b - _a) * ::Math.pow(_t, _exponent);
	}

	// Power Interpolation by X. Returns y at _x between two points using an exponential curve.
	// Useful for non-linear scaling over a range.
	// Example: perpX(5, 0, 0, 10, 100, 2.0) returns 25.
	function perpX( _x, _x1, _y1, _x2, _y2, _exponent = 1.0 )
	{
		if (_x1 == _x2) return _y1;
		return this.perp(_y1, _y2, (_x - _x1) / (_x2 - _x1).tofloat(), _exponent);
	}

	// Power Interpolation through a point. Calculates the exponent required to pass through (_xm, _ym) and returns y at _x.
	// Useful when you want a curve to hit a specific milestone (e.g. at day 20, difficulty should be 50).
	// Useful when you don't want to manually calculate the exponent but know the trend your curve should follow.
	function perpThrough( _x, _x1, _y1, _xm, _ym, _x2, _y2 )
	{
		if (_x1 == _x2 || _y1 == _y2)
		{
			// If the start and end points are the same, or if there is no vertical range, fallback to linear interpolation.
			return this.lerpX(_x, _x1, _y1, _x2, _y2);
		}

		// Normalize the midpoint's X (t) and Y (u) relative to the start/end range to get a 0.0-1.0 value.
		local t = (_xm - _x1) / (_x2 - _x1).tofloat();
		local u = (_ym - _y1) / (_y2 - _y1).tofloat();

		if (t <= 0 || t >= 1 || u <= 0)
		{
			// Check if the midpoint is valid. It must be strictly between start/end X, and positive in Y relative to start.
			// If invalid, fallback to linear.
			return this.lerpX(_x, _x1, _y1, _x2, _y2);
		}

		// Solve for exponent: u = t^exponent  =>  log(u) = exponent * log(t)  =>  exponent = log(u) / log(t).
		return this.perpX(_x, _x1, _y1, _x2, _y2, ::log(u) / ::log(t));
	}

	// Similar to clamp, but allows the value to overshoot the boundaries.
	// Upon overshooting it is moved towards the nearest boundary by _t amount.
	// A _t of 1.0 is the same as clamping.
	function compress( _a, _min, _max, _t )
	{
		// Swap _min and _max if the user gave the values in wrong order.
		if (_min > _max)
		{
			local max = _max;
			_max = _min;
			_min = max;
		}

		if (_a < _min)
			_a = this.lerp(_a, _min, _t);
		else if (_a > _max)
			_a = this.lerp(_a, _max, _t);

		return _a;
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
