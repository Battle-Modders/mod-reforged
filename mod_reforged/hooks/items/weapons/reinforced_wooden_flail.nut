::Reforged.HooksMod.hook("scripts/items/weapons/reinforced_wooden_flail", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 3;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/flail_skill", function(o) {
			o.m.FatigueCost -= 1;
			o.m.Icon = "skills/active_65.png";
			o.m.IconDisabled = "skills/active_65_sw.png";
			o.m.Overlay = "active_65";
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/lash_skill", function(o) {
			o.m.FatigueCost -= 2;
			o.m.Icon = "skills/active_92.png";
			o.m.IconDisabled = "skills/active_92_sw.png";
			o.m.Overlay = "active_92";
		}));
	}}.onEquip;
});
