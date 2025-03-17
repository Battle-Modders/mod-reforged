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
			this.addSkill(::new("scripts/skills/actives/reload_bolt"));
		}
	}

	q.onAfterUpdateProperties = @(__original) function( _properties )
	{
		__original(_properties);
		foreach (s in this.getSkills())
		{
			if (s.getID() == "actives.reload_bolt")
			{
				s.m.ActionPointCost += 1;
			}
		}
	}
});
