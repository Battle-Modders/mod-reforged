::Reforged.HooksMod.hook("scripts/items/weapons/named/named_weapon", function(q) {
	q.getBaseItemFields = @(__original) { function getBaseItemFields()
	{
		local ret = __original();
		ret.push("Reach");
		return ret;
	}}.getBaseItemFields;

	q.onSerialize = @(__original) { function onSerialize( _out )
	{
		__original(_out);
		_out.writeI8(this.m.ChanceToHitHead);
	}}.onSerialize;

	q.onDeserialize = @(__original) { function onDeserialize( _in )
	{
		__original(_in);
		this.m.ChanceToHitHead = _in.readI8();
	}}.onDeserialize;
});
