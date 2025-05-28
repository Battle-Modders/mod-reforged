::Reforged.HooksMod.hook("scripts/items/weapons/woodcutters_axe", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 5;
		this.m.ShieldDamage = 30;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/split_man", function(o) {
			o.m.ActionPointCost -= 1;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/round_swing", function(o) {
			o.m.FatigueCost -= 5;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 1;
			o.m.FatigueCost += 5;
			o.setApplyAxeMastery(true);
		}));
	}}.onEquip;
});
