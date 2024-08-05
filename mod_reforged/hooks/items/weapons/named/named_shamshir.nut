::Reforged.HooksMod.hook("scripts/items/weapons/named/named_shamshir", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/shamshir";

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/slash", function(o) {
			o.m.Icon = "skills/active_172.png";
			o.m.IconDisabled = "skills/active_172_sw.png";
			o.m.Overlay = "active_172";
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/gash_skill"));
	}
});
