this.quality_arrows <- this.inherit("scripts/items/ammo/quality_ammunition", {
	function create()
	{
		this.quality_ammunition.create();
		this.m.ID = "ammo.quality_arrows";
		this.m.Name = "Quiver of Quality Arrows";
		this.m.Description = "A quiver of higher quality arrows, required to use bows of all kinds. Is automatically refilled after each battle if you have enough ammunition.";
		this.m.Icon = "ammo/rf_quality_quiver_01.png";
		this.m.IconEmpty = "ammo/quiver_01_empty.png";
		this.m.AmmoType = ::Const.Items.AmmoType.Arrows;
        this.m.AmmoTypeName = "arrow";
		this.m.Value = 350;
		this.m.Ammo = 8;
		this.m.AmmoMax = 8;
        this.m.AmmoCost = 2;
		this.m.AmmoWeight = 0.33;
	}
});

