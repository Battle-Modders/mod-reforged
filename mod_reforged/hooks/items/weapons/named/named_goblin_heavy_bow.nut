::Reforged.HooksMod.hook("scripts/items/weapons/named/named_goblin_heavy_bow", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/greenskins/goblin_heavy_bow";

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/quick_shot", function(o) {
			o.m.FatigueCost -= 2;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/aimed_shot", function(o) {
			o.m.FatigueCost -= 3;
		}));
	}
});
