::mods_hookExactClass("items/weapons/named/named_warbrand", function(o) {
	local create = o.create;
	o.create = function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/warbrand";
		create();
	}

	o.onEquip = function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/slash", function(o) {
			o.m.FatigueCost += 2;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split", function(o) {
			o.m.FatigueCost -= 10;
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/swing", function(o) {
			o.m.FatigueCost -= 10;
		}));
	}
});
