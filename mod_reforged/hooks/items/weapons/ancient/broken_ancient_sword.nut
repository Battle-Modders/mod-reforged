::Reforged.HooksMod.hook("scripts/items/weapons/ancient/broken_ancient_sword", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 3;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/slash", function(o) {
			o.m.FatigueCost -= 2;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/riposte", function(o) {
			o.m.FatigueCost -= 5;
		}));
	}}.onEquip;
});
