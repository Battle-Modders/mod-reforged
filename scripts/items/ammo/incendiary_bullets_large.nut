this.incendiary_bullets_large <- this.inherit("scripts/items/ammo/incendiary_bullets", {
	function create()
	{
		this.incendiary_bullets.create();
		this.m.ID = "ammo.incendiary_bullets_large";
		this.m.Name = "Large Incendiary Bullet Bag";
		this.m.Description = "A large bag of incendiary bullets, used for arming exotic firearms. Is automatically refilled after each battle if you have enough ammunition.";
		this.m.Icon = "ammo/rf_incendiary_bullets_large.png";
		this.m.IconEmpty = "ammo/powder_bag_large_empty.png";
		this.m.Value = 1300;
		this.m.Ammo = 7;
		this.m.AmmoMax = 7;
        this.m.AmmoCost = 4;
        this.m.AmmoWeight = 0.5;
	}
});
