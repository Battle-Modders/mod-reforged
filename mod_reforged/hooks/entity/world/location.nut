::Reforged.HooksMod.hook("scripts/entity/world/location", function(q) {
	q.m.RF_BannerOffset <- ::createVec(0, ::Reforged.Config.UI.WorldBannerYOffset);

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
			this.getSprite("location_banner").setOffset(this.getScaledOffset());
		}
	}}.adjustBannerOffset;

	q.getScaledOffset <- { function getScaledOffset()
	{
		local scaleFactor = 1.0 + ::World.getCamera().Zoom / 12.0;	// 12.0 is the current maximum zoom factor in Vanilla
		return ::createVec(this.m.RF_BannerOffset.X * scaleFactor, this.m.RF_BannerOffset.Y * scaleFactor) ;
	}}.getScaledOffset;
});
