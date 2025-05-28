::Reforged.HooksMod.hook("scripts/items/weapons/named/named_handgonne", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/oriental/handgonne";

	q.onEquip = @() { function onEquip()
	{
		this.named_weapon.onEquip();

		this.addSkill(::new("scripts/skills/actives/fire_handgonne_skill"));

		// Always add reload skill to DummyPlayer so that it appears in nested tooltips of weapons
		if (!this.m.IsLoaded || ::MSU.isEqual(this.getContainer().getActor(), ::MSU.getDummyPlayer()))
		{
			this.addSkill(::Reforged.new("scripts/skills/actives/reload_handgonne_skill", function(o) {
				o.m.FatigueCost += 2;
			}));
		}
	}}.onEquip;
});
