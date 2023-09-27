::Reforged.HooksMod.hook("scripts/items/weapons/named/named_bardiche", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/bardiche";
		__original();
	}

	q.onEquip = @(__original) function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/split_man", function(o) {
			o.m.Icon = "skills/active_168.png";
			o.m.IconDisabled = "skills/active_168_sw.png";
			o.m.Overlay = "active_168";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_axe"));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
			o.setApplyAxeMastery(true);
		}));
	}
});
