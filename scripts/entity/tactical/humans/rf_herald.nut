this.rf_herald <- ::inherit("scripts/entity/tactical/human" {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_Herald;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_Herald.XP;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.Military;
		this.m.HairColors = ::Const.HairColors.Old;
		this.m.Beards = ::Const.Beards.Tidy;
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/military_standard_bearer_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		local addSprite = this.addSprite;
		this.addSprite = function( _sprite )
		{
			if (_sprite == "surcoat")
			{
				local ret = addSprite(_sprite);
				addSprite("rf_surcoat_adornment"); // TODO: Once item layers are available then this won't be necessary and the onFactionChanged and onDeath functions can be removed
				return ret;
			}
			return addSprite(_sprite);
		}
		this.human.onInit();
		this.addSprite = addSprite;

		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_Herald);
		b.TargetAttractionMult = 1.5;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		this.m.Skills.add(::new("scripts/skills/perks/perk_inspiring_presence"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rally_the_troops"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exude_confidence"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_command"));
	}

	function onFactionChanged()
	{
		this.human.onFactionChanged();
		this.getSprite("rf_surcoat_adornment").setHorizontalFlipping(!this.isAlliedWithPlayer());
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
		if (_tile != null)
		{
			local decal = _tile.spawnDetail(::String.replace(this.getSprite("rf_surcoat_adornment").getBrush().Name, "bust_body", "bust_rf_body") + "_dead", ::Const.Tactical.DetailFlag.Corpse, this.m.IsCorpseFlipped, false, ::Const.Combat.HumanCorpseOffset);
			decal.Scale = 0.9;
			decal.setBrightness(0.9);
		}
	}

	function assignRandomEquipment()
	{
		local banner = ::Tactical.State.isScenarioMode() ? this.getFaction() : ::World.FactionManager.getFaction(this.getFaction()).getBanner();
		this.m.Surcoat = banner;
		this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		this.getSprite("rf_surcoat_adornment").setBrush("bust_body_noble_0" + ::MSU.Array.rand([1, 3, 9]));

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
				[1, "scripts/items/armor/light_scale_armor"]
			]).roll();

			local armor = ::new(script);
			if (script == "scripts/items/armor/mail_hauberk")
				armor.setVariant(28);

			this.m.Items.equip(armor);
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::new("scripts/items/helmets/greatsword_faction_helm");
			helmet.setVariant(banner);
			this.m.Items.equip(helmet);
		}
	}
});

