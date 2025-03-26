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

	q.addSkill = @(__original) function( _skill )
	{
		if (_skill.getID() == "actives.reload_bolt")
		{
			_skill.m.ActionPointCost += 1;
		}

		__original(_properties);
	}
});
