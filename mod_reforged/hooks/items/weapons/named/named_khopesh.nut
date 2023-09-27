::Reforged.HooksMod.hook("scripts/items/weapons/named/named_khopesh", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/ancient/khopesh";
		__original();
	}

	q.onEquip = @(__original) function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cleave"));

		this.addSkill(::MSU.new("scripts/skills/actives/decapitate"));
	}
});
