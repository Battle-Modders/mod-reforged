::Reforged.HooksMod.hook("scripts/items/weapons/military_cleaver", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 4;
		this.m.RegularDamage = 45; // Increased from vanilla 40
		this.m.ArmorDamageMult = 0.85; // Reduced from vanilla 0.9
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cleave"));

		this.addSkill(::MSU.new("scripts/skills/actives/decapitate"));
	}
});
