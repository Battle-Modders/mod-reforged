::Reforged.HooksMod.hook("scripts/items/weapons/named/named_sword", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/noble_sword";
		__original();
	}

	q.onEquip = @(__original) function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/slash"));

		this.addSkill(::MSU.new("scripts/skills/actives/riposte"));
	}
});
