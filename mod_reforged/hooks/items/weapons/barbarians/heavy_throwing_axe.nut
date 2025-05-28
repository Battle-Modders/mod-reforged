::Reforged.HooksMod.hook("scripts/items/weapons/barbarians/heavy_throwing_axe", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 0;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/throw_axe", function(o) {
			o.m.FatigueCost += 1;
		}));
	}}.onEquip;
});
