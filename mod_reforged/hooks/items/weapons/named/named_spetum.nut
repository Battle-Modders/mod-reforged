::Reforged.HooksMod.hook("scripts/items/weapons/named/named_spetum", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/spetum";

	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla 2800. Increased due to attacking twice with perk in Reforged.
		this.m.Value = 3500;
	}}.create;

	// No need to define onEquip because skills are copied from base weapon definition due to BaseItemScript
});
