::Reforged.HooksMod.hook("scripts/items/weapons/named/named_crossbow", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/heavy_crossbow";
		__original();
	}

	q.onEquip = @(__original) function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::new("scripts/skills/actives/shoot_bolt"));

		local reload = ::MSU.new("scripts/skills/actives/reload_bolt", function(o) {
			o.m.ActionPointCost += 1;
		});
		this.addSkill(reload);
	}
});
