this.rf_heraldic_cape_upgrade <- ::inherit("scripts/items/armor_upgrades/armor_upgrade", {
	m = {
		ResolveModifier = 5
	},
	function create()
	{
		this.armor_upgrade.create();
		this.m.ID = "armor_upgrade.rf_heraldic_cape";
		this.m.Name = "Heraldic Cape";
		this.m.Description = "A flowing cape worn by esteemed noble guards to signify their status.";
		this.m.ArmorDescription = "A distinctive cape has been added to this armor, increasing its attractiveness and boosting the wearer\'s resolve.";
		this.m.Value = 200;
		this.m.ConditionModifier = 5;
		this.m.StaminaModifier = 1;
		this.setVariant(::Math.rand(1, 10));
	}

	function updateVariant()
	{
		local variant = this.m.Variant >= 10 ? this.m.Variant : "0" + this.m.Variant;

		this.m.Icon = "armor_upgrades/rf_heraldic_cape_upgrade_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_rf_heraldic_cape_upgrade_" + variant + ".png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_rf_heraldic_cape_upgrade_" + variant + ".png";

		this.m.SpriteFront = "rf_heraldic_cape_" + variant + "_front";
		this.m.SpriteBack = "rf_heraldic_cape_" + variant + "_back";
		this.m.SpriteDamagedFront = "rf_heraldic_cape_" + variant + "_front_damaged";
		this.m.SpriteDamagedBack = "rf_heraldic_cape_" + variant + "_back_damaged";
		this.m.SpriteCorpseFront = "rf_heraldic_cape_" + variant + "_front_dead";
		this.m.SpriteCorpseBack = "rf_heraldic_cape_" + variant + "_back_dead";
	}

	function getTooltip()
	{
		local result = this.armor_upgrade.getTooltip();
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/armor_body.png",
			text = ::MSU.Text.colorizeValue(this.m.ConditionModifier, {AddSign = true}) + " Durability"
		});
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = ::MSU.Text.colorizeValue(this.m.ResolveModifier, {AddSign = true}) + " Resolve"
		});

		if (this.m.StaminaModifier != 0)
		{
			result.push({
				id = 16,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::MSU.Text.colorizeValue(-1 * this.m.StaminaModifier, {AddSign = true}) + " Maximum Fatigue"
			});
		}

		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = ::MSU.Text.colorizeValue(this.m.ResolveModifier, {AddSign = true}) + " Resolve"
		});
	}

	function onUpdateProperties( _properties )
	{
		this.armor_upgrade.onUpdateProperties(_properties);
		_properties.Bravery += this.m.ResolveModifier;
	}
});
