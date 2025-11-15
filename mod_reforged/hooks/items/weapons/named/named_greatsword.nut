::Reforged.HooksMod.hook("scripts/items/weapons/named/named_greatsword", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/greatsword";
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Variant = ::Math.rand(1, 4);
		this.updateVariant();
	}}.create;

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
