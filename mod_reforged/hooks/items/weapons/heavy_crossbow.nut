::Reforged.HooksMod.hook("scripts/items/weapons/heavy_crossbow", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::new("scripts/skills/actives/shoot_bolt"));

		// Always add reload skill to DummyPlayer so that it appears in nested tooltips of weapons
		if (!this.m.IsLoaded || ::MSU.isEqual(this.getContainer().getActor(), ::MSU.getDummyPlayer()))
		{
			local reload = ::Reforged.new("scripts/skills/actives/reload_bolt", function(o) {
				o.m.ActionPointCost += 1;
			});
			this.addSkill(reload);
		}
	}
});
