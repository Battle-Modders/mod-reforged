::Reforged.HooksMod.hook("scripts/items/weapons/falchion", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 3;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/slash", function(o) {
			o.m.FatigueCost -= 1;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/riposte", function(o) {
			o.m.FatigueCost -= 3;
		}));
	}}.onEquip;
});
