::Reforged.HooksMod.hook("scripts/items/weapons/greenskins/goblin_pike", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 7;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/rupture", function(o) {
			o.m.Icon = "skills/active_80.png";
			o.m.IconDisabled = "skills/active_80_sw.png";
			o.m.Overlay = "active_80";
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/repel", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 5;
		}));
	}}.onEquip;
});
