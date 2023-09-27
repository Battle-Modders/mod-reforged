::Reforged.HooksMod.hook("scripts/items/weapons/named/named_axe", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/fighting_axe";
		__original();
	}

	q.onEquip = @(__original) function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/chop"));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.setApplyAxeMastery(true)
		}));
	}
});
