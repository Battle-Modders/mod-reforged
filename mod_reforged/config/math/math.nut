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
}
