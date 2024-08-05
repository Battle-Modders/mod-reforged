::Reforged.HooksMod.hook("scripts/items/weapons/named/named_greataxe", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/greataxe";

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/split_man"));

		this.addSkill(::Reforged.new("scripts/skills/actives/round_swing"));

		this.addSkill(::Reforged.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
			o.setApplyAxeMastery(true);
		}));
	}
});
