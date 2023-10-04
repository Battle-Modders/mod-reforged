::Reforged.HooksMod.hook("scripts/items/weapons/named/named_mace", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/winged_mace";
		__original();
	}

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/bash"));

		this.addSkill(::MSU.new("scripts/skills/actives/knock_out"));
	}
});
