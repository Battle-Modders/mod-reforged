::Reforged.HooksMod.hook("scripts/items/weapons/named/named_crypt_cleaver", function(q) {
	q.m.BaseItemScript = "scripts/items/weapons/ancient/crypt_cleaver";

	q.onEquip = @() function()
	{
		this.named_weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/cleave", function(o) {
			o.m.FatigueCost += 3;
		}));

		this.addSkill(::Reforged.new("scripts/skills/actives/decapitate"));

		this.addSkill(::Reforged.new("scripts/skills/actives/split_shield", function(o) {
			o.m.FatigueCost += 5;
		}));
	}
});
