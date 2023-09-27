::Reforged.HooksMod.hook("scripts/items/weapons/named/named_goblin_heavy_bow", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/greenskins/goblin_heavy_bow";
		__original();
	}

	q.onEquip = @(__original) function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/quick_shot", function(o) {
			q.m.FatigueCost -= 2;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/aimed_shot", function(o) {
			o.m.FatigueCost -= 3;
		}));
	}
});
