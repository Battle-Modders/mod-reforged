::Reforged.HooksMod.hook("scripts/items/weapons/named/named_cleaver", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/military_cleaver";
		__original();
	}

	q.onEquip = @(__original) function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cleave"));

		this.addSkill(::MSU.new("scripts/skills/actives/decapitate"));
	}
});
