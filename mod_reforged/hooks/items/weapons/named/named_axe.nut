::mods_hookExactClass("items/weapons/named/named_axe", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/fighting_axe";
		create();
	}

	o.onEquip = function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/chop", function(o) {
			o.m.FatigueCost += 1
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.FatigueCost += 2;
			o.setApplyAxeMastery(true)
		}));
	}
});
