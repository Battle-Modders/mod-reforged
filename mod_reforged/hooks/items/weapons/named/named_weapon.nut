::Reforged.HooksMod.hook("scripts/items/weapons/named/named_weapon", function(q) {
	q.getBaseItemFields = @(__original) function()
	{
		local ret = __original();
		ret.push("Reach");
		return ret;
	}

	q.onSerialize = @(__original) function( _out )
	{
		__original(_out);
		_out.writeI8(this.m.ChanceToHitHead);
	}

	q.onDeserialize = @(__original) function( _in )
	{
		__original(_in);
		this.m.ChanceToHitHead = _in.readI8();
	}
});
