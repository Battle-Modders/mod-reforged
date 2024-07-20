::Reforged.HooksMod.hook("scripts/retinue/follower", function(q) {
	q.getUIData <- function()
	{
		return {
			ImagePath = this.getImage() + ".png",
			ID = this.getID(),
			Name = this.getName(),
			Description = this.getDescription(),
			IsUnlocked = this.isUnlocked(),
			Cost = this.getCost(),
			Effects = this.getEffects(),
			Requirements = this.getRequirements(),
			Perks = {}
		};
	}
})
