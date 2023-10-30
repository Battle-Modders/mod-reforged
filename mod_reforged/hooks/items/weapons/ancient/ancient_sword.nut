::Reforged.HooksMod.hook("scripts/items/weapons/ancient/ancient_sword", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 3;
		this.setWeaponType(::Const.Items.WeaponType.Sword | ::Const.Items.WeaponType.Dagger);
	}

	q.onEquip = @() function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/stab", function(o) {
			o.m.Icon = "skills/rf_sword_stab_skill.png";
			o.m.IconDisabled = "skills/rf_sword_stab_skill_sw.png";
			o.m.Overlay = "rf_sword_stab_skill";
			o.m.DirectDamageMult = this.m.DirectDamageMult;
		}.bindenv(this)));

		this.addSkill(::MSU.new("scripts/skills/actives/slash", function(o) {
			o.m.FatigueCost -= 1;
		}));
	}
});
