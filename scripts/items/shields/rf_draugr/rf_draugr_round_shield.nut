this.rf_draugr_round_shield <- this.inherit("scripts/items/shields/shield", {
	m = {},
	function create()
	{
		this.shield.create();
		this.m.ID = "shield.rf_draugr_round_shield";
		this.m.Name = "Barrowkin Round Shield";
		this.m.Description = "An old round wooden shield, larger than most round shields.";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = ::Math.rand(1, 5);
		this.updateVariant();
		this.m.Value = 60;
		this.m.MeleeDefense = 18;
		this.m.RangedDefense = 18;
		this.m.StaminaModifier = -15;
		this.m.Condition = 48;
		this.m.ConditionMax = 48;
	}

	function updateVariant()
	{
		local variant = this.m.Variant >= 10 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "shield_rf_draugr_round_" + variant;
		this.m.SpriteDamaged = this.m.Sprite + "_damaged";
		this.m.ShieldDecal = this.m.Sprite + "_destroyed";
		this.m.IconLarge = "shields/inventory_shield_rf_draugr_round_" + variant + ".png";
		this.m.Icon = "shields/icon_shield_rf_draugr_round_" + variant + ".png";
	}

	function onEquip()
	{
		this.shield.onEquip();
		this.addSkill(this.new("scripts/skills/actives/shieldwall"));
		this.addSkill(this.new("scripts/skills/actives/knock_back"));
	}
});

