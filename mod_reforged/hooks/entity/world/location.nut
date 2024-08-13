::Reforged.HooksMod.hook("scripts/entity/world/location", function(q) {
	q.setBanner = @(__original) function( _banner )
	{
		__original(_banner);
		this.adjustBannerOffset();
	}

	q.onAfterInit = @(__original) function()
	{
		__original();
		this.adjustBannerOffset();
	}

// New Functions
	q.adjustBannerOffset <- function()	// This has to be called everytime that a brush for the banner sprite is set because that will reset the previous offset
	{
		if (this.hasSprite("location_banner"))
		{
			this.getSprite("location_banner").setOffset(::createVec(0, ::Reforged.Config.UI.WorldBannerYOffset));
		}
	}
});
