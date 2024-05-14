::Reforged.HooksMod.hook("scripts/items/weapons/ancient/crypt_cleaver", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 5;
		this.m.DirectDamageAdd = 0.05; // Brings the total to 30%
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cleave", function(o) {
			o.m.FatigueCost += 3;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/decapitate"));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.FatigueCost += 5;
		}));
	}
});
