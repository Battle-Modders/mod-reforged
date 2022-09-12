::mods_hookExactClass("items/weapons/named/named_weapon", function(o) {
	local onSerialize = o.onSerialize;
	o.onSerialize = function( _out )
	{
		onSerialize(_out);
		_out.writeI8(this.m.ChanceToHitHead);
	}

	local onDeserialize = o.onDeserialize;
	o.onDeserialize = function( _in )
	{
		onDeserialize(_in);
		this.m.ChanceToHitHead = _in.readI8();
	}
});
