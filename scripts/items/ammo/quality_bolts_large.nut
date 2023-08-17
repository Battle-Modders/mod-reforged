this.quality_bolts_large <- this.inherit("scripts/items/ammo/quality_bolts", {
	function create()
	{
		this.quality_bolts.create();
		this.m.ID = "ammo.quality_bolts_large";
		this.m.Name = "Large Quiver of Quality Bolts";
		this.m.Description = "A large quiver of higher quality bolts, required to use crossbows. Is automatically refilled after each battle if you have enough ammunition.";
		this.m.Icon = "ammo/rf_quality_quiver_04.png";
		this.m.IconEmpty = "ammo/quiver_04_empty.png";
		this.m.Value = 800;
		this.m.Ammo = 12;
		this.m.AmmoMax = 12;
		this.m.AmmoWeight = 0.50;
	}
});

