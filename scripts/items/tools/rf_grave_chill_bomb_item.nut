this.rf_grave_chill_bomb_item <- ::inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.rf_grave_chill_bomb";
		this.m.Name = "Gravedust Pot";
		this.m.Description = "A fragile pot filled with fine dust prepared by grinding the remnants of nightmarish creatures. The dust seems to have strong psychotic effects, with even a quick whiff triggering intense feelings of gloom and despair. Can be thrown at short ranges.";
		this.m.IconLarge = "tools/rf_grave_chill_bomb_01.png";
		this.m.Icon = "tools/rf_grave_chill_bomb_01_70x70.png";
		this.m.SlotType = ::Const.ItemSlot.Offhand;
		this.m.ItemType = ::Const.Items.ItemType.Tool;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_rf_grave_chill_bomb_01";
		this.m.Value = 400;
		this.m.RangeMax = 3;
		this.m.StaminaModifier = 0;
		this.m.IsDroppedAsLoot = true;

		this.m.ArmorDamageMult = 0.0;
	}

	function getTooltip()
	{
		// Set range to 0 to avoid adding tooltip about it
		local rangeMax = this.m.RangeMax;
		this.m.RangeMax = 0;

		local ret = this.weapon.getTooltip();

		this.m.RangeMax = rangeMax;

		ret.push({
			id = 64,
			type = "text",
			text = "Worn in Offhand"
		});

		local throwSkill = ::new("scripts/skills/actives/rf_throw_grave_chill_bomb_skill");
		throwSkill.m.Container = ::MSU.getDummyPlayer().getSkills();
		ret.extend(throwSkill.getTooltip().slice(3)); // slice 3 to remove name, description and cost string
		throwSkill.m.Container = null;

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Is destroyed on use"
		});
		return ret;
	}

	function playInventorySound( _eventType )
	{
		::Sound.play("sounds/bottle_01.wav", ::Const.Sound.Volume.Inventory);
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(::new("scripts/skills/actives/rf_throw_grave_chill_bomb_skill"));
	}
});
