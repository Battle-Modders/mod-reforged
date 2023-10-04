::Reforged.HooksMod.hook("scripts/items/weapons/named/named_warbow", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/war_bow";
		__original();
	}

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/quick_shot"));

		this.addSkill(::MSU.new("scripts/skills/actives/aimed_shot"));
	}
});
