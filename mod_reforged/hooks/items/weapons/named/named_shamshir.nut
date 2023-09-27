::Reforged.HooksMod.hook("scripts/items/weapons/named/named_shamshir", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/shamshir";
		__original();
		this.m.ItemType = this.m.ItemType | ::Const.Items.ItemType.RF_Southern;
	}

	q.onEquip = @(__original) function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/slash", function(o) {
			o.m.Icon = "skills/active_172.png";
			o.m.IconDisabled = "skills/active_172_sw.png";
			o.m.Overlay = "active_172";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/gash_skill"));
	}
});
