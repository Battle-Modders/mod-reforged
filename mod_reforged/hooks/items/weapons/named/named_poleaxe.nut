::Reforged.HooksMod.hook("scripts/items/weapons/named/named_poleaxe", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/poleaxe";

	q.onEquip = @() { function onEquip()
	{
		// Legacy subclasses call this parent before Modular Vanilla adds the base weapon's skills.
		this.named_weapon.onEquip();
	}}.onEquip;
});
