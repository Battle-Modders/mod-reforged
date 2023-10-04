
::Reforged.HooksMod.hook("scripts/items/tools/acid_flask_item", function(q) {
	q.onPutIntoBag <- function()
    {
		local skill = ::new("scripts/skills/actives/rf_sling_acid_flask_skill");
		skill.setItem(this);
		this.addSkill(skill);
    }
});
