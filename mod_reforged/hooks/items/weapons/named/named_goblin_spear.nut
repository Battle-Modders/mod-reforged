::Reforged.HooksMod.hook("scripts/items/weapons/named/named_goblin_spear", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/greenskins/goblin_spear";
		__original();
	}

	q.onEquip = @(__original) function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/thrust", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 4;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/spearwall", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 12;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/riposte", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 10;
		}));
	}
});
