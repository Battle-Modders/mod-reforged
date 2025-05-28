::Reforged.HooksMod.hook("scripts/items/weapons/greenskins/goblin_bow", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 0;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/quick_shot", function(o) {
			o.m.FatigueCost -= 3;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/aimed_shot", function(o) {
			o.m.FatigueCost -= 5;
		}));
	}}.onEquip;
});
