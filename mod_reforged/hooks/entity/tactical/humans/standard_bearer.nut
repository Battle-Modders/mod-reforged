::Reforged.HooksMod.hook("scripts/entity/tactical/humans/standard_bearer", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.StandardBearer);
		b.TargetAttractionMult = 1.5;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		this.m.Skills.add(::new("scripts/skills/perks/perk_inspiring_presence"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rally_the_troops"));
	}

	q.assignRandomEquipment = @() function()
	{
		local banner = ::Tactical.State.isScenarioMode() ? this.getFaction() : ::World.FactionManager.getFaction(this.getFaction()).getBanner();
		this.m.Surcoat = banner;
		this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon = ::new("scripts/items/tools/faction_banner");
			weapon.setVariant(banner);
			this.m.Items.equip(weapon);
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local script = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/mail_hauberk"],
				[1, "scripts/items/armor/mail_shirt"],
				[2, "scripts/items/armor/basic_mail_shirt"]
			]).roll();

			local armor = ::new(script);
			if (script == "scripts/items/armor/mail_hauberk")
				armor.setVariant(28);

			this.m.Items.equip(armor);
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet;
			if (::Math.rand(1, 100) <= 75)
			{
				if (banner <= 4)
				{
					helmet = ::new(::MSU.Class.WeightedContainer([
						[1, "scripts/items/helmets/kettle_hat"],
						[1, "scripts/items/helmets/padded_kettle_hat"]
					]).roll());
				}
				else if (banner <= 7)
				{
					helmet = ::new(::MSU.Class.WeightedContainer([
						[1, "scripts/items/helmets/flat_top_helmet"],
						[1, "scripts/items/helmets/padded_flat_top_helmet"]
					]).roll());
				}
				else
				{
					helmet = ::new(::MSU.Class.WeightedContainer([
						[1, "scripts/items/helmets/nasal_helmet"],
						[1, "scripts/items/helmets/padded_nasal_helmet"]
					]).roll());
				}
			}
			else
			{
				helmet = ::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/helmets/mail_coif"],
					[1, "scripts/items/helmets/aketon_cap"],
					[1, "scripts/items/helmets/full_aketon_cap"]
				]).roll());
			}

			helmet.setPlainVariant();
			this.m.Items.equip(helmet);
		}
	}
});
