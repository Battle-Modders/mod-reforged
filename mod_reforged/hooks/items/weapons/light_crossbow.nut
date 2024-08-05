::Reforged.HooksMod.hook("scripts/items/weapons/light_crossbow", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::new("scripts/skills/actives/shoot_bolt"));

		local reload = ::Reforged.new("scripts/skills/actives/reload_bolt", function(o) {
			o.m.FatigueCost -= 5;
		});
		this.addSkill(reload);
	}
});
