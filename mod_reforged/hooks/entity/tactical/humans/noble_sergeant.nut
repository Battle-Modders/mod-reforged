::Reforged.HooksMod.hook("scripts/entity/tactical/humans/noble_sergeant", function(q) {
	q.onInit = @() function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Sergeant);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		this.getSprite("accessory_special").setBrush("sergeant_trophy");

		if (::Math.rand(1, 100) <= 33)
		{
			local suffix = ::MSU.Array.rand([1, 2, 4]);
			local sprite = this.getSprite("permanent_injury_" + suffix);
			sprite.setBrush("permanent_injury_0" + suffix);
			sprite.Visible = true;
		}

		this.m.Skills.add(::new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_onslaught"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_hold_steady"));
	}

	q.assignRandomEquipment = @() function()
	{
	    local banner = ::Tactical.State.isScenarioMode() ? this.getFaction() : ::World.FactionManager.getFaction(this.getFaction()).getBanner();
		this.m.Surcoat = banner;
		if (::Math.rand(1, 100) <= 80)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/fighting_axe"],
				[1, "scripts/items/weapons/military_cleaver"],
				[1, "scripts/items/weapons/warhammer"],
				[1, "scripts/items/weapons/winged_mace"],
				[1, "scripts/items/weapons/arming_sword"],
				[1, "scripts/items/weapons/rf_battle_axe"],
				[1, "scripts/items/weapons/rf_kriegsmesser"]
			]).roll()));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local script = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/mail_hauberk"],
				[1, "scripts/items/armor/reinforced_mail_hauberk"]
			]).roll();

			local armor = ::new(script);
			if (script == "scripts/items/armor/mail_hauberk")
				armor.setVariant(28);

			this.m.Items.equip(armor);
		}
	}

	q.onSetupEntity <- function()
	{
		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			::Reforged.Skills.addMasteryOfEquippedWeapon(this);
			if (weapon.isWeaponType(::Const.Items.WeaponType.Sword) || weapon.isWeaponType(::Const.Items.WeaponType.Axe) || weapon.isWeaponType(::Const.Items.WeaponType.Cleaver))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
			}
			else if (weapon.isWeaponType(::Const.Items.WeaponType.Hammer) || weapon.isWeaponType(::Const.Items.WeaponType.Mace))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rattle"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_sundering_strikes"));
			}
		}
	}
});
