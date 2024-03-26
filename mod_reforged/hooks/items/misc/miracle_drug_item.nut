::Reforged.HooksMod.hook("scripts/items/misc/miracle_drug_item", function(q) {
	{
		__original();
		this.m.Value = 300;
	}
});
