::mods_hookExactClass("items/weapons/oriental/two_handed_scimitar", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 5;
		this.m.ShieldDamage = 16;
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.RF_Southern;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cleave", function(o) {
			o.m.FatigueCost += 3;
			o.m.Icon = "skills/active_210.png";
			o.m.IconDisabled = "skills/active_210_sw.png";
			o.m.Overlay = "active_210";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/decapitate"));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.FatigueCost += 5;
		}));
	}
});
