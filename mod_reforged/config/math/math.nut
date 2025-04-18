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

	function seededRand( _seed, _min, _max )
	{
		::Reforged.Math.seedRandom(_seed);
		local ret = ::Math.rand(_min, _max);
		// + _seed so that calls to this function in the same frame with different seeds
		// don't always set the random seed to the same value
		::Math.seedRandom(::Time.getVirtualTimeF() + _seed);
		return ret;
	}

	function seedRandom( ... )
	{
		if ("Assets" in ::World && !::MSU.isNull(::World.Assets))
		{
			vargv.push(::World.Assets.getCampaignID());
		}

		local seed = 0;
		foreach (s in vargv)
		{
			switch (typeof s)
			{
				case "string":
					seed += ::toHash(s);
					break;

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

	function seedRandomString( ... )
	{
		if ("Assets" in ::World && !::MSU.isNull(::World.Assets))
		{
			vargv.push(::World.Assets.getCampaignID().tostring());
		}

		local seed = 0;
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

				default:
					throw ::MSU.Exception.InvalidType(s);
			}
		}

		::Math.seedRandomString(seed);
	}
}
