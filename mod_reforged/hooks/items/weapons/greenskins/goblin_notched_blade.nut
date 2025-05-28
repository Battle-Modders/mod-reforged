::Reforged.HooksMod.hook("scripts/items/weapons/greenskins/goblin_notched_blade", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 3;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/slash", function(o) {
			o.m.ActionPointCost -= 1;
			o.m.FatigueCost -= 2;
			o.m.Icon = "skills/active_77.png";
			o.m.IconDisabled = "skills/active_77_sw.png";
			o.m.Overlay = "active_77";
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/puncture", function(o) {
			o.m.FatigueCost -= 3;
		}));
	}}.onEquip;
});
