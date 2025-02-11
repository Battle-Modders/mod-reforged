::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/bandit_marksman", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BanditMarksman);
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (::Math.rand(1, 100) <= 20)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
			dirt.Alpha = ::Math.rand(150, 255);
		}

		this.getSprite("armor").Saturation = 0.85;
		this.getSprite("helmet").Saturation = 0.85;
		this.getSprite("helmet_damage").Saturation = 0.85;
		this.getSprite("shield_icon").Saturation = 0.85;
		this.getSprite("shield_icon").setBrightness(0.85);

		b.Vision = 8;

		this.m.Skills.add(::new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));	// Now granted to all humans by default
	}

	q.assignRandomEquipment = @() function()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local r = ::Math.rand(1, 2);

			if (r == 1)
			{
				this.m.Items.equip(::new("scripts/items/weapons/hunting_bow"));
				this.m.Items.equip(::new("scripts/items/ammo/quiver_of_arrows"));
			}
			else
			{
				this.m.Items.equip(::new("scripts/items/weapons/crossbow"));
				this.m.Items.equip(::new("scripts/items/ammo/quiver_of_bolts"));
			}
		}

		this.m.Items.addToBag(::new("scripts/items/weapons/dagger"));

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorRanged.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 50 || conditionMax > 70) return 0.0;
					return _weight;
				}
			})

			if (armor != null)
			{
				this.m.Items.equip(::new(armor));

				if (::Math.rand(1, 100) <= ::Reforged.Config.ArmorAttachmentChance.Tier3)
				{
					local armorAttachment = ::Reforged.ItemTable.ArmorAttachmentNorthern.roll({
						Apply = function ( _script, _weight )
						{
							local conditionModifier = ::ItemTables.ItemInfoByScript[_script].ConditionModifier;
							if (conditionModifier > 20) return 0.0;
							return _weight;
						}
					})

					if (armorAttachment != null)
						this.getBodyItem().setUpgrade(::new(armorAttachment));
				}
			}
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::Reforged.ItemTable.BanditHelmetRanged.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 40 || conditionMax > 70) return 0.0;
					return _weight;
				}
			})
			if (helmet != null) this.m.Items.equip(::new(helmet));
		}
	}

	q.onSpawned = @() function()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
		}
	}
});
