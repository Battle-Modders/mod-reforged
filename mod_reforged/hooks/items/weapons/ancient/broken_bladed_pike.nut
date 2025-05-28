::Reforged.HooksMod.hook("scripts/items/weapons/ancient/broken_bladed_pike", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 6;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/impale", function(o) {
			o.m.FatigueCost -= 1;
			o.m.Icon = "skills/active_54.png";
			o.m.IconDisabled = "skills/active_54_sw.png";
			o.m.Overlay = "active_54";
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/repel", function(o) {
			o.m.FatigueCost -= 2;
		}));
	}}.onEquip;
});
