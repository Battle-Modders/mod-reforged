::Reforged.HooksMod.hook("scripts/items/weapons/named/named_warbrand", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/warbrand";

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/slash", function(o) {
			o.m.FatigueCost += 3;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/split", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 10;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/swing", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 10;
		}));
	}
});
