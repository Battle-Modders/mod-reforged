::Reforged.HooksMod.hookTree("scripts/entity/world/location", function(q) {
	q.onDropLootForPlayer = @(__original) { function onDropLootForPlayer( _lootTable )
	{
		// Named Weapon Loot drops in the Old Swordmaster origin have a chance to be converted to named swords.
		// TODO: Perhaps we should implement an onDropLootForPlayer function in starting_scenario
		// so that origins can modify the loot table.
		if (::World.Assets.getOrigin().getID() == "scenario.rf_old_swordmaster")
		{
			local swords = ::MSU.Class.WeightedContainer().addMany(1, [
				"scripts/items/weapons/named/named_sword",
				"scripts/items/weapons/named/named_greatsword",
				"scripts/items/weapons/named/named_fencing_sword",
				"scripts/items/weapons/named/named_rf_estoc",
				"scripts/items/weapons/named/named_rf_kriegsmesser",
				"scripts/items/weapons/named/named_rf_swordstaff"
			]);

			local lootContainer = this.m.Loot;
			foreach (item in clone lootContainer.getItems())
			{
				if (::IO.scriptFilenameByHash(item.ClassNameHash).find("/weapons/named") != null && ::Math.rand(1, 100) < 50)
				{
					lootContainer.remove(item);
					lootContainer.add(::new(swords.roll()));
				}
			}
		}

		__original(_lootTable);
	}}.onDropLootForPlayer;
});
::Reforged.HooksMod.hook("scripts/entity/world/location", function(q) {
	q.setBanner = @(__original) { function setBanner( _banner )
	{
		__original(_banner);
		this.adjustBannerOffset();
	}}.setBanner;

	q.onAfterInit = @(__original) { function onAfterInit()
	{
		__original();
		this.adjustBannerOffset();	// onAfterInit is called before deserialization, so this will only affect newly created locations
	}}.onAfterInit;

	q.onDeserialize = @(__original) { function onDeserialize(_in)
	{
		__original(_in);
		this.adjustBannerOffset();	// onAfterInit is called before deserialization, so we need this adjustment to catch all deserialized locations too
	}}.onDeserialize;

// New Functions
	q.adjustBannerOffset <- { function adjustBannerOffset()	// This has to be called everytime that a brush for the banner sprite is set because that will reset the previous offset
	{
		if (this.hasSprite("location_banner"))
		{
			this.getSprite("location_banner").setOffset(::createVec(0, ::Reforged.Config.UI.WorldBannerYOffset));
		}
	}}.adjustBannerOffset;
});
