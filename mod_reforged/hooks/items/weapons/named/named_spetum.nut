::mods_hookExactClass("items/weapons/named/named_spetum", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/spetum";
		create();
	}

	o.onEquip = function()
	{
		this.named_weapon.onEquip();

		local prong = ::MSU.new("scripts/skills/actives/prong_skill");
		this.addSkill(prong);

		this.addSkill(::MSU.new("scripts/skills/actives/spearwall", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
			o.m.Icon = "skills/active_124.png";
			o.m.IconDisabled = "skills/active_124_sw.png";
			o.m.Overlay = "active_124";
			o.m.BaseAttackName = prong.getName();
		}));
	}
});
