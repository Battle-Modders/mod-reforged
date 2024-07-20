::Reforged.HooksMod.hook("scripts/entity/tactical/humans/noble_billman", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Billman);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
	}

	q.assignRandomEquipment = @() function()
	{
		local banner = ::Tactical.State.isScenarioMode() ? this.getFaction() : ::World.FactionManager.getFaction(this.getFaction()).getBanner();
		this.m.Surcoat = banner;
		if (::Math.rand(1, 100) <= 90)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/billhook"],
				[1, "scripts/items/weapons/pike"],
				[1, "scripts/items/weapons/rf_poleflail"]
			]).roll()));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/gambeson"],
				[1, "scripts/items/armor/basic_mail_shirt"],
				[1, "scripts/items/armor/mail_shirt"]
			]).roll()));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet;
			if (::Math.rand(1, 100) <= 75)
			{
				if (banner <= 4)
				{
					helmet = ::new(::MSU.Class.WeightedContainer([
						[1, "scripts/items/helmets/mail_coif"],
						[1, "scripts/items/helmets/kettle_hat"],
						[1, "scripts/items/helmets/padded_kettle_hat"],
						[1, "scripts/items/helmets/rf_skull_cap"],
						[1, "scripts/items/helmets/rf_skull_cap_with_rondels"]
					]).roll());
				}
				else if (banner <= 7)
				{
					helmet = ::new(::MSU.Class.WeightedContainer([
						[1, "scripts/items/helmets/mail_coif"],
						[1, "scripts/items/helmets/flat_top_helmet"],
						[1, "scripts/items/helmets/padded_flat_top_helmet"],
						[1, "scripts/items/helmets/rf_skull_cap"],
						[1, "scripts/items/helmets/rf_skull_cap_with_rondels"]
					]).roll());
				}
				else
				{
					helmet = ::new(::MSU.Class.WeightedContainer([
						[1, "scripts/items/helmets/mail_coif"],
						[1, "scripts/items/helmets/nasal_helmet"],
						[1, "scripts/items/helmets/padded_nasal_helmet"],
						[1, "scripts/items/helmets/rf_skull_cap"],
						[1, "scripts/items/helmets/rf_skull_cap_with_rondels"]
					]).roll());
				}
			}
			else
			{
				helmet = ::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/helmets/aketon_cap"],
					[1, "scripts/items/helmets/full_aketon_cap"]
				]).roll());
			}

			helmet.setPlainVariant();
			this.m.Items.equip(helmet);
		}
	}

	q.onSetupEntity <- function()
	{
		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			::Reforged.Skills.addMasteryOfEquippedWeapon(this);
		}
	}
});
