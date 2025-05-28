::Reforged.HooksMod.hook("scripts/entity/world/location", function(q) {
	q.setBanner = @(__original) { function setBanner( _banner )
	{
		__original(_banner);
		this.adjustBannerOffset();
	}}.setBanner;

	q.onAfterInit = @(__original) { function onAfterInit()
	{
		__original();
		this.adjustBannerOffset();
	}}.onAfterInit;

// New Functions
	q.adjustBannerOffset <- { function adjustBannerOffset()	// This has to be called everytime that a brush for the banner sprite is set because that will reset the previous offset
	{
		if (this.hasSprite("location_banner"))
		{
			this.getSprite("location_banner").setOffset(::createVec(0, ::Reforged.Config.UI.WorldBannerYOffset));
		}
	}}.adjustBannerOffset;
});
