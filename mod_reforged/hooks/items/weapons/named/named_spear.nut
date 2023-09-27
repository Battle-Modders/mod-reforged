::Reforged.HooksMod.hook("scripts/items/weapons/named/named_spear", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/fighting_spear";
		__original();
	}

	q.onEquip = @(__original) function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/thrust"));

		this.addSkill(::MSU.new("scripts/skills/actives/spearwall"));
	}
});
