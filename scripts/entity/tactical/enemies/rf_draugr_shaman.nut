this.rf_draugr_shaman <- ::inherit("scripts/entity/tactical/enemies/rf_draugr", {
	m = {},
	function create()
	{
		this.rf_draugr.create();

		this.m.Type = ::Const.EntityType.RF_DraugrShaman;
		this.m.XP = ::Const.Tactical.Actor.RF_DraugrShaman.XP;
		this.m.ResurrectionValue = 10.5;
		this.setName(::Const.Strings.EntityName[this.m.Type]);
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/rf_draugr_shaman_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.rf_draugr.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_DraugrShaman);
		b.TargetAttractionMult = 3.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.Skills.add(::new("scripts/skills/actives/rf_ancestral_summons_skill"));
		this.m.Skills.add(::new("scripts/skills/effects/rf_barrow_chant_effect"));
		this.m.Skills.add(::new("scripts/skills/effects/rf_unnerving_presence_effect"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_vigilant"));
	}

	function assignRandomEquipment()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::MSU.Class.WeightedContainer().addMany(1, [
				"rf_draugr_skull_headdress",
				"rf_draugr_ritual_headpiece",
				"rf_draugr_white_bear_headpiece"
			]).roll();

			this.m.Items.equip(::new("scripts/items/helmets/rf_draugr/" + helmet));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local headpiece = this.getHeadItem();
			if (headpiece != null && headpiece.ClassName == "rf_draugr_white_bear_headpiece")
			{
				this.m.Items.equip(::new("scripts/items/armor/rf_draugr/rf_draugr_white_bear_fur_mantle"));
			}
			else
			{
				local armor = ::MSU.Class.WeightedContainer().addMany(1, [
					"rf_draugr_skull_wraps",
					"rf_draugr_wolf_fur_mantle"
				]).roll();

				this.m.Items.equip(::new("scripts/items/armor/rf_draugr/" + armor));
			}
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(this.new("scripts/items/weapons/rf_draugr/rf_draugr_shaman_staff"));
		}
	}

	function onCombatStart()
	{
		// Remove objects to the west of the starting position as we don't want
		// the shaman to be hidden behind obstacles from the player's perspective.
		local myTile = this.getTile();
		foreach (dir in [4, 5])
		{
			if (!myTile.hasNextTile(dir))
				continue;

			local tile = myTile.getNextTile(dir);
			if (!tile.IsEmpty && !tile.IsOccupiedByActor)
			{
				tile.removeObject();
			}
		}

		this.rf_draugr.onCombatStart();
	}
});
