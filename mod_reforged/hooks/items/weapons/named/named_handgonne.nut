::Reforged.HooksMod.hook("scripts/items/weapons/named/named_handgonne", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/oriental/handgonne";
		__original();
	}

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::new("scripts/skills/actives/fire_handgonne_skill"));

		this.addSkill(::MSU.new("scripts/skills/actives/reload_handgonne_skill", function(o) {
			o.m.FatigueCost += 2;
		}));
	}
});
