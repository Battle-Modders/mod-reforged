::Reforged.HooksMod.hook("scripts/items/weapons/named/named_estoc", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/estoc";

	q.onEquip = @() { function onEquip()
	{
		// Legacy subclasses call this parent before Modular Vanilla adds the base weapon's skills.
		this.named_weapon.onEquip();
	}}.onEquip;
});
