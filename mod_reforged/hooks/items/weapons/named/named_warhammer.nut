::Reforged.HooksMod.hook("scripts/items/weapons/named/named_warhammer", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/warhammer";
		__original();
	}

	q.onEquip = @(__original) function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/hammer"));

		this.addSkill(::MSU.new("scripts/skills/actives/crush_armor"));
	}
});
