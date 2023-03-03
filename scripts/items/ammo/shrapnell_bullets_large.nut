this.shrapnell_bullets_large <- this.inherit("scripts/items/ammo/shrapnell_bullets", {
	function create()
	{
		this.shrapnell_bullets.create();
		this.m.ID = "ammo.shrapnell_bullets_large";
		this.m.Name = "Large Shrapnell Bullet Bag";
		this.m.Description = "A large bag of shrapnell bullets, used for arming exotic firearms. The projectiles split under high speed making it easier to hit your targets but reducing the strengh of the impact. Is automatically refilled after each battle if you have enough ammunition.";
		this.m.Icon = "ammo/rf_shrapnell_bullets_large.png";
		this.m.IconEmpty = "ammo/powder_bag_large_empty.png";
		this.m.Value = 1100;
		this.m.Ammo = 7;
		this.m.AmmoMax = 7;
        this.m.AmmoCost = 2;
        this.m.AmmoWeight = 0.5;
	}
});
