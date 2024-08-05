::Reforged.HooksMod.hook("scripts/items/weapons/named/named_khopesh", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/ancient/khopesh";

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/cleave"));

		this.addSkill(::Reforged.new("scripts/skills/actives/decapitate"));
	}
});
