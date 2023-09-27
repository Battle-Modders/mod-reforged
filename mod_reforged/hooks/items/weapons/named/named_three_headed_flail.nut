::Reforged.HooksMod.hook("scripts/items/weapons/named/named_three_headed_flail", function(q) {
	q.create = @(__original) function()
	{
		this.m.BaseWeaponScript = "scripts/items/weapons/three_headed_flail";
		__original();
	}

	q.onEquip = @(__original) function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::MSU.new("scripts/skills/actives/cascade_skill"));

		this.addSkill(::MSU.new("scripts/skills/actives/hail_skill"));
	}
});
