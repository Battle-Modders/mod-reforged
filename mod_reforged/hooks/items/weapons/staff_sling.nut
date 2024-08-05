::Reforged.HooksMod.hook("scripts/items/weapons/staff_sling", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
		this.setWeaponType(::Const.Items.WeaponType.Sling | ::Const.Items.WeaponType.Throwing);
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/sling_stone_skill", function(o) {
			o.m.FatigueCost -= 2;
		}));
	}
});
