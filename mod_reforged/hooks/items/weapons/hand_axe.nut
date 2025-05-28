::Reforged.HooksMod.hook("scripts/items/weapons/hand_axe", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 3;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/chop", function(o) {
			o.m.FatigueCost -= 1;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/split_shield", function(o) {
			o.setApplyAxeMastery(true)
			o.m.FatigueCost -= 1;
		}));
	}}.onEquip;
});
