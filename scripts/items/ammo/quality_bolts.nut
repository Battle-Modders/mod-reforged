this.quality_bolts <- this.inherit("scripts/items/ammo/quality_ammunition", {
	function create()
	{
		this.quality_ammunition.create();
		this.m.ID = "ammo.quality_bolts";
		this.m.Name = "Quiver of Quality Bolts";
		this.m.Description = "A quiver of higher quality bolts, required to use crossbows. Is automatically refilled after each battle if you have enough ammunition.";
		this.m.Icon = "ammo/rf_quality_quiver_02.png";
		this.m.IconEmpty = "ammo/quiver_02_empty.png";
		this.m.AmmoType = ::Const.Items.AmmoType.Bolts;
        this.m.AmmoTypeName = "bolt";
		this.m.Value = 350;
		this.m.Ammo = 8;
		this.m.AmmoMax = 8;
        this.m.AmmoCost = 2;
		this.m.AmmoWeight = 0.33;
	}
});

