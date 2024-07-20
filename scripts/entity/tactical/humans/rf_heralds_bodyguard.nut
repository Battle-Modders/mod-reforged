this.rf_heralds_bodyguard <- ::inherit("scripts/entity/tactical/human" {
	m = {
		HelmetAdornment = {
			Sprite = "",
			SpriteDamaged = "",
			SpriteDead = "",
			IsDamaged = false
		}
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_HeraldsBodyguard;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_HeraldsBodyguard.XP;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.CommonMale;
		this.m.HairColors = ::Const.HairColors.Young;
		this.m.Beards = ::Const.Beards.Tidy;
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);

		// TODO: This code is untested and probably won't be necessary once item layers are available - Midas
		// this.m.ShakeLayers = clone this.m.ShakeLayers;
		// this.m.ShakeLayers[::Const.BodyPart.Head] = clone this.m.ShakeLayers[::Const.BodyPart.Head];
		// this.m.ShakeLayers[::Const.BodyPart.Head].push("rf_helmet_adornment");
		// this.m.ShakeLayers[::Const.BodyPart.All] = clone this.m.ShakeLayers[::Const.BodyPart.All];
		// this.m.ShakeLayers[::Const.BodyPart.All].push("rf_helmet_adornment");
	}

	function onInit()
	{
		local addSprite = this.addSprite;
		this.addSprite = function( _sprite )
		{
			if (_sprite == "helmet_damage")
			{
				local ret = addSprite(_sprite);
				addSprite("rf_helmet_adornment"); // TODO: Once item layers are available then this won't be necessary and the onFactionChanged, onDeath, onDamageReceived functions can be removed
				return ret;
			}
			return addSprite(_sprite);
		}
		this.human.onInit();
		this.addSprite = addSprite;

		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_HeraldsBodyguard);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_finesse"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_skirmisher"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_vigilant"));
		this.m.Skills.add(::MSU.new("scripts/skills/special/rf_bodyguard", function(o) { // TODO: Probably need a better way of doing this (hopefully when onCombatStart is available for AI actors) - Midas
			o.onCombatStarted <- function()
			{
				local actor = this.getContainer().getActor();
				foreach (ally in ::Tactical.Entities.getInstancesOfFaction(actor.getFaction()))
				{
					if (ally.getType() == ::Const.EntityType.RF_Herald)
					{
						this.setVIP(ally);
						return;
					}
				}
			}
		}));
	}

	function onFactionChanged()
	{
		this.human.onFactionChanged();
		this.getSprite("rf_helmet_adornment").setHorizontalFlipping(!this.isAlliedWithPlayer());
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
		if (_tile != null && this.m.HelmetAdornment.SpriteDead != "")
		{
			local decal = _tile.spawnDetail(this.m.HelmetAdornment.SpriteDead, ::Const.Tactical.DetailFlag.Corpse, this.m.IsCorpseFlipped, false, ::Const.Combat.HumanCorpseOffset);
			decal.Scale = 0.9;
			decal.setBrightness(0.9);
		}
	}

	function onDamageReceived( _attacker, _skill, _hitInfo )
	{
		local ret = this.human.onDamageReceived(_attacker, _skill, _hitInfo);
		if (!this.m.HelmetAdornment.IsDamaged && this.isAlive() && this.isPlacedOnMap())
		{
			local helmet = this.getHeadItem();
			if (helmet != null && helmet.getCondition() / helmet.getConditionMax() <= ::Const.Combat.ShowDamagedArmorThreshold && this.m.HelmetAdornment.SpriteDamaged != "")
			{
				this.m.HelmetAdornment.IsDamaged = true;
				this.getSprite("rf_helmet_adornment").setBrush(this.m.HelmetAdornment.SpriteDamaged);
			}
		}
		return ret;
	}

	function assignRandomEquipment()
	{
		local banner = ::Tactical.State.isScenarioMode() ? this.getFaction() : ::World.FactionManager.getFaction(this.getFaction()).getBanner();
		this.m.Surcoat = banner;
		this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		this.m.HelmetAdornment.Sprite = "faction_helmet_2_" + (banner < 10 ? "0" + banner : banner);
		this.m.HelmetAdornment.SpriteDamaged = this.m.HelmetAdornment.Sprite + "_damaged";
		this.m.HelmetAdornment.SpriteDead = this.m.HelmetAdornment.Sprite + "_dead";
		this.getSprite("rf_helmet_adornment").setBrush(this.m.HelmetAdornment.Sprite);

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/longsword"],
				[1, "scripts/items/weapons/rf_poleaxe"]
			]).roll()));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/rf_brigandine_harness"],
				[1, "scripts/items/armor/rf_reinforced_footman_armor"],
				[1, "scripts/items/armor/scale_armor"]
			]).roll()));
		}

		this.getBodyItem().setUpgrade(::MSU.new("scripts/items/armor_upgrades/rf_heraldic_cape_upgrade", function(o) {
			o.setVariant(banner);
		}));

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/helmets/rf_sallet_helmet_with_bevor"],
				[1, "scripts/items/helmets/rf_half_closed_sallet_with_mail"],
				[1, "scripts/items/helmets/full_helm"]
			]).roll());

			helmet.setPlainVariant();
			this.m.Items.equip(helmet);

			if (helmet.ClassName == "full_helm")
				this.setSpriteOffset("rf_helmet_adornment", ::createVec(0, 5));
		}
	}

	function onSetupEntity()
	{
		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			::Reforged.Skills.addMasteryOfEquippedWeapon(this);

			if (weapon.isWeaponType(::Const.Items.WeaponType.Sword))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_double_strike"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_pattern_recognition"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_swordmaster_grappler"));
			}
			else if (weapon.isWeaponType(::Const.Items.WeaponType.Axe))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_calculated_strikes"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
			}

			if (weapon.getID() == "weapon.rf_poleaxe")
			{
				local entityNamePlural = ::Const.Strings.EntityNamePlural[this.getType()];
				weapon.addSkill(::MSU.new("scripts/skills/actives/repel", function(o) {
					o.m.Name = "Guard\'s Repel";
					local getTooltip = o.getTooltip;
					o.getTooltip = function()
					{
						local ret = getTooltip();
						ret.push({
							id = 7,
							type = "text",
							icon = "ui/icons/warning.png",
							text = ::MSU.Text.colorRed("This skill is only available to " + entityNamePlural + " using a " + weapon.getName())
						})
						return ret;
					}
				}));
			}
		}
	}
});

