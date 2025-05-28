::Reforged.HooksMod.hook("scripts/items/weapons/scramasax", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 3;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/cleave", function(o) {
			o.m.FatigueCost -= 1;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/decapitate", function(o) {
			o.m.FatigueCost -= 2;
		}));
	}}.onEquip;
});
