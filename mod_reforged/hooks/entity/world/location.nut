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

	q.onLeave = @(__original) function()
	{
		__original();
		::World.State.setPause(true);
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		if (!this.isHiddenToPlayer() && this.m.Troops.len() != 0 && this.getFaction() != 0)
		{
			ret.push({
				id = 100,
				type = "text",
				icon = "ui/icons/icon_contract_swords.png",
				text = format("Strength: %s / %s", ::MSU.Text.colorPositive(::World.State.getPlayer().getStrength()), ::MSU.Text.colorNegative(this.getStrength()))
			});
		}
		return ret;
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
