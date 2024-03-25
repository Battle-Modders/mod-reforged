::Reforged.HooksMod.hook("scripts/items/tools/acid_flask_item", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Value = 275;
	}

	q.onPutIntoBag <- function()
    {
		local skill = ::new("scripts/skills/actives/rf_sling_acid_flask_skill");
		skill.setItem(this);
		this.addSkill(skill);
    }
});
