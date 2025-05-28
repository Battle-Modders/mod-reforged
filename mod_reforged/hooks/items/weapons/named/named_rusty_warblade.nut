::Reforged.HooksMod.hook("scripts/items/weapons/named/named_rusty_warblade", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/barbarians/rusty_warblade";

	q.onEquip = @() { function onEquip()
	{
		this.named_weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/cleave", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 3;
			o.m.Icon = "skills/active_182.png";
			o.m.IconDisabled = "skills/active_182_sw.png";
			o.m.Overlay = "active_182";
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/decapitate", function(o) {
			o.m.ActionPointCost += 2;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
		}));
	}}.onEquip;
});
