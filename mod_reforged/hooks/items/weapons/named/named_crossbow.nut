::Reforged.HooksMod.hook("scripts/items/weapons/named/named_crossbow", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/heavy_crossbow";

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::new("scripts/skills/actives/shoot_bolt"));

		local reload = ::Reforged.new("scripts/skills/actives/reload_bolt", function(o) {
			o.m.ActionPointCost += 1;
		});
		this.addSkill(reload);
	}
});
