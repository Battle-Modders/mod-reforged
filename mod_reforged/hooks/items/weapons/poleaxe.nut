::Reforged.HooksMod.hook("scripts/items/weapons/poleaxe", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.Reach = 5;
		this.m.WeaponType = ::Const.Items.WeaponType.Axe | ::Const.Items.WeaponType.Polearm;
		this.m.ItemType = ::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.MeleeWeapon | ::Const.Items.ItemType.TwoHanded;
	}}.create;

	q.onEquip = @() { function onEquip()
	{
		this.weapon.onEquip();

		this.addSkill(::new("scripts/skills/actives/rf_hew_skill"));

		this.addSkill(::new("scripts/skills/actives/smite_skill"));

		this.addSkill(::new("scripts/skills/actives/assault_skill"));
        
		this.addSkill(::new("scripts/skills/actives/rf_assault_hew_skill"));
	}}.onEquip;
});
