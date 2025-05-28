::Reforged.HooksMod.hook("scripts/items/weapons/military_pick", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 3;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/hammer", function(o) {
			o.m.FatigueCost -= 1;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/crush_armor", function(o) {
			o.m.FatigueCost -= 2;
		}));
	}}.onEquip;
});
