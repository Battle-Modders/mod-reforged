::Reforged.HooksMod.hook("scripts/items/weapons/named/named_weapon", function(q) {
	q.getBaseItemFields = @(__original) { function getBaseItemFields()
	{
		local ret = __original();
		ret.push("Reach");
		return ret;
	}}.getBaseItemFields;

	q.onPutIntoBag = @(__original) { function onPutIntoBag()
	{
		__original();

		// Same logic as in vanilla onEquip function to create name for named weapon
		if (this.m.Name.len() == 0)
		{
			if (::Math.rand(1, 100) <= 25)
			{
				this.setName(this.getContainer().getActor().getName() + "\'s " + this.m.NameList[::Math.rand(0, this.m.NameList.len() - 1)]);
			}
			else
			{
				this.setName(this.createRandomName());
			}
		}
	}}.onPutIntoBag;

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
