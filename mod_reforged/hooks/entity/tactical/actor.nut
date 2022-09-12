::mods_hookExactClass("entity/tactical/actor", function(o) {
	o.isDisarmed <- function()
	{
		local handToHand = this.getSkills().getSkillByID("actives.hand_to_hand");
		return handToHand != null && handToHand.isUsable();
	}
});
