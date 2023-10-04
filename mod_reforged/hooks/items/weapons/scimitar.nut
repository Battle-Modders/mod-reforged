::Reforged.HooksMod.hook("scripts/items/weapons/scimitar", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 4;
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.RF_Southern;
	}

	q.onEquip = @() function()
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
