::Reforged.HooksMod.hook("scripts/retinue/follower", function(q) {
	q.m.Perks <- null
	q.create = @(__original) function()
	{
		__original();
		this.m.Perks = ::new("skills/rf_follower_skill_container");
	}
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
