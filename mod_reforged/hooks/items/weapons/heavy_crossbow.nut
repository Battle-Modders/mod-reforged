::Reforged.HooksMod.hook("scripts/items/weapons/heavy_crossbow", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 0;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::new("scripts/skills/actives/shoot_bolt"));

		// Always add reload skill to DummyPlayer so that it appears in nested tooltips of weapons
		if (!this.m.IsLoaded || ::MSU.isEqual(this.getContainer().getActor(), ::MSU.getDummyPlayer()))
		{
			this.addSkill(::new("scripts/skills/actives/reload_bolt"));
		}
	}}.onEquip;

	q.addSkill = @(__original) { function addSkill( _skill )
	{
		if (_skill.getID() == "actives.reload_bolt")
		{
			_skill.m.ActionPointCost += 1;
		}

		__original(_skill);
	}}.addSkill;
});
