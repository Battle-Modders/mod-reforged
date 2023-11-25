this.rf_closed_bascinet <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.rf_closed_bascinet";
		this.m.Name = "Closed Bascinet with Mail";
		this.m.Description = "A well-made closed bascinet offering excellent protection.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.Variant = ::Math.rand(1, 6);
		this.m.VariantString = "rf_closed_bascinet"
		this.updateVariant();
		this.m.ImpactSound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = ::Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 2400;
		this.m.Condition = 260;
		this.m.ConditionMax = 260;
		this.m.StaminaModifier = -17;
		this.m.Vision = -3;
	}

	function onPaint( _color )
	{
		switch (_color)
		{
			case ::Const.Items.Paint.None:
				this.m.Variant = 1;
				break;

			case ::Const.Items.Paint.Black:
				this.m.Variant = 2;
				break;

			case ::Const.Items.Paint.WhiteBlue:
				this.m.Variant = 3;
				break;

			case ::Const.Items.Paint.WhiteGreenYellow:
				this.m.Variant = 4;
				break;

			case ::Const.Items.Paint.OrangeRed:
				this.m.Variant = 5;
				break;

			case ::Const.Items.Paint.Red:
				this.m.Variant = 6;
				break;
		}

		this.updateVariant();
		this.updateAppearance();
	}
});
