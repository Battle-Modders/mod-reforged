::Reforged.HooksMod.hook("scripts/items/weapons/named/named_goblin_pike", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/greenskins/goblin_pike";
		__original();
	}

	q.onEquip = @(__original) function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/rupture", function(o) {
			o.m.Icon = "skills/active_80.png";
			o.m.IconDisabled = "skills/active_80_sw.png";
			o.m.Overlay = "active_80";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/repel", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 5;
		}));
	}
});
