::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/bandit_thug", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/rf_bandit_tough_agent");
		this.m.AIAgent.setActor(this);
	}

	q.onInit = @(__original) function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditThug);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (this.Math.rand(1, 100) <= 10)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_pox_01");
		}
		else if (this.Math.rand(1, 100) <= 15)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			this.getSprite("eye_rings").Visible = true;
		}

		this.getSprite("armor").Saturation = 0.8;
		this.getSprite("helmet").Saturation = 0.8;
		this.getSprite("helmet_damage").Saturation = 0.8;
		this.getSprite("shield_icon").Saturation = 0.8;
		this.getSprite("shield_icon").setBrightness(0.9);

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_survival_instinct"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon = ::MSU.Class.WeightedContainer([
	    		[1, "scripts/items/weapons/butchers_cleaver"],
				[1, "scripts/items/weapons/bludgeon"],
				[1, "scripts/items/weapons/hatchet"],
				[1, "scripts/items/weapons/pickaxe"],
				[1, "scripts/items/weapons/shortsword"],

				[1, "scripts/items/weapons/reinforced_wooden_flail"],
				[1, "scripts/items/weapons/goedendag"],
				[1, "scripts/items/weapons/two_handed_wooden_hammer"],
				[1, "scripts/items/weapons/woodcutters_axe"]
	    	]).roll();

			this.m.Items.equip(::new(weapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			local shield = ::MSU.Class.WeightedContainer([
				[0.5 , "scripts/items/shields/wooden_shield"],
				[0.5, "scripts/items/shields/buckler_shield"]
			]).rollChance(33);

			if (shield != null) this.m.Items.equip(::new(shield));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorBasic.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 35 || conditionMax > 90) return 0.0;
					if (conditionMax >= 35 || conditionMax < 50) return _weight * 0.5;
					if (conditionMax >= 80 || conditionMax <= 90) return _weight * 0.5;
					return _weight;
				}
			})
			this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head) && ::Math.rand(1, 100) > 30)
		{
			local helmet = ::Reforged.ItemTable.BanditHelmetBasic.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax > 70) return 0.0;
					if (conditionMax > 50 || conditionMax <= 70) return _weight * 0.5;
					return _weight;
				}
			})
			this.m.Items.equip(::new(helmet));
		}
	}
});
