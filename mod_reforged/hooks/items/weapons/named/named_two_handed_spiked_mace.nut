::Reforged.HooksMod.hook("scripts/items/weapons/named/named_two_handed_spiked_mace", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/barbarians/two_handed_spiked_mace";
		__original();
	}

	q.onEquip = @(__original) function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cudgel_skill", function(o) {
			o.m.Icon = "skills/active_178.png";
			o.m.IconDisabled = "skills/active_178_sw.png";
			o.m.Overlay = "active_178";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/strike_down_skill", function(o) {
			o.m.Icon = "skills/active_179.png";
			o.m.IconDisabled = "skills/active_179_sw.png";
			o.m.Overlay = "active_179";
		}));

		this.addSkill(::MSU.new("scripts/skills/actives/split_shield", function(o) {
			o.m.ActionPointCost += 2;
			o.m.FatigueCost += 5;
		}));
	}
});
