::Reforged.HooksMod.hook("scripts/items/weapons/ancient/crypt_cleaver", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 5;
		this.m.DirectDamageAdd = 0.05; // Brings the total to 30%
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/cleave", function(o) {
			o.m.FatigueCost += 3;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/decapitate"));

		this.addSkill(::Reforged.new("scripts/skills/actives/split_shield", function(o) {
			o.m.FatigueCost += 5;
		}));
	}}.onEquip;
});
