::Reforged.HooksMod.hook("scripts/items/weapons/barbarians/axehammer", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 3;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/hammer", function(o) {
			o.m.Icon = "skills/active_184.png";
			o.m.IconDisabled = "skills/active_184_sw.png";
			o.m.Overlay = "active_184";
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/split_shield", function(o) {
			o.setApplyAxeMastery(true);
		}));
	}}.onEquip;
});
