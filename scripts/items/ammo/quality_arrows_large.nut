this.quality_arrows_large <- this.inherit("scripts/items/ammo/quality_arrows", {
	function create()
	{
		this.quality_arrows.create();
		this.m.ID = "ammo.quality_arrows_large";
		this.m.Name = "Large Quiver of Quality Arrows";
		this.m.Description = "A large quiver of higher quality arrows, required to use bows of all kinds. Is automatically refilled after each battle if you have enough ammunition.";
		this.m.Icon = "ammo/rf_quality_quiver_03.png";
		this.m.IconEmpty = "ammo/quiver_03_empty.png";
		this.m.Value = 800;
		this.m.Ammo = 12;
		this.m.AmmoMax = 12;
		this.m.AmmoWeight = 0.50;
	}
});

