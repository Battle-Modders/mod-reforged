::Reforged.HooksMod.hook("scripts/items/weapons/oriental/handgonne", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 0;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::new("scripts/skills/actives/fire_handgonne_skill"));

		// Always add reload skill to DummyPlayer so that it appears in nested tooltips of weapons
		if (!this.m.IsLoaded || ::MSU.isEqual(this.getContainer().getActor(), ::MSU.getDummyPlayer()))
		{
			local reload = ::Reforged.new("scripts/skills/actives/reload_handgonne_skill", function(o) {
				o.m.FatigueCost += 2;
			});
			this.addSkill(reload);
		}
	}}.onEquip;
});
