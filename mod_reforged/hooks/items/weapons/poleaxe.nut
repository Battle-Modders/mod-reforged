::Reforged.HooksMod.hook("scripts/items/weapons/poleaxe", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 5;
		this.m.WeaponType = ::Const.Items.WeaponType.Axe | ::Const.Items.WeaponType.Polearm;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
		this.m.Categories = "Axe/Polearm, Two-Handed";
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::Reforged.new("scripts/skills/actives/rf_hew_skill"));

		this.addSkill(::Reforged.new("scripts/skills/actives/assault_skill"));
        
		this.addSkill(::Reforged.new("scripts/skills/actives/rf_assault_hew_skill"));

		local skillToAdd = ::Reforged.new("scripts/skills/actives/smite_skill");
		skillToAdd.m.Icon = "skills/active_241.png";
		skillToAdd.m.IconDisabled = "skills/active_241_sw.png";
		skillToAdd.m.Overlay = "active_241";
		skillToAdd.m.IsPolearm = true;
		skillToAdd.m.DirectDamageMult = 0.4;
		this.addSkill(skillToAdd);

		this.addSkill(::Reforged.new("scripts/skills/actives/split_shield", function(o) {
			o.m.FatigueCost += 5;
			o.setApplyAxeMastery(true);
		}));
	}}.onEquip;
});
