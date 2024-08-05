::Reforged.HooksMod.hook("scripts/items/weapons/named/named_bardiche", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/bardiche";

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/split_man", function(o) {
			o.m.Icon = "skills/active_168.png";
			o.m.IconDisabled = "skills/active_168_sw.png";
			o.m.Overlay = "active_168";
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/split_axe"));

		this.addSkill(::Reforged.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
			o.setApplyAxeMastery(true);
		}));
	}
});
