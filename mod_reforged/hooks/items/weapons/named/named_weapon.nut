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
				this.setName(this.getContainer().getActor().getName() + "\'s " + ::MSU.Array.rand(this.m.NameList));
			}
			else
			{
				this.setName(this.createRandomName());
			}
		}
	}}.onPutIntoBag;

	q.onSerialize = @(__original) { function onSerialize( _out )
	{
		// Vanilla writes ChanceToHitHead as U8. In Reforged, we allow negative values too.
		// Vanilla writeU8 accepts negative values without throwing, but MSU SerDe Emulators
		// are strict and throw in such a case. So we switcheroo it to 0 and writeI8 later.
		local chanceToHitHead = this.m.ChanceToHitHead;
		this.m.ChanceToHitHead = 0;
		__original(_out);
		this.m.ChanceToHitHead = chanceToHitHead;
		_out.writeI8(chanceToHitHead);
	}}.onSerialize;

	q.onDeserialize = @(__original) { function onDeserialize( _in )
	{
		__original(_in);
		this.m.ChanceToHitHead = _in.readI8();
	}}.onDeserialize;
});
