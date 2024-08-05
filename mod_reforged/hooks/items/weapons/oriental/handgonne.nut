::Reforged.HooksMod.hook("scripts/items/weapons/oriental/handgonne", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::new("scripts/skills/actives/fire_handgonne_skill"));

		local reload = ::Reforged.new("scripts/skills/actives/reload_handgonne_skill", function(o) {
			o.m.FatigueCost += 2;
		});
		this.addSkill(reload);
	}
});
