::Reforged.HooksMod.hook("scripts/items/weapons/boar_spear", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 5;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/thrust", function(o) {
			o.m.FatigueCost -= 1;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/spearwall", function(o) {
			o.m.FatigueCost -= 3;
		}));
	}}.onEquip;
});
