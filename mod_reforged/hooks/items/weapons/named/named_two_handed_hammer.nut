::Reforged.HooksMod.hook("scripts/items/weapons/named/named_two_handed_hammer", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/two_handed_hammer";

	q.onEquip = @() { function onEquip()
	{
		this.named_weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/smite_skill"));

		this.addSkill(::Reforged.new("scripts/skills/actives/shatter_skill"));

		this.addSkill(::Reforged.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
		}));
	}}.onEquip;
});
