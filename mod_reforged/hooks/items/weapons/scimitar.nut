::mods_hookExactClass("items/weapons/scimitar", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Reach = 4;
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.RF_Southern;
		this.m.FlipIconX = true;
		this.m.FlipIconY = true;
		this.m.FlipIconLargeX = true;
		this.m.FlipIconLargeY = true;
	}

	o.onEquip = function()
	{
		this.weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/slash", function(o) {
			o.m.FatigueCost -= 1;
			o.m.Icon = "skills/active_172.png";
			o.m.IconDisabled = "skills/active_172_sw.png";
			o.m.Overlay = "active_172";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/gash_skill", function(o) {
			o.m.FatigueCost -= 2;
		}));
	}
});
