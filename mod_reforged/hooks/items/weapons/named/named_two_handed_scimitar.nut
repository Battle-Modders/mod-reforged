::Reforged.HooksMod.hook("scripts/items/weapons/named/named_two_handed_scimitar", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/oriental/two_handed_scimitar";
		__original();
	}

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

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
