::Reforged.HooksMod.hook("scripts/items/weapons/greenskins/goblin_spiked_balls", function(q) {
	q.m.IconLargeFull <- "weapons/ranged/goblin_weapon_07.png";		// Same as Vanilla
	q.m.IconFull <-	"weapons/ranged/goblin_weapon_07_70x70.png";	// Same as Vanilla
	q.m.IconLargeEmpty <- "weapons/ranged/rf_goblin_weapon_07_empty.png";
	q.m.IconEmpty <- "weapons/ranged/rf_goblin_weapon_07_empty_70x70.png";

	q.create = @(__original) function()
	{
		__original();
		this.m.Reach = 0;
	}

	q.setAmmo = @(__original) function( _a )
	{
		__original(_a);
		if (this.m.Ammo > 0)
		{
			this.m.Name = "Bundle of Spiked Bolas";
			this.m.IconLarge = this.m.IconLargeFull;
			this.m.Icon = this.m.IconFull;
		}
		else
		{
			this.m.Name = "Bundle of Spiked Bolas (Empty)";
			this.m.IconLarge = this.m.IconLargeEmpty;
			this.m.Icon = this.m.IconEmpty;
		}

		this.updateAppearance();
	}
});
