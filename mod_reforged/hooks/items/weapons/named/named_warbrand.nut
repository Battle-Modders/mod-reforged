::Reforged.HooksMod.hook("scripts/items/weapons/named/named_warbrand", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/warbrand";
		__original();
	}

	q.onEquip = @(__original) function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/slash", function(o) {
			o.m.FatigueCost += 3;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 10;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/swing", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 10;
		}));
	}
});
