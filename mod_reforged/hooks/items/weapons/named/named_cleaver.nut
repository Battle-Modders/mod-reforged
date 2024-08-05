::Reforged.HooksMod.hook("scripts/items/weapons/named/named_cleaver", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/military_cleaver";

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/cleave"));

		this.addSkill(::Reforged.new("scripts/skills/actives/decapitate"));
	}
});
