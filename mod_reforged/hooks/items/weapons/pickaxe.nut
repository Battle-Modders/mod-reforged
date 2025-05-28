::Reforged.HooksMod.hook("scripts/items/weapons/pickaxe", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 3;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/hammer", function(o) {
			o.m.FatigueCost -= 2;
			o.m.Icon = "skills/active_60.png";
			o.m.IconDisabled = "skills/active_60_sw.png";
			o.m.Overlay = "active_60";
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/crush_armor", function(o) {
			o.m.FatigueCost -= 3;
			o.m.Icon = "skills/active_59.png";
			o.m.IconDisabled = "skills/active_59_sw.png";
			o.m.Overlay = "active_59";
		}));
	}}.onEquip;
});
