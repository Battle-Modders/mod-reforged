::mods_hookExactClass("items/weapons/named/named_warbow", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/war_bow";
		create();
	}

	o.onEquip = function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/quick_shot", function(o) {
			o.m.FatigueCost += 2;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/aimed_shot", function(o) {
			o.m.ActionPointCost += 1;
			o.m.FatigueCost += 3;
		}));
	}
});
